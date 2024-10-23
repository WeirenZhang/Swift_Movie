//
//  VideoViewController.swift
//  Movie
//
//  Created by User on 2024/10/2.
//

import EmptyDataSetExtension
import UIKit
import RxCocoa
import RxSwift
import SQLite

let TheaterMyFavouriteNotificationKey = "TheaterMyFavourite"

class TheaterMyFavouriteViewController: TableViewController {
    
    // Required for deinit the observer
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    let TheaterMyFavourite = Notification.Name(rawValue: TheaterMyFavouriteNotificationKey)
    
    let dataSource = BehaviorRelay(value: [TheaterInfoModel]())
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(UpdateTheaterMyFavourite(notification:)), name: TheaterMyFavourite, object: nil)
    }
    
    @objc func UpdateTheaterMyFavourite(notification: NSNotification) {
        dataSource.accept(TheaterMyFavouriteData())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
    }
    
    required init() {
        
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func makeUI() {
        
        super.makeUI()
        
        tableView.estimatedRowHeight = 95.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TheaterInfoCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.refreshHeader?.beginRefreshing { [weak self] in
            self?.tableView.emptyDataSet.setConfigAndRun(EmptyDataSetConfig(image: R.image.ic_nodata()))
        }
        
        bindViewModel()
    }
    
    func TheaterMyFavouriteData() -> [TheaterInfoModel] {

        var data = [TheaterInfoModel]()
        // Do any additional setup after loading the view.
        for theater in (try? db?.prepare(theater))!! {
            
            print("href: \(theater[href]), name: \(theater[name]), tel: \(theater[tel]), adds: \(theater[adds])")
            data.append(TheaterInfoModel(id: theater[href], name: theater[name], adds:theater[adds],  tel: theater[tel]))
        }
        return data
    }
    
    @objc func connected(sender: UIButton){
        let buttonTag = sender.tag
        let dict:TheaterInfoModel = dataSource.value[buttonTag]
        
        let controller = UIAlertController(title: "提醒", message: "是否刪除 " + dict.name, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "好的", style: .default) { _ in
            
            print(dict.id)
            
            let alice = theater.filter(href == dict.id)
            try? db?.run(alice.delete())
            
            let name = Notification.Name(rawValue: TheaterMyFavouriteNotificationKey)
            NotificationCenter.default.post(name: name, object: nil)
        }
        controller.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
    
    func bindViewModel() {
        
        dataSource.accept(TheaterMyFavouriteData())
        
        self.dataSource.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", cellType: TheaterInfoCell.self)
            cell.style = "MyFavourite"
            cell.item = element
            cell.discard.addTarget(self, action: #selector(self.connected(sender:)), for: .touchUpInside)
            cell.discard.tag = row
            return cell
        }.disposed(by: rx.disposeBag)
        
        // tableView 点击事件
        tableView.rx.modelSelected(TheaterInfoModel.self)
            .flatMap {
                navigator.rx.push(TheaterURL.Result.path,
                                  context: $0)
            }
            .subscribe { [weak self] _ in
                
            }
            .disposed(by: rx.disposeBag)
    }
}
