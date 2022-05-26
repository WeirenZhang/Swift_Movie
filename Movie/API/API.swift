//
//  API.swift
//  U17
//
//  Created by lyw on 2020/5/14.
//  Copyright © 2020 胡智钦. All rights reserved.
//

import Moya
import HandyJSON
import MBProgressHUD

let LoadingPlugin = NetworkActivityPlugin { (type, target) in
    guard let vc = topVC else { return }
    switch type {
    case .began:
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: vc.view, animated: false)
            MBProgressHUD.showAdded(to: vc.view, animated: true)
        }
    case .ended:
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: vc.view, animated: true)
        }
    }
}

let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<Api>.RequestResultClosure) -> Void in
    
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 20
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}

let ApiProvider = MoyaProvider<Api>(requestClosure: timeoutClosure)

let ApiLoadingProvider = MoyaProvider<Api>(requestClosure: timeoutClosure, plugins: [LoadingPlugin])

enum Api {
    
    // 本週新片
    case movie_thisweek(page: Int)
    // 上映中
    case movie_intheaters(page: Int)
    // 即將上映
    case movie_comingsoon(page: Int)
    //章节内容
    case theater_list
    // 我的收藏
    case theater_result(id: Int)
    // 我的书单
    case movieinfo_main(id: String)
    // 阅读历史
    case moviesummary_main(url: String)
    
    case movietimeresult_main(id: String, date: String)
}

extension Api: TargetType {
    
    var baseURL: URL { return URL(string: "https://movies.yahoo.com.tw/")! }
    
    var path: String {
        switch self {
        case .movie_thisweek: return "movie_thisweek.html"
        case .movie_intheaters: return "movie_intheaters.html"
        case .movie_comingsoon: return "movie_comingsoon.html"
        case .theater_list: return "theater_list.html"
            
        case .theater_result(let id): return "theater_result.html/id=\(id)"
        case .movieinfo_main(let id): return "movieinfo_main.html/id=\(id)"
        case .moviesummary_main(let url): return url
        case .movietimeresult_main(let id, let date): return "ajax/get_schedule_by_movie"
        }
    }
    
    var method: Moya.Method { return .get }
    var task: Task {
        var parmeters: [String : Any] = [:]
        switch self {
        case .movie_thisweek(let page):
            parmeters["page"] = page
            
        case .movie_intheaters(let page):
            parmeters["page"] = page
            
        case .movie_comingsoon(let page):
            parmeters["page"] = page
            
        case .movietimeresult_main(let id, let date):
            parmeters["movie_id"] = id
            parmeters["date"] = date
            parmeters["mode"] = "movie-showtime"
            parmeters["region_id"] = ""
            parmeters["theater_id"] = ""
            parmeters["datetime"] = ""
            parmeters["movie_type_id"] = ""
            
        default: break
        }
        
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? { return nil }
}

