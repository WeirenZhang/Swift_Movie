//
//  VideoViewController.swift
//  Movie
//
//  Created by Mac on 2022/3/31.
//

import UIKit
import SwiftSoup
import Kingfisher
import SQLite

class TheaterFavoriteViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .plain)
        tw.backgroundColor = UIColor.white
        tw.tableFooterView = UIView()
        tw.delegate = self
        tw.dataSource = self
        tw.register(cellType: FavoriteTheaterCell.self)
        return tw
    }()
    
    private var comicList = [[String:String]]()
    
    convenience init(comicList1: [[String:String]]) {
        self.init(comicList: comicList1)
    }
    
    init(comicList: [[String:String]]) {
        super.init(nibName: nil, bundle: nil)
        self.comicList = comicList
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ $0.edges.equalTo(self.view.usnp.edges) }
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
    
    @objc func connected(sender: UIButton){
        let buttonTag = sender.tag
        let dict:Dictionary = comicList[buttonTag]
        
        let controller = UIAlertController(title: "提醒", message: "是否刪除 " + dict["name"]!, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "好的", style: .default) { _ in
            
            print(dict["href"]!)
            
            let alice = theater.filter(href == dict["href"]!)
            try? db?.run(alice.delete())
            
            let name = Notification.Name(rawValue: FavoriteNotificationKey)
            NotificationCenter.default.post(name: name, object: nil)
        }
        controller.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
    
}

extension TheaterFavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: FavoriteTheaterCell.self)
        cell.discard.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
        cell.discard.tag = indexPath.row
        let dict:Dictionary = comicList[indexPath.row]
        cell.titleLabel.text = dict["name"]
        cell.subTitleLabel.text = dict["tel"]
        cell.descLabel.text = dict["adds"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = TheaterResultController(dict: comicList[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
