//
//  MineCollectionViewCell.swift
//  U17
//
//  Created by lyw on 2020/5/14.
//  Copyright © 2020 胡智钦. All rights reserved.
//

import UIKit

class TapboxViewCell: BaseCollectionViewCell {
    
    var titleLabel: UILabel = {
        let tl = UILabel()
        tl.textAlignment = .center
        tl.backgroundColor = UIColor.blue
        tl.font = UIFont.systemFont(ofSize: 14)
        tl.textColor = UIColor.white
        return tl
    }()
    
    override func setupLayout() {
        
        backgroundColor = UIColor.white
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{ 
            //$0.right.equalToSuperview().offset(-10)
            $0.height.equalTo(30)
            $0.width.equalTo((UIScreen.main.bounds.size.width - 150)/3)
        }
    }

}
