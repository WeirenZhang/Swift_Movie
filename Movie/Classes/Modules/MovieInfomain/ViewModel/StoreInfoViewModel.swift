//
//  VideoViewModel.swift
//  Movie
//
//  Created by User on 2024/10/2.
//

import Foundation
import RxCocoa

final class StoreInfoViewModel: RefreshViewModel {
    
    struct Input {
        let movie_id: String
    }
    
    struct Output {
        
        /// 数据源
        let items: Driver<[StoreInfoModel]>
    }
}

extension StoreInfoViewModel: ViewModelable {
    
    func transform(input: StoreInfoViewModel.Input) -> StoreInfoViewModel.Output {
        
        let elements = BehaviorRelay<[StoreInfoModel]>(value: [])
        
        // 加载最新视频
        let loadNew = refreshOutput
            .headerRefreshing
            .flatMapLatest { [unowned self] in
                self.request(movie_id: input.movie_id)
            }.debug("Call loadNew API")
        
        // 数据源
        loadNew
            .drive(elements)
            .disposed(by: disposeBag)
        
        // success 下的刷新状态
        loadNew
            .mapTo(false)
            .drive(refreshInput.headerRefreshStateOb)
            .disposed(by: disposeBag)
        
        let output = Output(items: elements.asDriver())
        return output
    }
}

extension StoreInfoViewModel {
    
    /// 加载视频
    func request(movie_id: String) -> Driver<[StoreInfoModel]> {
        
        Api.getStoreInfo(movie_id: movie_id)
            .request()
            .mapObject([StoreInfoModel].self)
            .trackActivity(loading)
            .trackError(refreshError)
            .asDriverOnErrorJustComplete()
    }
}
