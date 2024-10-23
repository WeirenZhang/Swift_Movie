//
//  VideoURL.swift
//  QYNews
//
//  Created by Insect on 2019/1/31.
//  Copyright © 2019 Insect. All rights reserved.
//

import URLNavigator

enum MovieURL {
    
    /// 视频详情
    case InfoMain
    case Video
}

extension MovieURL {
    
    var path: String {
        
        switch self {
            
        case .InfoMain:
            return "navigator://MovieURL/InfoMain"
        case .Video:
            return "navigator://MovieURL/Video"
        }
    }
    
    static func initRouter() {
        
        navigator.register(MovieURL.InfoMain.path) { url, values, context in
            
            let context = context as? MovieListModel
            let vc = MovieInfoMainController(model: context!)
            return vc
        }
        
        navigator.register(MovieURL.Video.path) { url, values, context in
            
            let context = context as? VideoModel
            let vc = ABWebViewController()
            
            // Configure WebViewController
            vc.title = context?.title
            vc.URLToLoad = context!.href
            
            // Customize UI of progressbar
            vc.progressTintColor = UIColor.blue
            vc.trackTintColor = UIColor.white
            
            return vc
        }
    }
}


