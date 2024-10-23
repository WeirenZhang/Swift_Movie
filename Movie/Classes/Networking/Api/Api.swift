//
//  API.swift
//  U17
//
//  Created by lyw on 2020/5/14.
//  Copyright © 2020 胡智钦. All rights reserved.
//

import Moya

enum Api {
    
    case getMovieList(page: Int, tab: String)
    case getTheaterList
    case getTheaterResultList(cinema_id: String)
    case getMovieInfo(movie_id: String)
    case getStoreInfo(movie_id: String)
    case getMovieDateResult(movie_id: String)
    case getVideo(movie_id: String)
}

extension Api: TargetType {
    
    var baseURL: URL { return URL(string: "https://script.google.com")! }
    
    var path: String {
        return "macros/s/AKfycbzNPN95_VIeYPTKF85yVS5oml_lUiVL0TUlQvuNj1krEUjUQFtBq_BY6eraap6zW2ZI/exec"
    }
    
    var method: Moya.Method { return .get }
    var task: Task {
        var parmeters: [String : Any] = [:]
        switch self {
        case let .getMovieList(page, tab):
            
            parmeters["page"] = page
            parmeters["type"] = "MovieList"
            parmeters["tab"] = tab
        case .getTheaterList:
            
            parmeters["type"] = "Area"
        case .getTheaterResultList(let cinema_id):
            
            parmeters["cinema_id"] = cinema_id
            parmeters["type"] = "TheaterResult"
        case .getMovieInfo(let movie_id):
            
            parmeters["movie_id"] = movie_id
            parmeters["type"] = "MovieInfo"
        case .getStoreInfo(let movie_id):
            
            parmeters["movie_id"] = movie_id
            parmeters["type"] = "StoreInfo"
        case .getMovieDateResult(let movie_id):

            parmeters["movie_id"] = movie_id
            parmeters["type"] = "MovieTime"
        case .getVideo(let movie_id):
            
            parmeters["movie_id"] = movie_id
            parmeters["type"] = "Video"
        }
        
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? { return nil }
}

