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

class VideoViewController: VMTableViewController<VideoViewModel> {
    
    private var model: MovieListModel
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
    }
    
    required init(model: MovieListModel) {
        
        self.model = model
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func makeUI() {
        
        super.makeUI()
        
        tableView.estimatedRowHeight = 95.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(MovieVideoCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.refreshHeader = RefreshHeader()
        
        tableView.refreshHeader?.beginRefreshing { [weak self] in
            self?.tableView.emptyDataSet.setConfigAndRun(EmptyDataSetConfig(image: R.image.ic_nodata()))
        }
    }
    
    override func bindViewModel() {
        
        super.bindViewModel()
        
        let input = VideoViewModel.Input(movie_id: self.model.id)
        let output = viewModel.transform(input: input)
        
        // 数据源 nil 时点击
        if let config = tableView.emptyDataSet.config {
            config.rx.didTapView
                .bind(to: rx.post(name: .videoNoConnectClick))
                .disposed(by: rx.disposeBag)
        }
        
        // TableView 数据源
        output.items.drive(tableView.rx.items) { tableView, row, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", cellType: MovieVideoCell.self)
            cell.item = item
            return cell
        }
        .disposed(by: rx.disposeBag)
        
        // tableView 点击事件
        tableView.rx.modelSelected(VideoModel.self)
            .flatMap {
                navigator.rx.push(MovieURL.Video.path,
                                  context: $0)
            }
            .subscribe { [weak self] _ in
                
            }
            .disposed(by: rx.disposeBag)
    }
}
