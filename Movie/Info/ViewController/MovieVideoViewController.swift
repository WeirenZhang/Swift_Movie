//
//  VideoViewController.swift
//  Movie
//
//  Created by Mac on 2022/3/31.
//

import UIKit
import SwiftSoup
import Kingfisher

class MovieVideoViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .plain)
        tw.backgroundColor = UIColor.white
        tw.tableFooterView = UIView()
        tw.delegate = self
        tw.dataSource = self
        tw.register(cellType: MovieVideoCell.self)
        return tw
    }()
    
    private var comicList = [[String:String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    convenience init(index: Int) {
        self.init(title: "View \(index)", content: "\(index)")
    }
    
    convenience init(title: String, id:  String) {
        self.init(title: title, content: id)
    }
    
    init(title: String, content: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ $0.edges.equalTo(self.view.usnp.edges) }
        
        ApiProvider.request(Api.movieinfo_main(id:content)) {
            result in
            var message = "Couldn't access API"
            if case let .success(response) = result {
                let jsonString = try? response.mapString()
                message = jsonString ?? message
                
                do {
                    let doc: Document = try SwiftSoup.parse(message)
                    
                    let box: Elements = try doc.getElementsByClass("l_box have_arbox _c")
                    if (box.count > 0) {
                        for title: Element in box.array() {
                            let video: String = try title.select("div.title").text()
                            print(video)
                            if (video.contains("預告")) {
                                
                                let ul: Elements = try title.select("ul.trailer_list > li")
                                
                                var dataSource = [String:String]()
                                for li: Element in ul.array() {
                                    
                                    let imgsrc: String = try li.select("img").attr("data-src")
                                    print(imgsrc)
                                    
                                    dataSource["imgsrc"] = imgsrc
                                    
                                    let ahref: String = try li.select("a").attr("href")
                                    print(ahref)
                                    
                                    dataSource["ahref"] = ahref
                                    
                                    let en: String = try li.getElementsByClass("text_truncate_2").text()
                                    print(en)
                                    
                                    dataSource["en"] = en
                                    
                                    self.comicList.append(dataSource)
                                }
                                
                                self.tableView.reloadData()
                                
                                break;
                            }
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
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

extension MovieVideoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MovieVideoCell.self)
        
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
        
        cell.titleLabel.text = dict["en"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let webViewController = ABWebViewController()
        let dict:Dictionary = comicList[indexPath.row]
        // Configure WebViewController
        webViewController.title = dict["en"]
        webViewController.URLToLoad = dict["ahref"]!
        
        // Customize UI of progressbar
        webViewController.progressTintColor = UIColor.blue
        webViewController.trackTintColor = UIColor.white
        
        navigationController?.pushViewController(webViewController, animated: true)
        
    }
}
