//
//  LibsManager.swift
//  QYNews
//
//  Created by Insect on 2019/1/28.
//  Copyright © 2019 Insect. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Kingfisher
import RxNetwork
import Moya
import Toast_Swift
import MoyaResultValidate

class LibsManager {

    static func setupLibs(with window: UIWindow? = nil) {

        setupNetwork()
        setupRouter()
        setupToast()
        setupReachability()
    }

    // MARK: - Kingfisher
    static func setupKingfisher() {

        // 15 sec
        ImageDownloader.default.downloadTimeout = Configs.Time.imageDownloadTimeout
//        ImageCache.default.maxMemoryCost = 1
    }

    // MARK: - RxNetwork
    static func setupNetwork() {

        Network.Configuration.default.timeoutInterval = Configs.Time.netWorkTimeout
        Network.Configuration.default.plugins = [MoyaResultValidatePlugin()]
    }

    static func setupRouter() {
        NavigationMap.initRouter()
    }

    static func setupToast() {
        ToastManager.shared.position = .center
        ToastManager.shared.style.messageFont = .systemFont(ofSize: 18)
    }

    static func setupReachability() {
        ReachabilityManager.shared.startNotifier()
    }
}
