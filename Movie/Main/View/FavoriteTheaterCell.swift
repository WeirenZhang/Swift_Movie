//
//  UComicTCell.swift
//  U17
//
//  Created by charles on 2017/11/8.
//  Copyright © 2017年 None. All rights reserved.
//

import UIKit

class FavoriteTheaterCell: UBaseTableViewCell {
    
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
    
    var descLabel: UILabel = {
        let dl = UILabel()
        dl.textColor = UIColor.gray
        dl.numberOfLines = 3
        dl.font = UIFont.systemFont(ofSize: 14)
        return dl
    }()
    
    var discard: UIButton = {
        let tl = UIButton()
        tl.setImage(UIImage(named: "discard"), for: .normal)
        return tl
    }()
    
    override func configUI() {
        separatorInset = .zero
        
        backgroundColor = UIColor.white
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.height.equalTo(30)
            $0.top.equalToSuperview().offset(10)
        }
        
        contentView.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.height.equalTo(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        contentView.addSubview(descLabel)
        descLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.height.equalTo(30)
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(5)
            $0.bottom.equalTo(-10)
        }
        
        contentView.addSubview(discard)
        discard.snp.makeConstraints {
            $0.right.equalToSuperview().offset(0)
            $0.height.equalTo(96)
            $0.width.equalTo(96)
            //$0.top.equalTo(subTitleLabel.snp.bottom).offset(5)
            $0.bottom.equalTo(descLabel)
        }
    }
}
