//
//  NewMoviesController.swift
//  Movie
//
//  Created by Mac on 2022/3/17.
//

import UIKit
import SwiftSoup
import Kingfisher
import ESPullToRefresh

class MovieThisWeekController: UIViewController {
    
    private var comicList = [[String:String]]()
    
    private var page: Int = 1
    
    private lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .plain)
        tw.backgroundColor = UIColor.white
        tw.tableFooterView = UIView()
        tw.delegate = self
        tw.dataSource = self
        tw.register(cellType: UComicTCell.self)
        return tw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        title = "本周新片";
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ $0.edges.equalTo(self.view.usnp.edges) }
        
        ApiLoadingProvider.request(Api.movie_thisweek(page:page)) {
            result in
            var message = "Couldn't access API"
            if case let .success(response) = result {
                let jsonString = try? response.mapString()
                message = jsonString ?? message
                
                do {
                    let doc: Document = try SwiftSoup.parse(message)
                    
                    let els: Elements = try doc.select("ul.release_list > li")
                    
                    for link: Element in els.array() {
                        
                        var dataSource = [String:String]()
                        
                        print(self.comicList.count)
                        let imgsrc: String = try link.getElementsByClass("release_foto").select("img").attr("data-src")
                        print(imgsrc)
                        
                        dataSource["imgsrc"] = imgsrc
                        
                        let ahref: String = try link.getElementsByClass("release_foto").select("a").attr("href")
                        let ids = ahref.split(separator: "-")
                        print(String(ids[ids.count - 1]))
                        dataSource["ahref"] = String(ids[ids.count - 1])
                        
                        let en: String = try link.getElementsByClass("en").select("a").text()
                        print(en)
                        
                        dataSource["en"] = en
                        
                        let release_movie_name: String = try link.getElementsByClass("release_movie_name").select("a").text()
                        let str = release_movie_name
                        print(str.replacingOccurrences(of: en, with: ""))
                        
                        dataSource["release_movie_name"] = str.replacingOccurrences(of: en, with: "")
                        
                        let release_movie_time: String = try link.getElementsByClass("release_movie_time").text()
                        print(release_movie_time)
                        
                        dataSource["release_movie_time"] = release_movie_time
                        
                        self.comicList.append(dataSource)
                    }
                    
                    self.tableView.reloadData()
                    
                } catch Exception.Error(let type, let message) {
                    print(message)
                } catch {
                    print("error")
                }
            }
        }
        
        self.tableView.es.addPullToRefresh {
            [unowned self] in
            /// Do anything you want...
            /// ...
            /// Stop refresh when your job finished, it will reset refresh footer if completion is true
            loadData(more: false)
            /// Set ignore footer or not
            //self.tableView.es.stopPullToRefresh(completion: true, ignoreFooter: false)
        }
        
        self.tableView.es.addInfiniteScrolling {
            [unowned self] in
            /// Do anything you want...
            /// ...
            /// If common end
            loadData(more: true)
            //self.tableView.es.stopLoadingMore()
            /// If no more data
            //self.tableView.es.noticeNoMoreData()
        }
    }
    
    @objc private func loadData(more: Bool) {
        page = (more ? ( page + 1) : 1)
        
        ApiProvider.request(Api.movie_thisweek(page:page)) {
            result in
            var message = "Couldn't access API"
            if case let .success(response) = result {
                let jsonString = try? response.mapString()
                message = jsonString ?? message
                
                if !more {
                    self.comicList.removeAll()
                }
                
                do {
                    let doc: Document = try SwiftSoup.parse(message)
                    
                    let els: Elements = try doc.select("ul.release_list > li")
                    
                    var dataSource = [String:String]()
                    for link: Element in els.array() {
                        
                        print(self.comicList.count)
                        let imgsrc: String = try link.getElementsByClass("release_foto").select("img").attr("data-src")
                        print(imgsrc)
                        
                        dataSource["imgsrc"] = imgsrc
                        
                        let ahref: String = try link.getElementsByClass("release_foto").select("a").attr("href")
                        let ids = ahref.split(separator: "-")
                        
                        dataSource["ahref"] = String(ids[ids.count - 1])
                        
                        let en: String = try link.getElementsByClass("en").select("a").text()
                        print(en)
                        
                        dataSource["en"] = en
                        
                        let release_movie_name: String = try link.getElementsByClass("release_movie_name").select("a").text()
                        let str = release_movie_name
                        print(str.replacingOccurrences(of: en, with: ""))
                        
                        dataSource["release_movie_name"] = str.replacingOccurrences(of: en, with: "")
                        
                        let release_movie_time: String = try link.getElementsByClass("release_movie_time").text()
                        print(release_movie_time)
                        
                        dataSource["release_movie_time"] = release_movie_time
                        
                        self.comicList.append(dataSource)
                    }
                    
                    if !more {
                        self.tableView.es.stopPullToRefresh()
                        self.tableView.reloadData()
                    } else {
                        if (els.count > 0) {
                            self.tableView.es.stopLoadingMore()
                            self.tableView.reloadData()
                        } else {
                            self.tableView.es.noticeNoMoreData()
                        }
                    }
                    
                } catch Exception.Error(let type, let message) {
                    print(message)
                } catch {
                    print("error")
                }
            }
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}

extension MovieThisWeekController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UComicTCell.self)
        
        let dict:Dictionary = comicList[indexPath.row]
        //cell.spinnerName = spinnerName
        //cell.indexPath = indexPath
        
        let url = URL(string: dict["imgsrc"] ?? "")
        KF.url(url)
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .onProgress { receivedSize, totalSize in  }
            .onSuccess { result in  }
            .onFailure { error in }
            .set(to: cell.iconView)
        
        cell.titleLabel.text = dict["release_movie_name"]
        cell.subTitleLabel.text = dict["en"]
        cell.descLabel.text = dict["release_movie_time"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieMainViewController(dict: comicList[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}
