//
//  UComicTCell.swift
//  U17
//
//  Created by charles on 2017/11/8.
//  Copyright © 2017年 None. All rights reserved.
//

import UIKit

class TheaterResultCell: UBaseTableViewCell, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    var tapbox_collectionViewHeight: NSLayoutConstraint!
    
    var theater_times_collectionViewHeight: NSLayoutConstraint!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print("error" + String(dataSource1.count))
        if collectionView == self.tapbox_collectionView {
            return tapbox_dataSource.count
        } else {
            return theater_times_dataSource.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.tapbox_collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tapbox_Cell", for: indexPath) as! TapboxViewCell
            cell.backgroundColor = UIColor.orange
            cell.titleLabel.text = tapbox_dataSource[indexPath.row]
            //print("error" + dataSource1[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "theater_times_Cell", for: indexPath) as! theater_times_ViewCell
            cell.backgroundColor = UIColor.orange
            cell.titleLabel.text = theater_times_dataSource[indexPath.row]
            //print("error" + dataSource1[indexPath.row])
            return cell
        }
    }
    
    /*
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     return CGSize(width: collectionView.frame.size.width/3 - 10 , height: collectionView.frame.size.width/3 - 10)
     }
     */
    
    var theater_times_dataSource = [String]()
    
    var tapbox_dataSource = [String]()
    
    func setCell(tapbox_cells: [String], theater_times_cells: [String]){
        self.tapbox_dataSource = tapbox_cells
        self.tapbox_collectionView.reloadData()
        //更新collectionView的高度约束
        let tapbox_contentSize = self.tapbox_collectionView.collectionViewLayout.collectionViewContentSize
        tapbox_collectionViewHeight.constant = tapbox_contentSize.height
        
        self.theater_times_collectionView.collectionViewLayout.invalidateLayout()
        
        self.theater_times_dataSource = theater_times_cells
        self.theater_times_collectionView.reloadData()
        //更新collectionView的高度约束
        let theater_times_contentSize = self.theater_times_collectionView.collectionViewLayout.collectionViewContentSize
        theater_times_collectionViewHeight.constant = theater_times_contentSize.height
        
        self.tapbox_collectionView.collectionViewLayout.invalidateLayout()
        self.theater_times_collectionView.collectionViewLayout.invalidateLayout()
    }
    
    var iconView: UIImageView = {
        let iw = UIImageView()
        iw.contentMode = .scaleAspectFill
        iw.clipsToBounds = true
        return iw
    }()
    
    var iconView1: UIImageView = {
        let iw = UIImageView()
        iw.contentMode = .scaleAspectFill
        iw.clipsToBounds = true
        return iw
    }()
    
    var titleLabel: UILabel = {
        let tl = UILabel()
        tl.textColor = UIColor.black
        return tl
    }()
    
    var subTitleLabel: UILabel = {
        let sl = UILabel()
        sl.textColor = UIColor.gray
        sl.font = UIFont.systemFont(ofSize: 14)
        return sl
    }()
    
    var tapbox_collectionView: UICollectionView = {
        // 建立 UICollectionViewFlowLayout
        let layout = UICollectionViewFlowLayout()
        
        // 設置 section 的間距 四個數值分別代表 上、左、下、右 的間距
        /*
         layout.sectionInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5);
         */
        
        // 設置每一行的間距
        //layout.minimumLineSpacing = 5
        
        // 設置每個 cell 的尺寸
        layout.itemSize = CGSize(width: CGFloat(UIScreen.main.bounds.size.width - 150)/3, height: 30)
        
        // 建立 UICollectionView
        let myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        myCollectionView.isScrollEnabled = false
        myCollectionView.register(TapboxViewCell.self, forCellWithReuseIdentifier: "tapbox_Cell")
        
        return myCollectionView
    }()
    
    var theater_times_collectionView: UICollectionView = {
        // 建立 UICollectionViewFlowLayout
        let layout = UICollectionViewFlowLayout()
        
        // 設置 section 的間距 四個數值分別代表 上、左、下、右 的間距
        /*
         layout.sectionInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5);
         */
        
        // 設置每一行的間距
        //layout.minimumLineSpacing = 5
        
        // 設置每個 cell 的尺寸
        layout.itemSize = CGSize(width: CGFloat(UIScreen.main.bounds.size.width - 150)/3, height: 30)
        
        // 建立 UICollectionView
        let myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        myCollectionView.isScrollEnabled = false
        myCollectionView.register(theater_times_ViewCell.self, forCellWithReuseIdentifier: "theater_times_Cell")
        
        return myCollectionView
    }()
    
    override func configUI() {
        separatorInset = .zero
        
        backgroundColor = UIColor.white
        
        contentView.addSubview(iconView)
        
        iconView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.top.equalToSuperview().offset(10)
            $0.width.equalTo(100)
            $0.height.equalTo(143)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(iconView.snp.right).offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.height.equalTo(30)
            $0.top.equalTo(10)
        }
        
        contentView.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints {
            $0.left.equalTo(iconView.snp.right).offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.height.equalTo(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        contentView.addSubview(iconView1)
        iconView1.snp.makeConstraints {
            $0.left.equalTo(iconView.snp.right).offset(10)
            $0.width.equalTo(45)
            $0.height.equalTo(45)
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(10)
        }
        
        tapbox_collectionView.backgroundColor = UIColor.white
        tapbox_collectionView.delegate = self
        tapbox_collectionView.dataSource = self
        contentView.addSubview(tapbox_collectionView)
        
        // 高度约束
        tapbox_collectionViewHeight = NSLayoutConstraint(item: tapbox_collectionView, attribute: .height, relatedBy:.equal, toItem:nil, attribute: .notAnAttribute, multiplier:0.0, constant:100)
        
        tapbox_collectionView.addConstraint(tapbox_collectionViewHeight)
        
        tapbox_collectionView.snp.makeConstraints {
            $0.left.equalTo(iconView.snp.right).offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.top.equalTo(iconView1.snp.bottom).offset(10)
            $0.width.equalTo(UIScreen.main.bounds.size.width - 130)
        }
        
        theater_times_collectionView.backgroundColor = UIColor.white
        theater_times_collectionView.delegate = self
        theater_times_collectionView.dataSource = self
        contentView.addSubview(theater_times_collectionView)
        
        // 高度约束
        theater_times_collectionViewHeight = NSLayoutConstraint(item: theater_times_collectionView, attribute: .height, relatedBy:.equal, toItem:nil, attribute: .notAnAttribute, multiplier:0.0, constant:0)
        
        theater_times_collectionView.addConstraint(theater_times_collectionViewHeight)
        
        theater_times_collectionView.snp.makeConstraints {
            $0.left.equalTo(iconView.snp.right).offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.top.equalTo(tapbox_collectionView.snp.bottom).offset(10)
            $0.width.equalTo(UIScreen.main.bounds.size.width - 130)
            $0.bottom.equalTo(-10)
        }
    }
    
    /*
     var model: ComicModel? {
     didSet {
     guard let model = model else { return }
     iconView.kf.setImage(urlString: model.cover, placeholder: UIImage(named: "normal_placeholder_v"))
     
     titleLabel.text = model.name
     subTitleLabel.text = "\(model.tags?.joined(separator: " ") ?? "") | \(model.author ?? "")"
     descLabel.text = model.description
     
     
     }
     }
     */
}
