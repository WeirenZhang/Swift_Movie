//
//  MovieVideoCell.swift
//  Movie
//
//  Created by Mac on 2022/4/23.
//

import UIKit
import Kingfisher
import Reusable

class MovieVideoCell: TableViewCell, Reusable {
    
    var iconView: UIImageView = {
        let iw = UIImageView()
        iw.contentMode = .scaleAspectFill
        iw.clipsToBounds = true
        return iw
    }()
    
    var titleLabel: UILabel = {
        let tl = UILabel()
        tl.textColor = UIColor.darkGray
        tl.numberOfLines = 3
        return tl
    }()
    
    public var item: VideoModel? {
        
        didSet {
            
            guard let item else { return }
            separatorInset = .zero
            
            backgroundColor = UIColor.white
            
            contentView.addSubview(iconView)
            iconView.snp.makeConstraints {
                $0.left.top.bottom.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0))
                $0.width.equalTo(100)
                $0.height.equalTo(75)
            }
            KF.url(URL(string: item.cover))
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .onProgress { receivedSize, totalSize in  }
                .onSuccess { result in  }
                .onFailure { error in }
                .set(to: iconView)
            
            contentView.addSubview(titleLabel)
            titleLabel.snp.makeConstraints {
                $0.left.equalTo(iconView.snp.right).offset(10)
                $0.right.equalToSuperview().offset(-10)
                $0.centerY.equalTo(iconView)
            }
            titleLabel.text = item.title
        }
    }
}
