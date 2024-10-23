//
//  VideoViewModel.swift
//  Movie
//
//  Created by User on 2024/10/2.
//

import Foundation
import RxCocoa

final class VideoViewModel: RefreshViewModel {
    
    struct Input {
        let movie_id: String
    }
    
    struct Output {
        
        /// 数据源
        let items: Driver<[VideoModel]>
    }
}

extension VideoViewModel: ViewModelable {
    
    func transform(input: VideoViewModel.Input) -> VideoViewModel.Output {
        
        let elements = BehaviorRelay<[VideoModel]>(value: [])
        
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

extension VideoViewModel {
    
    /// 加载视频
    func request(movie_id: String) -> Driver<[VideoModel]> {
        
        Api.getVideo(movie_id: movie_id)
            .request()
            .mapObject([VideoModel].self)
            .trackActivity(loading)
            .trackError(refreshError)
            .asDriverOnErrorJustComplete()
    }
}
