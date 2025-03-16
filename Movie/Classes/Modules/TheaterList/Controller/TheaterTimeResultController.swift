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
import RxDataSources
import SQLite

// MARK: - FilterViewProtocol

extension TheaterTimeResultController: DateViewProtocol {
    func SetDateViewHeight(height: CGFloat) {
        print("調高度")
        dateViewHeight = height
        viewDidLayoutSubviews()
    }
}

class TheaterTimeResultController: VMTableViewController<TheaterResultViewModel> {
    
    private var dateViewHeight: CGFloat = 60
    private var model: TheaterInfoModel
    
    let dataSource = BehaviorRelay(value: [TheaterTimeResultModel]())
    
    // MARK: - LifeCycle
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        dateView.frame = CGRect(x: 0,
                                y: .navigationBarHeight + .statusBarHeight,
                                width: .screenWidth,
                                height: dateViewHeight)
        
        tableView.frame = CGRect(x: self.tableView.origin.x,
                                 y: .navigationBarHeight + .statusBarHeight + 60,
                                 width: self.tableView.frame.width,
                                 height: self.tableView.frame.height - (.navigationBarHeight + .statusBarHeight + 60))
    }
    
    /// 添加到 collectionView 上的
    
    private lazy var dateView: TheaterDateView = {
        
        let dateView = TheaterDateView(frame: .zero)
        dateView.delegate = self
        return dateView
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = self.model.name;
        
        let RightBarButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.myRightSideBarButtonItemTapped(_:)))
        
        let largeFont = UIFont.systemFont(ofSize: 34)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        
        RightBarButton.image = UIImage(systemName: "heart", withConfiguration: configuration)
        
        self.navigationItem.rightBarButtonItem = RightBarButton
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
    }
    
    // MARK: - init
    
    init(model: TheaterInfoModel) {
        
        self.model = model
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func myRightSideBarButtonItemTapped(_ sender:UIBarButtonItem!)
    {
        do {
            let count = try db?.scalar(theater.filter(href == model.id).count)
            
            if (count! == 0) {
                let rowid = try db?.run(theater.insert(href <- model.id, name <- model.name, tel <- model.tel, adds <- model.adds))
                print("inserted id: \(rowid!)")
                self.navigationController?.view.makeToast("成功加入我的最愛", duration: 1.0, position: .top)
                let name = Notification.Name(rawValue: TheaterMyFavouriteNotificationKey)
                NotificationCenter.default.post(name: name, object: nil)
            } else {
                self.navigationController?.view.makeToast("我的最愛已經有了", duration: 1.0, position: .top)
            }
        } catch {
            print("insertion failed: \(error)")
        }
    }
    
    override func makeUI() {
        
        super.makeUI()
        
        view.addSubview(dateView)
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.refreshHeader = RefreshHeader()
        
        tableView.refreshHeader?.beginRefreshing { [weak self] in
            self?.tableView.emptyDataSet.setConfigAndRun(EmptyDataSetConfig(image: R.image.ic_nodata()))
        }
    }
    
    func setItem(_ item: TheaterDateItemModel) {
        if (item.data.count == 0) {
            print("沒數據")
            dateView.dateButton.isUserInteractionEnabled = false;//交互关闭
        } else {
            print("有數據")
            dateView.dateButton.isUserInteractionEnabled = true;//交互关闭
            dataSource.accept(item.data)
            dateView.dateButton.setTitle(item.date, for: .normal)
        }
    }
    
    override func bindViewModel() {
        
        super.bindViewModel()
        
        viewModel.input.cinemaIdOb.onNext(self.model.id)
        
        dateView.tableView.rx.itemSelected
            .do(onNext: { [unowned self] indexPath in
                dataSource.accept(dateView.date[indexPath.row].data)
            })
            .subscribe()
            .disposed(by: rx.disposeBag)
        
        // 视频分类
        viewModel.output
            .items
            .drive(dateView.rx.date)
            .disposed(by: rx.disposeBag)
        
        // 视频分类
        viewModel.output
            .item
            .drive(rx.item)
            .disposed(by: rx.disposeBag)
        /*
         self.dataSource.bind(to: self.tableView.rx.items(cellIdentifier: "Cell", cellType: TheaterTimeResultCell.self)) { index, model, cell in
         cell.item = model
         }.disposed(by: rx.disposeBag)
         */
        
        self.dataSource.bind(to: tableView.rx.items) { (tableView, row, element) in
            //print("Cell\(element.id)\(self.dateView.dateButton.currentTitle!)")
            let CellIdentifier = "Cell\(element.id)\(self.dateView.dateButton.currentTitle!)"
            
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: CellIdentifier) as? TheaterTimeResultCell {
                cell.frame = tableView.bounds
                cell.layoutIfNeeded()
                cell.item = element
                let backgroundView = UIView()
                backgroundView.backgroundColor = UIColor(red: 209/255, green: 209/255, blue: 213/255, alpha: 1.0)
                cell.selectedBackgroundView = backgroundView
                return cell
            } else {
                let cell = TheaterTimeResultCell(style: .default, reuseIdentifier: CellIdentifier)
                cell.frame = tableView.bounds
                cell.layoutIfNeeded()
                cell.item = element
                let backgroundView = UIView()
                backgroundView.backgroundColor = UIColor(red: 209/255, green: 209/255, blue: 213/255, alpha: 1.0)
                cell.selectedBackgroundView = backgroundView
                return cell
            }
        }.disposed(by: rx.disposeBag)
        
        // 数据源 nil 时点击
        if let config = tableView.emptyDataSet.config {
            config.rx.didTapView
                .bind(to: rx.post(name: .videoNoConnectClick))
                .disposed(by: rx.disposeBag)
        }
        
        // tableView 点击事件
        tableView.rx.modelSelected(TheaterTimeResultModel.self)
            .flatMap {
                navigator.rx.push(MovieURL.InfoMain.path, context: MovieListModel(title: $0.theaterlist_name, en: "", release_movie_time: "", thumb:$0.release_foto,  id: $0.id))
            }
            .subscribe { [weak self] _ in
                
            }
            .disposed(by: rx.disposeBag)
    }
}

// MARK: - Reactive-extension
extension Reactive where Base: TheaterTimeResultController {
    
    var item: Binder<TheaterDateItemModel?> {
        
        let item = TheaterDateItemModel(date: "", data: [])
        return Binder(base) { vc, value in
            vc.setItem(value ?? item)
        }
    }
}



