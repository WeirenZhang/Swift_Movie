//
//   VideoListViewModel.swift
//  QYNews
//
//  Created by Insect on 2018/12/5.
//  Copyright © 2018 Insect. All rights reserved.
//

import Foundation
import RxCocoa

final class TheaterAreaViewModel: RefreshViewModel {
    
    struct Input {
        
    }
    
    struct Output {
        
        /// 数据源
        let items: Driver<[TheaterAreaModel]>
    }
}

extension TheaterAreaViewModel: ViewModelable {
    
    func transform(input: TheaterAreaViewModel.Input) -> TheaterAreaViewModel.Output {
        
        let elements = BehaviorRelay<[TheaterAreaModel]>(value: [])
        
        // 加载最新视频
        let loadNew = refreshOutput
            .headerRefreshing
            .flatMapLatest { [unowned self] in
                self.request()
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

extension TheaterAreaViewModel {
    
    /// 加载视频
    func request() -> Driver<[TheaterAreaModel]> {
        
        Api.getTheaterList
            .request()
            .mapObject([TheaterAreaModel].self)
            .trackActivity(loading)
            .trackError(refreshError)
            .asDriverOnErrorJustComplete()
    }
}
