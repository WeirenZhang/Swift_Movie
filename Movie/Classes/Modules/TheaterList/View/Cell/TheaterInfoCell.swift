//
//  UComicTCell.swift
//  U17
//
//  Created by charles on 2017/11/8.
//  Copyright © 2017年 None. All rights reserved.
//

import UIKit
import Reusable

class TheaterInfoCell: TableViewCell, Reusable {
    
    var style: String = ""
    
    var name: UILabel = {
        let tl = UILabel()
        tl.textColor = UIColor.black
        return tl
    }()
    
    var adds: UILabel = {
        let sl = UILabel()
        sl.textColor = UIColor.gray
        sl.font = UIFont.systemFont(ofSize: 14)
        return sl
    }()
    
    var tel: UILabel = {
        let dl = UILabel()
        dl.textColor = UIColor.gray
        dl.numberOfLines = 3
        dl.font = UIFont.systemFont(ofSize: 14)
        return dl
    }()
    
    var discard: UIButton = {
        let tl = UIButton()
        
        let largeFont = UIFont.systemFont(ofSize: 30)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        
        tl.setImage(UIImage(systemName: "trash", withConfiguration: configuration), for: .normal)
        return tl
    }()
    
    public var item: TheaterInfoModel? {
        
        didSet {
            
            guard let item else { return }
            separatorInset = .zero
            
            backgroundColor = UIColor.white
            
            contentView.addSubview(name)
            name.snp.makeConstraints {
                $0.left.equalToSuperview().offset(10)
                $0.right.equalToSuperview().offset(-10)
                $0.height.equalTo(30)
                $0.top.equalToSuperview().offset(10)
            }
            name.text = item.name
            
            contentView.addSubview(adds)
            adds.snp.makeConstraints {
                $0.left.equalToSuperview().offset(10)
                $0.right.equalToSuperview().offset(-10)
                $0.height.equalTo(20)
                $0.top.equalTo(name.snp.bottom).offset(5)
            }
            adds.text = item.adds
            
            contentView.addSubview(tel)
            tel.snp.makeConstraints {
                $0.left.equalToSuperview().offset(10)
                $0.right.equalToSuperview().offset(-10)
                $0.height.equalTo(30)
                $0.top.equalTo(adds.snp.bottom).offset(5)
                $0.bottom.equalTo(-10)
            }
            tel.text = item.tel
            
            if (style.contains("MyFavourite")) {
                contentView.addSubview(discard)
                discard.snp.makeConstraints {
                    $0.right.equalToSuperview().offset(10)
                    $0.height.equalTo(96)
                    $0.width.equalTo(96)
                    $0.centerY.equalTo(adds)
                }
            }
        }
    }
}
