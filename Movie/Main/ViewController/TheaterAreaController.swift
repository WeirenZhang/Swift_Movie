//
//  TheaterListController.swift
//  Movie
//
//  Created by Mac on 2022/3/26.
//

import UIKit
import SwiftSoup

class TheaterAreaController: UIViewController {
    
    private var comicList = [String]()
    private var comicList1 = [String:[[String:String]]]()
    
    private lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .plain)
        tw.backgroundColor = UIColor.white
        tw.tableFooterView = UIView()
        tw.delegate = self
        tw.dataSource = self
        tw.register(
          UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tw
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        title = "電影院";
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ $0.edges.equalTo(self.view.usnp.edges) }

        // Do any additional setup after loading the view.
        
        ApiLoadingProvider.request(Api.theater_list) {
            result in
            var message = "Couldn't access API"
            if case let .success(response) = result {
                let jsonString = try? response.mapString()
                message = jsonString ?? message
                
                do {
                    let doc: Document = try SwiftSoup.parse(message)
                    
                    let els: Elements = try doc.select(".theater_content")
                    
                    for link: Element in els.array() {
 
                        let theater_top: String = try link.getElementsByClass("theater_top").text()
                        //print(theater_top)
                        self.comicList.append(theater_top)
                        
                        var dataSource = [[String:String]]()
                        
                        let els1: Elements = try link.select("ul > li")
                        for link1: Element in els1.array() {
                        
                            var dataSource1 = [String:String]()
                            let name: String = try link1.getElementsByClass("name").text()
                            if name != "" {
                                //print(" " + name)
                                dataSource1["name"] = name
                            }
                            let href: String = try link1.getElementsByClass("name").select("a").attr("href")
                            if href != "" {
                                //print(" " + href)
                                
                                let ids = href.split(separator: "=")
                                print(String(ids[ids.count - 1]))
                                dataSource1["href"] = String(ids[ids.count - 1])
                            }
                            let adds: String = try link1.getElementsByClass("adds").text()
                            if adds != "" {
                                //print(" " + adds)
                                dataSource1["adds"] = adds
                            }
                            let tel: String = try link1.getElementsByClass("tel").text()
                            if tel != "" {
                                //print(" " + tel)
                                dataSource1["tel"] = tel
                            }
                            if (name != "") {
                                dataSource.append(dataSource1)
                            }
                        }
                        self.comicList1[theater_top] = dataSource
                        self.tableView.reloadData()
                    }
                    
                } catch Exception.Error(let type, let message) {
                    print(message)
                } catch {
                    print("error")
                }
            }
        }
    }
}

extension TheaterAreaController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
              tableView.dequeueReusableCell(
                withIdentifier: "Cell", for: indexPath) as
                UITableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.white
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.text = comicList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comicList2:[[String:String]] = comicList1[comicList[indexPath.row]]!

        let vc = TheaterListController(area: comicList[indexPath.row] ,comicList: comicList2)
        navigationController?.pushViewController(vc, animated: true)
    }
}
