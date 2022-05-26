//
//  MovieVideoCell.swift
//  Movie
//
//  Created by Mac on 2022/4/23.
//

import UIKit
import SwiftSoup
import Kingfisher

class MovieVideoCell: UBaseTableViewCell {

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
