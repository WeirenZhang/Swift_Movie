//
//  VideoPageViewModel.swift
//  QYNews
//
//  Created by Insect on 2018/12/5.
//  Copyright © 2018 Insect. All rights reserved.
//

import RxCocoa
import RxSwift

final class MovieTimeTabsViewModel: ViewModel {
    
    struct Input {
        let movie_id: String
    }
    
    struct Output {}
    
    /// 分类数据
    let items = BehaviorRelay<[MovieDateTabItemModel]>(value: [])
    
    let item = BehaviorRelay<MovieDateTabItemModel?>(value: nil)
}

extension MovieTimeTabsViewModel: ViewModelable {
    
    @discardableResult
    func transform(input: MovieTimeTabsViewModel.Input) -> MovieTimeTabsViewModel.Output {
        
        let loadNew = request(movie_id: input.movie_id).debug("Call loadNew API")
        
        // 获取视频分类
        loadNew
            .map { $0 }
            .drive(items)
            .disposed(by: disposeBag)
        
        loadNew
            .map { $0.isEmpty == false ? $0[0] : nil }
            .drive(item)
            .disposed(by: disposeBag)

        return Output()
    }
}

extension MovieTimeTabsViewModel {
    
    func request(movie_id: String) -> Driver<[MovieDateTabItemModel]> {
        
        return Api.getMovieDateResult(movie_id: movie_id)
            .request()
            .mapObject([MovieDateTabItemModel].self)
            .trackActivity(loading)
            .trackError(error)
            .asDriverOnErrorJustComplete()
    }
}
