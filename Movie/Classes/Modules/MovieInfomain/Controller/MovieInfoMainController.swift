//
//  TabBarController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/23.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit
import Hero
import SQLite

class MovieInfoMainController: UITabBarController {
    // MARK: - LifeCycle
    
    private var model: MovieListModel
    
    init(model: MovieListModel) {
        
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func myRightSideBarButtonItemTapped(_ sender:UIBarButtonItem!)
    {
        do {
            let count = try db?.scalar(movie.filter(ahref == model.id).count)
            
            if (count! == 0) {
                let rowid = try db?.run(movie.insert(ahref <- model.id, imgsrc <- model.thumb, release_movie_name <- model.title, en <- model.en, release_movie_time <- model.release_movie_time))
                print("inserted id: \(rowid!)")
                self.navigationController?.view.makeToast("成功加入我的最愛", duration: 1.0, position: .top)
                let name = Notification.Name(rawValue: MovieMyFavouriteNotificationKey)
                NotificationCenter.default.post(name: name, object: nil)
            } else {
                self.navigationController?.view.makeToast("我的最愛已經有了", duration: 1.0, position: .top)
            }
        } catch {
            print("insertion failed: \(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = self.model.title;
        
        let RightBarButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.myRightSideBarButtonItemTapped(_:)))
        
        let largeFont = UIFont.systemFont(ofSize: 34)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        
        RightBarButton.image = UIImage(systemName: "heart", withConfiguration: configuration)
        
        self.navigationItem.rightBarButtonItem = RightBarButton
        
        seUpTabBarAttr()
        
        guard
            let jsonPath = R.file.movieInfoMainVCSettingsJson()?.path,
            let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)),
            let anyObject = try? JSONSerialization.jsonObject(with: jsonData,
                                                              options: .mutableContainers),
            let dictArray: [[String: Any]] = anyObject as? [[String: Any]]
        else {
            return
        }
        
        for dict in dictArray {
            let vcName = dict["vcName"] as? String
            let normalImage = dict["normalImage"] as? String
            let selectedImage = dict["selectedImage"] as? String
            let title = dict["title"] as? String
            let navigationName = dict["navigationName"] as? String
            
            addChildVc(vcName: vcName,
                       title: title,
                       normalImage: normalImage,
                       selectedImage: selectedImage,
                       navigationName: navigationName)
        }
    }
    
    func getUIViewController(vcName: String, model: MovieListModel) -> UIViewController? {
        let className = Bundle.main.infoDictionary!["CFBundleName"] as! String + "." + vcName
        
        switch vcName {
        case "MovieInfoViewController":
            let aClass = NSClassFromString(className) as! MovieInfoViewController.Type
            let vc = aClass.init(model: model)
            return vc
        case "StoreInfoViewController":
            let aClass = NSClassFromString(className) as! StoreInfoViewController.Type
            let vc = aClass.init(model: model)
            return vc
        case "MovieTimeTabsViewController":
            let aClass = NSClassFromString(className) as! MovieTimeTabsViewController.Type
            let vc = aClass.init(model: model)
            return vc
        case "VideoViewController":
            let aClass = NSClassFromString(className) as! VideoViewController.Type
            let vc = aClass.init(model: model)
            return vc
        default:
            let vc: UIViewController = vcName.classObject() as! UIViewController
            return vc
        }
    }
    
    // 添加子控制器
    private func addChildVc(vcName: String?,
                            title: String?,
                            normalImage: String?,
                            selectedImage: String?,
                            navigationName: String?) {
        guard
            let vcName = vcName,
            let childVc: UIViewController = getUIViewController(vcName: vcName, model: self.model)
        else {
            assert(false, "UIViewController not init")
            return
        }
        
        childVc.tabBarItem.image = UIImage(systemName: normalImage ?? "")
        childVc.tabBarItem.selectedImage = UIImage(systemName: selectedImage ?? "")
        childVc.tabBarItem.title = title
        
        if
            let navigationName = navigationName,
            let navigation: UINavigationController.Type = navigationName.classType() {
            addChild(navigation.init(rootViewController: childVc))
        } else {
            addChild(childVc)
        }
    }
    
    // 设置 TabBar 属性
    private func seUpTabBarAttr() {
        if #available(iOS 13.0, *) {
            tabBar.tintColor = UIColor.main
            tabBar.unselectedItemTintColor = UIColor.tabBarNormal
        } else {
            UITabBarItem.appearance()
                .setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.tabBarNormal], for: .normal)
            UITabBarItem.appearance()
                .setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.main], for: .selected)
        }
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
        tabBar.hero.modifiers = [.useGlobalCoordinateSpace,
                                 .useNoSnapshot,
                                 .zPosition(10),
                                 .translate(x: 0, y: 100, z: 0)]
    }
    
    deinit {
        print("deinit: \(self)")
    }
}
