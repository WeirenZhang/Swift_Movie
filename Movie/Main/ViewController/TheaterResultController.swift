//
//  TheaterResultController.swift
//  Movie
//
//  Created by Mac on 2022/4/4.
//

import UIKit
import SwiftSoup
import Kingfisher
import SQLite
import Toast_Swift

class TheaterResultController: UIViewController {
    
    private var comicList0 = [String:String]()
    private var comicList = [[String:String]]()
    private var comicList1 = [[String]]()
    private var comicList2 = [[String]]()
    private var id: Int = 1
    
    private lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .plain)
        tw.backgroundColor = UIColor.white
        tw.tableFooterView = UIView()
        tw.delegate = self
        tw.dataSource = self
        //tw.rowHeight = UITableView.automaticDimension
        tw.register(cellType: TheaterResultCell.self)
        return tw
    }()
    
    convenience init(dict: [String:String]) {
        self.init()
        
        self.comicList0 = dict
        
        let name: String = dict["name"]!
        title = name
        
        let href: String = dict["href"]!
        
        self.id = Int(href) ?? 0
    }
    
    @objc func myLeftSideBarButtonItemTapped(_ sender:UIBarButtonItem!)
    {
        print(self.id)
        print(self.comicList0["name"]!)
        print(self.comicList0["tel"] ?? "")
        print(self.comicList0["adds"] ?? "")
        
        do {
            let count = try db?.scalar(theater.filter(href == String(self.id)).count)
            
            if (count! == 0) {
                let rowid = try db?.run(theater.insert(href <- String(self.id), name <- self.comicList0["name"]!, tel <- self.comicList0["tel"] ?? "", adds <- self.comicList0["adds"] ?? ""))
                print("inserted id: \(rowid!)")
                self.navigationController?.view.makeToast("成功加入我的最愛", duration: 1.0, position: .top)
            } else {
                self.navigationController?.view.makeToast("我的最愛已經有了", duration: 1.0, position: .top)
            }
        } catch {
            print("insertion failed: \(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Image needs to be added to project.
        let buttonIcon = UIImage(named: "favorite")
        
        let leftBarButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.myLeftSideBarButtonItemTapped(_:)))
        leftBarButton.image = buttonIcon
        
        if (self.comicList0["name"]! != "") {
            self.navigationItem.rightBarButtonItem = leftBarButton
        }
        
        self.view.backgroundColor = UIColor.white
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ $0.edges.equalTo(self.view.usnp.edges) }
        
        // Do any additional setup after loading the view.
        
        ApiLoadingProvider.request(Api.theater_result(id: self.id)) {
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
                        var dataSource1 = [String]()
                        var dataSource2 = [String]()
                        
                        let icon: Element = try link.select(".release_info > div").first()!
                        let icon_name: String = try icon.className()
                        print("icon_name " + icon_name)
                        dataSource["icon_name"] = icon_name
                        
                        
                        let ahref: String = try link.select(".release_foto > a").attr("href")
                        let ids = ahref.split(separator: "-")
                        print(String(ids[ids.count - 1]))
                        dataSource["ahref"] = String(ids[ids.count - 1])
                        
                        let img: String = try link.select(".release_foto > a > img").attr("src")
                        print("imgsrc " + img)
                        dataSource["imgsrc"] = img
                        
                        let release_movie_name: String = try link.select(".release_movie_name > .theaterlist_name > a").text()
                        print("release_movie_name " + release_movie_name)
                        dataSource["release_movie_name"] = release_movie_name
                        
                        let tapboxs: Elements = try link.select(".theaterlist_name > .tapbox > div")
                        for tapbox: Element in tapboxs.array() {
                            let tapbox: String = try  tapbox.text()
                            print("tapbox " +  tapbox)
                            dataSource1.append(tapbox)
                        }
                        
                        let release_movie_en: String = try link.select(".release_movie_name > .en > a").text()
                        print("en " + release_movie_en)
                        dataSource["en"] = release_movie_en
                        dataSource["release_movie_time"] = ""
                        
                        let theater_times: Elements = try link.select(".theater_time > li")
                        for theater_time: Element in theater_times.array() {
                            let theater_time: String = try theater_time.text()
                            print("theater_time " +  theater_time)
                            dataSource2.append(theater_time)
                        }
                        self.comicList.append(dataSource)
                        self.comicList1.append(dataSource1)
                        self.comicList2.append(dataSource2)
                    }
                    
                    self.tableView.reloadData()
                    
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

extension TheaterResultController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TheaterResultCell.self)
        
        let dict:Dictionary = comicList[indexPath.row]
        let dict1:[String] = comicList1[indexPath.row]
        let dict2:[String] = comicList2[indexPath.row]
        
        let url = URL(string: dict["imgsrc"] ?? "")
        KF.url(url)
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .onProgress { receivedSize, totalSize in  }
            .onSuccess { result in  }
            .onFailure { error in }
            .set(to: cell.iconView)
        
        let url1 = URL(string: "https://s.yimg.com/cv/ae/movies/" + (dict["icon_name"] ?? "") + ".png")
        KF.url(url1)
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .onProgress { receivedSize, totalSize in  }
            .onSuccess { result in  }
            .onFailure { error in }
            .set(to: cell.iconView1)
        
        cell.titleLabel.text = dict["release_movie_name"]
        cell.subTitleLabel.text = dict["en"]
        
        //下面这两个语句一定要添加，否则第一屏显示的collection view尺寸，以及里面的单元格位置会不正确
        cell.frame = tableView.bounds
        cell.layoutIfNeeded()
        
        cell.setCell(tapbox_cells: dict1, theater_times_cells: dict2)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieMainViewController(dict: comicList[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}
