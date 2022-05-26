//
//  MovieInfoMainViewController.swift
//  Movie
//
//  Created by Mac on 2022/3/31.
//

import UIKit
import SwiftSoup
import Kingfisher

class MovieInfoMainViewController: UIViewController {
    
    private var comicList = [String]()
    
    private var height: Int = 0
    
    private lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .plain)
        tw.backgroundColor = UIColor.white
        tw.tableFooterView = UIView()
        tw.delegate = self
        tw.dataSource = self
        return tw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.black
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints{ $0.edges.equalTo(self.view.usnp.edges) }
        
        self.height = Int((UIScreen.main.bounds.width * 325) / 228)
    }
    
    convenience init(title: String, id:  String) {
        self.init(title: title, content: id)
    }
    
    init(title: String, content: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
        
        ApiProvider.request(Api.movieinfo_main(id:content)) {
            result in
            var message = "Couldn't access API"
            if case let .success(response) = result {
                let jsonString = try? response.mapString()
                message = jsonString ?? message
                
                do {
                    let doc: Document = try SwiftSoup.parse(message)
                    
                    let img: Element = try doc.select(".movie_intro_foto > img").first()!
                    let img_src: String = try img.attr("src")
                    print("img_src " + img_src)
                    
                    self.comicList.append(img_src)
                    
                    let h1: String = try doc.getElementsByClass("movie_intro_info_r").select("h1").text()
                    
                    print(h1)
                    
                    let h3: String = try doc.getElementsByClass("movie_intro_info_r").select("h3").text()
                    
                    print(h3)
                    
                    self.comicList.append(h1 + "\n" + h3)
                    
                    let icon: Element = try doc.select(".movie_intro_info_r > div").first()!
                    let icon_name: String = try icon.className()
                    print("icon_name " + icon_name)
                    
                    self.comicList.append(icon_name)
                    
                    let els: Elements = try doc.select("div.movie_intro_info_r > span")
                    
                    let release_date: String = try els[0].text()
                    print(release_date)
                    
                    self.comicList.append(release_date)
                    
                    let level_name_box: String = try doc.getElementsByClass("level_name_box").text()
                    print(level_name_box)
                    
                    self.comicList.append(level_name_box)
                    
                    let length: String = try els[1].text()
                    print(length)
                    self.comicList.append(length)
                    
                    let els1: Elements = try doc.select("span.movie_intro_list")
                    
                    let director: String = try els1[0].text()
                    print(director)
                    self.comicList.append(director)
                    
                    let actor: String = try els1[1].text()
                    print(actor)
                    self.comicList.append(actor)
                    
                    self.tableView.reloadData()
                    
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

extension MovieInfoMainViewController: UITableViewDelegate, UITableViewDataSource {
    // 必須實作的方法：每一組有幾個 cell
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // 有幾組 section
    func numberOfSections(in tableView: UITableView) -> Int {
        return comicList.count
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.white
    }
    
    // 每個 section 的標題
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        if section == 0 {
            
        } else if section == 1 {
            title = "電影名稱"
        } else if section == 2 {
            title = "電影分級"
        } else if section == 3 {
            title = "上映日期"
        } else if section == 4 {
            title = "電影類型"
        } else if section == 5 {
            title = "電影長度"
        } else if section == 6 {
            title = "導演"
        } else if section == 7 {
            title = "演員"
        }
        return title
    }
    
    // 設置 cell 的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return CGFloat(self.height)
        } else if indexPath.section == 2 {
            return 55
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell" + String(indexPath.section))
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell" + String(indexPath.section))
        }
        
        cell?.selectionStyle = .none
        cell?.backgroundColor = UIColor.white
        cell?.textLabel?.textColor = UIColor.black
        
        // 顯示的內容
        if indexPath.section == 0 {
            let iconView: UIImageView = {
                let iw = UIImageView()
                iw.contentMode = .scaleAspectFill
                iw.clipsToBounds = true
                return iw
            }()
            
            cell!.addSubview(iconView)
            iconView.snp.makeConstraints {
                $0.left.top.bottom.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
                $0.width.equalTo(UIScreen.main.bounds.width)
            }
            
            let url = URL(string: comicList[indexPath.section] )
            KF.url(url)
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .onProgress { receivedSize, totalSize in  }
                .onSuccess { result in  }
                .onFailure { error in }
                .set(to: iconView)
            
        } else if indexPath.section == 2 {
            let url = URL(string: "https://s.yimg.com/cv/ae/movies/" + comicList[indexPath.section] + ".png" )
            //cell.layoutMargins = UIEdgeInsets.zero
            //cell.preservesSuperviewLayoutMargins = false
            cell?.imageView?.kf.setImage(with: url)
        } else {
            cell?.textLabel?.numberOfLines = 0
            if let myLabel = cell?.textLabel {
                myLabel.text = comicList[indexPath.section]
            }
        }
        
        return cell!
    }
}
