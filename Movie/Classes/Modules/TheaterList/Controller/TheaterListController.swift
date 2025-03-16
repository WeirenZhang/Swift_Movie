//
//  TheaterListController.swift
//  Movie
//
//  Created by Mac on 2022/4/1.
//

import UIKit
import EmptyDataSetExtension
import RxURLNavigator
import RxCocoa
import RxSwift

class TheaterListController: TableViewController {
    
    private var comicList: [TheaterInfoModel]
    private var _title: String = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = self._title;
    }
    
    init(model: TheaterAreaModel) {
        
        self.comicList = model.theater_list
        self._title = model.theater_top
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func makeUI() {
        
        super.makeUI()
        
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TheaterInfoCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.refreshHeader?.beginRefreshing { [weak self] in
            self?.tableView.emptyDataSet.setConfigAndRun(EmptyDataSetConfig(image: R.image.ic_nodata()))
        }
        
        bindViewModel()
    }
    
    func bindViewModel() {
        
        Driver.just(self.comicList)
            .drive(tableView.rx.items) { tableView, row, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", cellType: TheaterInfoCell.self)
                cell.style = "Theater"
                cell.item = item
                let backgroundView = UIView()
                backgroundView.backgroundColor = UIColor(red: 209/255, green: 209/255, blue: 213/255, alpha: 1.0)
                cell.selectedBackgroundView = backgroundView
                return cell
            }
            .disposed(by: rx.disposeBag)
        
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
