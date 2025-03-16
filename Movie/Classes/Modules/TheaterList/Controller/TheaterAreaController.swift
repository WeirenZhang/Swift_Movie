//
//  VideoViewController.swift
//  QYNews
//
//  Created by Insect on 2018/12/4.
//  Copyright © 2018 Insect. All rights reserved.
//

import EmptyDataSetExtension
import UIKit
import RxCocoa
import RxSwift
import RxURLNavigator

class TheaterAreaController: VMTableViewController<TheaterAreaViewModel> {
    
    private var _title: String = ""
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = self._title;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
    }
    
    // MARK: - init
    
    init(title: String) {
        self._title = title
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override func makeUI() {
        
        super.makeUI()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.refreshHeader = RefreshHeader()
        
        tableView.refreshHeader?.beginRefreshing { [weak self] in
            self?.tableView.emptyDataSet.setConfigAndRun(EmptyDataSetConfig(image: R.image.ic_nodata()))
        }
    }
    
    override func bindViewModel() {
        
        super.bindViewModel()
        
        let input = TheaterAreaViewModel.Input()
        let output = viewModel.transform(input: input)
        
        // 数据源 nil 时点击
        if let config = tableView.emptyDataSet.config {
            config.rx.didTapView
                .bind(to: rx.post(name: .videoNoConnectClick))
                .disposed(by: rx.disposeBag)
        }
        
        // TableView 数据源
        output.items.drive(tableView.rx.items) { tableView, row, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", cellType: UITableViewCell.self)
            cell.backgroundColor = UIColor.white
            cell.textLabel?.text = item.theater_top
            cell.textLabel!.textColor = UIColor.black
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor(red: 209/255, green: 209/255, blue: 213/255, alpha: 1.0)
            cell.selectedBackgroundView = backgroundView
            return cell
        }
        .disposed(by: rx.disposeBag)
        
        // tableView 点击事件
        tableView.rx.modelSelected(TheaterAreaModel.self)
            .flatMap {
                navigator.rx.push(TheaterURL.List.path,
                                  context: $0)
            }
            .subscribe { [weak self] _ in
                
            }
            .disposed(by: rx.disposeBag)
    }
}

