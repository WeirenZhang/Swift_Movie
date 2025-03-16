//
//  ViewController.swift
//  Movie
//
//  Created by Mac on 2022/2/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var titleArray: Array = {
        return [["icon":"enl_1", "title": "本周新片"],
                ["icon":"enl_3", "title": "本期首輪"],
                ["icon":"enl_3", "title": "本期二輪"],
                ["icon":"enl_2", "title": "近期上映"],
                ["icon":"enl_2", "title": "新片快報"],
                ["icon":"enl_4", "title": "電影院"],
                ["icon":"enl_5", "title": "我的最愛"],
                ["icon":"enl_6", "title": "網路訂票"]]
    }()
    
    private lazy var collectionView: UICollectionView = {
        let lt = UICollectionViewFlowLayout()
        lt.minimumInteritemSpacing = 10
        lt.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: lt)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        return collectionView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(collectionView)
        view.backgroundColor = UIColor.white
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            
        } else {
            // Fallback on earlier versions
            navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        }
        
        title = "電影時刻表";
        
        collectionView.snp.makeConstraints {(make) in
            make.edges.equalTo(self.view.usnp.edges).priority(.low)
            make.top.equalToSuperview().offset(120)
        }
        
        collectionView.register(cellType: MineCollectionViewCell.self)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MineCollectionViewCell.self)
        cell.dict = titleArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor(Double(.screenWidth - 40.0) / 3.0)
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let vc = MovieListController(tab: "0", title: titleArray[indexPath.row]["title"]!)
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = MovieListController(tab: "1", title: titleArray[indexPath.row]["title"]!)
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = MovieListController(tab: "2", title: titleArray[indexPath.row]["title"]!)
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = MovieListController(tab: "3", title: titleArray[indexPath.row]["title"]!)
            navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = MovieListController(tab: "4", title: titleArray[indexPath.row]["title"]!)
            navigationController?.pushViewController(vc, animated: true)
        case 5:
            let vc = TheaterAreaController(title: titleArray[indexPath.row]["title"]!)
            navigationController?.pushViewController(vc, animated: true)
        case 6:
            let vc = MyFavouriteViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 7:
            let webViewController = ABWebViewController()
            // Configure WebViewController
            webViewController.title = "網路訂票"
            webViewController.URLToLoad = "https://www.ezding.com.tw/"
            
            // Customize UI of progressbar
            webViewController.progressTintColor = UIColor.blue
            webViewController.trackTintColor = UIColor.white
            
            navigationController?.pushViewController(webViewController, animated: true)
        default: break
        }
    }
}



