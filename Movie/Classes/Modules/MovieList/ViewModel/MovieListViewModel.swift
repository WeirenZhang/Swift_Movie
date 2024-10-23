//
//   VideoListViewModel.swift
//  QYNews
//
//  Created by Insect on 2018/12/5.
//  Copyright © 2018 Insect. All rights reserved.
//

import Foundation
import RxCocoa

final class MovieListViewModel: RefreshViewModel {
    
    struct Input {
        /// 视频分类
        let tab: String
    }
    
    struct Output {
        
        /// 数据源
        let items: Driver<[MovieListModel]>
    }
}

extension MovieListViewModel: ViewModelable {
    
    func transform(input: MovieListViewModel.Input) -> MovieListViewModel.Output {
        
        let elements = BehaviorRelay<[MovieListModel]>(value: [])
        
        var page = 1
        
        // 加载最新视频
        let loadNew = refreshOutput
            .headerRefreshing
            .then(page = 1)
            .flatMapLatest { [unowned self] in
                self.request(page: page, tab: input.tab)
            }.debug("Call loadNew API")
        
        
        // 加载更多视频
        let loadMore = refreshOutput
            .footerRefreshing
            .then(page += 1)
            .flatMapLatest { [unowned self] in
                self.request(page: page, tab: input.tab)
            }.debug("Call loadMore API")
        
        // 数据源
        loadNew
            .drive(elements)
            .disposed(by: disposeBag)
        
        loadMore
            .drive(elements.append)
            .disposed(by: disposeBag)
        
        // success 下的刷新状态
        loadNew
            .mapTo(false)
            .drive(refreshInput.headerRefreshStateOb)
            .disposed(by: disposeBag)
        
        Driver.merge(
            loadNew.mapToFooterStateDefault(),
            loadMore.map { [unowned self] in
                self.footerState($0.count > 0 ? true : false)
            }
        )
        .startWith(.hidden)
        .drive(refreshInput.footerRefreshStateOb)
        .disposed(by: disposeBag)
        
        let output = Output(items: elements.asDriver())
        return output
    }
}

extension MovieListViewModel {
    
    /// 加载视频
    func request(page: Int, tab: String) -> Driver<[MovieListModel]> {
        
        Api.getMovieList(page: page, tab: tab)
            .request()
            .mapObject([MovieListModel].self)
            .trackActivity(loading)
            .trackError(refreshError)
            .asDriverOnErrorJustComplete()
    }
}
