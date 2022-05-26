//
//  UComicTCell.swift
//  U17
//
//  Created by charles on 2017/11/8.
//  Copyright © 2017年 None. All rights reserved.
//

import UIKit

class UComicTCell: UBaseTableViewCell {

    var iconView: UIImageView = {
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
    
    var descLabel: UILabel = {
        let dl = UILabel()
        dl.textColor = UIColor.gray
        dl.numberOfLines = 3
        dl.font = UIFont.systemFont(ofSize: 14)
        return dl
    }()
    
    override func configUI() {
        separatorInset = .zero
        
        backgroundColor = UIColor.white
        
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0))
            $0.width.equalTo(100)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(iconView.snp.right).offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.height.equalTo(30)
            $0.top.equalTo(iconView)
        }
        
        contentView.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints {
            $0.left.equalTo(iconView.snp.right).offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.height.equalTo(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        contentView.addSubview(descLabel)
        descLabel.snp.makeConstraints {
            $0.left.equalTo(iconView.snp.right).offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.height.equalTo(30)
            //$0.top.equalTo(subTitleLabel.snp.bottom).offset(5)
            $0.bottom.equalTo(iconView)
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
