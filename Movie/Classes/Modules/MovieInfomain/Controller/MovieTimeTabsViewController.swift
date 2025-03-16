//
//  MovieTimeTabsViewController.swift
//  Movie
//
//  Created by User on 2024/10/2.
//

import UIKit
import JXCategoryView
import RxCocoa
import RxSwift
import RxSwiftExt

// MARK: - FilterViewProtocol

extension MovieTimeTabsViewController: MovieDateViewProtocol {
    func SetDateViewHeight(height: CGFloat) {
        print("調高度")
        dateViewHeight = height
        viewDidLayoutSubviews()
    }
}

class MovieTimeTabsViewController: VMViewController<MovieTimeTabsViewModel> {
    
    private var dateViewHeight: CGFloat = 60
    private var model: MovieListModel
    private let menuH: CGFloat = 44
    
    let dataSource = BehaviorRelay(value: [MovieTimeTabItemModel]())
    
    // MARK: - LazyLoad
    fileprivate lazy var categoryView: JXCategoryTitleView = {
        
        let lineView = JXCategoryIndicatorLineView()
        lineView.lineStyle = .normal
        let categoryView = JXCategoryTitleView()
        categoryView.listContainer = listContainerView
        categoryView.indicators = [lineView]
        categoryView.delegate = self
        return categoryView
    }()
    
    // swiftlint:disable:next force_unwrapping
    fileprivate lazy var listContainerView = JXCategoryListContainerView(type: .scrollView,
                                                                         delegate: self)!
    
    required init(model: MovieListModel) {
        
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        viewModel.transform(input: MovieTimeTabsViewModel.Input(movie_id: self.model.id))
        
        dateView.tableView.rx.itemSelected
            .do(onNext: { [unowned self] indexPath in
                dataSource.accept(dateView.date[indexPath.row].list)
                
                categoryView.titles = dateView.date[indexPath.row].list.map{ $0.area }
                categoryView.defaultSelectedIndex = 0
                categoryView.reloadData()
                listContainerView.reloadData()
            })
            .subscribe()
            .disposed(by: rx.disposeBag)
        
        // 视频分类
        viewModel
            .items.asDriver()
            .drive(dateView.rx.date)
            .disposed(by: rx.disposeBag)
        
        // 分类数据
        viewModel.item.asDriver()
            .drive(rx.item)
            .disposed(by: rx.disposeBag)
    }
    
    override func makeUI() {
        super.makeUI()
        
        view.addSubview(categoryView)
        view.addSubview(listContainerView)
        view.addSubview(dateView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        dateView.frame = CGRect(x: 0,
                                y: .navigationBarHeight + .statusBarHeight,
                                width: .screenWidth,
                                height: dateViewHeight)
        
        categoryView.frame = CGRect(x: 0,
                                    y: .navigationBarBottomY + 60,
                                    width: view.width,
                                    height: menuH)
        
        listContainerView.frame = CGRect(x: 0,
                                         y: .navigationBarHeight + .statusBarHeight + menuH + 60,
                                         width: view.width,
                                         height: view.height - (.navigationBarHeight + .statusBarHeight + menuH + 60 + .tabBarHeight))
    }
    
    func setItem(_ item: MovieDateTabItemModel) {
        if (item.list.count == 0) {
            print("沒數據")
            dateView.dateButton.isUserInteractionEnabled = false;//交互关闭
        } else {
            print("有數據")
            dateView.dateButton.isUserInteractionEnabled = true;//交互关闭
            dataSource.accept(item.list)
            dateView.dateButton.setTitle(item.date, for: .normal)
            
            categoryView.titles = item.list.map{ $0.area }
            categoryView.defaultSelectedIndex = 0
            categoryView.reloadData()
            listContainerView.reloadData()
        }
    }
    
    /// 添加到 collectionView 上的
    private lazy var dateView: MovieDateView = {
        
        let dateView = MovieDateView(frame: .zero)
        dateView.delegate = self
        return dateView
    }()
}

extension Reactive where Base: MovieTimeTabsViewController {
    
    var item: Binder<MovieDateTabItemModel?> {
        
        let item = MovieDateTabItemModel(date: "", list: [])
        return Binder(base) { vc, value in
            vc.setItem(value ?? item)
        }
    }
}

// MARK: - JXCategoryViewDelegate
extension MovieTimeTabsViewController: JXCategoryViewDelegate {
    
    func categoryView(_ categoryView: JXCategoryBaseView!, didSelectedItemAt index: Int) {
        
        NotificationCenter.default
            .post(name: .pageDidScroll, object: nil)
        
        listContainerView.didClickSelectedItem(at: index)
    }
}

// MARK: - JXCategoryListContainerViewDelegate
extension MovieTimeTabsViewController: JXCategoryListContainerViewDelegate {
    
    func number(ofListsInlistContainerView listContainerView: JXCategoryListContainerView!) -> Int {
        
        dataSource.value.count
    }
    
    func listContainerView(_ listContainerView: JXCategoryListContainerView!, initListFor index: Int) -> JXCategoryListContentViewDelegate! {
        
        MovieTimeResultViewController(model: dataSource.value[index].data)
    }
}
