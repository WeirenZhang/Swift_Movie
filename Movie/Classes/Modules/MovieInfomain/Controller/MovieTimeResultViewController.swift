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

class MovieTimeResultViewController: TableViewController {
    
    private var comicList: [MovieTimeResultModel]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    init(model: [MovieTimeResultModel]) {
        
        self.comicList = model
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func makeUI() {
        
        super.makeUI()
        
        tableView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(MovieTimeResultCell.self, forCellReuseIdentifier: "Cell")
        
        bindViewModel()
    }
    
    func bindViewModel() {
        
        Driver.just(self.comicList)
            .drive(tableView.rx.items) { tableView, row, item in
                
                let CellIdentifier = "Cell\(item.id)"
                
                if let cell = self.tableView.dequeueReusableCell(withIdentifier: CellIdentifier) as? MovieTimeResultCell {
                    
                    cell.layer.cornerRadius = 0.25
                    cell.layer.borderWidth = 0
                    cell.layer.shadowColor = UIColor.black.cgColor
                    cell.layer.shadowOffset = CGSize(width: 0, height: 0)
                    cell.layer.shadowRadius = 5
                    cell.layer.shadowOpacity = 0.1
                    cell.layer.masksToBounds = false
                    cell.frame = tableView.bounds
                    cell.layoutIfNeeded()
                    cell.item = item
                    let backgroundView = UIView()
                    backgroundView.backgroundColor = UIColor(red: 209/255, green: 209/255, blue: 213/255, alpha: 1.0)
                    cell.selectedBackgroundView = backgroundView
                    return cell
                } else {
                    let cell = MovieTimeResultCell(style: .default, reuseIdentifier: CellIdentifier)
                    
                    cell.layer.cornerRadius = 0.25
                    cell.layer.borderWidth = 0
                    cell.layer.shadowColor = UIColor.black.cgColor
                    cell.layer.shadowOffset = CGSize(width: 0, height: 0)
                    cell.layer.shadowRadius = 5
                    cell.layer.shadowOpacity = 0.1
                    cell.layer.masksToBounds = false
                    cell.frame = tableView.bounds
                    cell.layoutIfNeeded()
                    cell.item = item
                    let backgroundView = UIView()
                    backgroundView.backgroundColor = UIColor(red: 209/255, green: 209/255, blue: 213/255, alpha: 1.0)
                    cell.selectedBackgroundView = backgroundView
                    return cell
                }
            }
            .disposed(by: rx.disposeBag)
        
        // tableView 点击事件
        tableView.rx.modelSelected(MovieTimeResultModel.self)
            .flatMap {
                navigator.rx.push(TheaterURL.Result.path,
                                  context: TheaterInfoModel(id: $0.id, name: $0.theater, adds:"",  tel: ""))
            }
            .subscribe { [weak self] _ in
                
            }
            .disposed(by: rx.disposeBag)
    }
}
