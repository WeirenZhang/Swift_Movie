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

let MovieMyFavouriteNotificationKey = "MovieMyFavourite"

class MovieMyFavouriteViewController: TableViewController {
    
    // Required for deinit the observer
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    let MovieMyFavourite = Notification.Name(rawValue: MovieMyFavouriteNotificationKey)
    
    let dataSource = BehaviorRelay(value: [MovieListModel]())
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(UpdateMovieMyFavourite(notification:)), name: MovieMyFavourite, object: nil)
    }
    
    @objc func UpdateMovieMyFavourite(notification: NSNotification) {
        dataSource.accept(MovieMyFavouriteData())
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
        tableView.register(MovieListCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.refreshHeader?.beginRefreshing { [weak self] in
            self?.tableView.emptyDataSet.setConfigAndRun(EmptyDataSetConfig(image: R.image.ic_nodata()))
        }
        
        bindViewModel()
    }
    
    func MovieMyFavouriteData() -> [MovieListModel] {

        var data = [MovieListModel]()
        // Do any additional setup after loading the view.
        for movie in (try? db?.prepare(movie))!! {
            
            print("ahref: \(movie[ahref]), imgsrc: \(movie[imgsrc]), release_movie_name: \(movie[release_movie_name]), en: \(movie[en]), release_movie_time: \(movie[release_movie_time])")
            data.append(MovieListModel(title: movie[release_movie_name], en: movie[en], release_movie_time: movie[release_movie_time], thumb:movie[imgsrc],  id: movie[ahref]))
        }
        return data
    }
    
    @objc func connected(sender: UIButton){
        let buttonTag = sender.tag
        let dict:MovieListModel = dataSource.value[buttonTag]
        
        let controller = UIAlertController(title: "提醒", message: "是否刪除 " + dict.title, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "好的", style: .default) { _ in
            
            print(dict.id)
            
            let alice = movie.filter(ahref == dict.id)
            try? db?.run(alice.delete())
            
            let name = Notification.Name(rawValue: MovieMyFavouriteNotificationKey)
            NotificationCenter.default.post(name: name, object: nil)
        }
        controller.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
    
    func bindViewModel() {
        
        dataSource.accept(MovieMyFavouriteData())
        
        self.dataSource.bind(to: tableView.rx.items) { [self] (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", cellType: MovieListCell.self)
            cell.style = "MyFavourite"
            cell.item = element
            cell.discard.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
            cell.discard.tag = row
            return cell
        }.disposed(by: rx.disposeBag)
        
        // tableView 点击事件
        tableView.rx.modelSelected(MovieListModel.self)
            .flatMap {
                navigator.rx.push(MovieURL.InfoMain.path,
                                  context: $0)
            }
            .subscribe { [weak self] _ in
                
            }
            .disposed(by: rx.disposeBag)
    }
}
