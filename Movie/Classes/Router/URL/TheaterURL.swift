//
//  VideoHallURL.swift
//  QYNews
//
//  Created by Insect on 2019/1/31.
//  Copyright © 2019 Insect. All rights reserved.
//

import URLNavigator

enum TheaterURL {

    case List
    case Result
}

extension TheaterURL {

    var path: String {

        switch self {

        case .List:
            return "navigator://TheaterURL/List"
        case .Result:
            return "navigator://TheaterURL/Result"
        }
    }

    static func initRouter() {

        navigator.register(TheaterURL.List.path) { url, values, context in

            let context = context as? TheaterAreaModel
            let vc = TheaterListController(model: context!)
            return vc
        }

        navigator.register(TheaterURL.Result.path) { url, values, context in

            let context = context as? TheaterInfoModel
            let vc = TheaterTimeResultController(model: context!)
            return vc
        }
    }
}
