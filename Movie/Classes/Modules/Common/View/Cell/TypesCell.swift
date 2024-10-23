//
//  TheaterTypesCell.swift
//  Movie
//
//  Created by User on 2024/10/9.
//

import Foundation
import UIKit

class TypesCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var style: String = ""
    
    var TypeCollectionView: UICollectionView!
    
    var TimeCollectionView: UICollectionView!
    
    var TypeCollectionViewHeight: NSLayoutConstraint!
    
    var TimeCollectionViewHeight: NSLayoutConstraint!
    
    var TypeDataSource = [TypeModel]()
    
    var TimeDataSource = [TimeModel]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.TypeCollectionView {
            return TypeDataSource.count
        } else {
            return TimeDataSource.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.TypeCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeCell", for: indexPath) as! TypeCell
            cell.style = style
            cell.item = TypeDataSource[indexPath.row]
            return cell
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeCell", for: indexPath) as! TimeCell
            cell.style = style
            cell.item = TimeDataSource[indexPath.row]
            return cell
        }
    }
    
    public var item: TypesModel? {
        
        didSet {
            
            guard let item else { return }
            
            let layout = UICollectionViewFlowLayout()
            // 設置 section 的間距 四個數值分別代表 上、左、下、右 的間距
            //layout.sectionInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5);
            // 設置每一行的間距
            layout.minimumLineSpacing = 5
            // 設置每個 cell 的尺寸
            if (style.contains("Movie")) {
                layout.itemSize = CGSize(width: CGFloat(.screenWidth - 50)/3, height: 30)
            } else {
                layout.itemSize = CGSize(width: CGFloat(.screenWidth - 150)/2, height: 30)
            }
            
            TypeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            //TypeCollectionView.backgroundColor = UIColor.blue
            TypeCollectionView.isScrollEnabled = false
            TypeCollectionView.register(TypeCell.self, forCellWithReuseIdentifier: "TypeCell")
            TypeCollectionView.delegate = self
            TypeCollectionView.dataSource = self
            contentView.addSubview(TypeCollectionView)
            
            // 高度约束
            TypeCollectionViewHeight = NSLayoutConstraint(item: TypeCollectionView!, attribute: .height, relatedBy:.equal, toItem:nil, attribute: .notAnAttribute, multiplier:0.0, constant:0)
            
            TypeCollectionView.addConstraint(TypeCollectionViewHeight)
            
            TypeCollectionView.snp.makeConstraints {
                $0.left.equalToSuperview().offset(5)
                $0.top.equalToSuperview().offset(5)
                $0.right.equalToSuperview().offset(-5)
                if (style.contains("Movie")) {
                    $0.width.equalTo(.screenWidth - 30)
                } else {
                    $0.width.equalTo(.screenWidth - 140)
                }
            }
            
            self.TypeDataSource = item.types
            //self.TypeCollectionView.reloadData()
            self.TypeCollectionView.layoutIfNeeded()
            
            //更新collectionView的高度约束
            let TypeCollectionViewContentSize = TypeCollectionView.collectionViewLayout.collectionViewContentSize
            TypeCollectionViewHeight.constant = TypeCollectionViewContentSize.height
            TypeCollectionView.collectionViewLayout.invalidateLayout()
            
            TimeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            //TimeCollectionView.backgroundColor = UIColor.red
            TimeCollectionView.isScrollEnabled = false
            TimeCollectionView.register(TimeCell.self, forCellWithReuseIdentifier: "TimeCell")
            TimeCollectionView.delegate = self
            TimeCollectionView.dataSource = self
            contentView.addSubview(TimeCollectionView)
            
            // 高度约束
            TimeCollectionViewHeight = NSLayoutConstraint(item: TimeCollectionView!, attribute: .height, relatedBy:.equal, toItem:nil, attribute: .notAnAttribute, multiplier:0.0, constant:0)
            
            TimeCollectionView.addConstraint(TimeCollectionViewHeight)
            
            TimeCollectionView.snp.makeConstraints {
                $0.left.equalToSuperview().offset(5)
                $0.right.equalToSuperview().offset(-5)
                $0.top.equalTo(TypeCollectionView.snp.bottom).offset(5)
                if (style.contains("Movie")) {
                    $0.width.equalTo(.screenWidth - 30)
                } else {
                    $0.width.equalTo(.screenWidth - 140)
                }
                $0.bottom.equalTo(-5)
            }
            
            self.TimeDataSource = item.times
            //self.TimeCollectionView.reloadData()
            self.TimeCollectionView.layoutIfNeeded()
            
            //更新collectionView的高度约束
            let TimeCollectionViewContentSize = TimeCollectionView.collectionViewLayout.collectionViewContentSize
            TimeCollectionViewHeight.constant = TimeCollectionViewContentSize.height
            TimeCollectionView.collectionViewLayout.invalidateLayout()
        }
    }
}
