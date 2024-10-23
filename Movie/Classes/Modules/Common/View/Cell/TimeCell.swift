//
//  MineCollectionViewCell.swift
//  U17
//
//  Created by lyw on 2020/5/14.
//  Copyright © 2020 胡智钦. All rights reserved.
//

import UIKit
import Reusable

class TimeCell: CollectionViewCell, Reusable {
    
    var style: String = ""
    
    var titleLabel: UILabel = {
        let tl = UILabel()
        tl.textAlignment = .center
        tl.font = UIFont.systemFont(ofSize: 16)
        tl.textColor = UIColor.darkGray
        return tl
    }()
    
    public var item: TimeModel? {
        
        didSet {
            
            guard let item else { return }
            
            backgroundColor = UIColor.systemGray6
            
            contentView.addSubview(titleLabel)
            titleLabel.snp.makeConstraints{
                $0.height.equalTo(30)
                if (style.contains("Movie")) {
                    $0.width.equalTo((.screenWidth - 50)/3)
                } else {
                    $0.width.equalTo((.screenWidth - 150)/2)
                }
            }
            titleLabel.text = item.time
        }
    }
}
