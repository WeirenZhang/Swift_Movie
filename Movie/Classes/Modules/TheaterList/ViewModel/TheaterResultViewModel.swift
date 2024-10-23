//
//  VideoHallViewModel.swift
//  QYNews
//
//  Created by Insect on 2018/12/18.
//  Copyright © 2018 Insect. All rights reserved.
//

import Foundation
import RxURLNavigator
import MoyaResultValidate
import RxCocoa
import RxSwift

import Moya

final class TheaterResultViewModel: RefreshViewModel, NestedViewModelable {

    let input: Input
    let output: Output

    struct Input {

        let cinemaIdOb: AnyObserver<String>
    }

    struct Output {

        /// 视频分类
        let items: Driver<[TheaterDateItemModel]>
        /// 数据源
        let item: Driver<TheaterDateItemModel?>
    }

    /// 选择了新的视频种类
    private let cinema_id = PublishSubject<String>()

    /// 视频分类
    private let items = BehaviorRelay<[TheaterDateItemModel]>(value: [])

    private let item = BehaviorRelay<TheaterDateItemModel?>(value: nil)

    required init() {

        input = Input(cinemaIdOb: cinema_id.asObserver())
        
        output = Output(items: items.asDriver(),
                        item: item.asDriver())
        
        super.init()
    }

    override func transform() {
        super.transform()
        
        let loadNew = refresh(refreshOutput.headerRefreshing)

        // 数据源
        loadNew
            .map { $0 }
            .drive(items)
            .disposed(by: disposeBag)
        
        // 数据源
        loadNew
            .map { $0.isEmpty == false ? $0[0] : nil }
            .drive(item)
            .disposed(by: disposeBag)
  
        // success 下的刷新状态
        loadNew
            .mapTo(false)
            .drive(refreshInput.headerRefreshStateOb)
            .disposed(by: disposeBag)
    }
    
    private func refresh(_ refreshing: Driver<Void>) -> Driver<[TheaterDateItemModel]> {

        refreshing
            .map{ TheaterDateItemModel(date: "", data: []) }.drive(item).disposed(by: disposeBag)
        return refreshing.withLatestFrom(cinema_id.asDriverOnErrorJustComplete())
        .flatMapLatest { [unowned self] in
            self.request(cinema_id: $0)
        }.debug("Call loadNew API")
    }
}

extension TheaterResultViewModel {

    /// 加载视频
    func request(cinema_id: String) -> Driver<[TheaterDateItemModel]> {
        
        Api.getTheaterResultList(cinema_id: cinema_id)
            .request()
            .mapObject([TheaterDateItemModel].self)
            .trackActivity(loading)
            .trackError(refreshError)
            .asDriverOnErrorJustComplete()
    }
}
