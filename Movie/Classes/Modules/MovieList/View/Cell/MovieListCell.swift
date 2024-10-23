//
//  VideoListCell.swift
//  QYNews
//
//  Created by Insect on 2018/12/5.
//  Copyright © 2018 Insect. All rights reserved.
//

import UIKit
import Reusable
import Kingfisher

class MovieListCell: TableViewCell, Reusable {
    
    var style: String = ""
    
    var thumb: UIImageView = {
        let iw = UIImageView()
        iw.contentMode = .scaleAspectFill
        iw.clipsToBounds = true
        return iw
    }()
    
    var title: UILabel = {
        let tl = UILabel()
        tl.textColor = UIColor.black
        return tl
    }()
    
    var en: UILabel = {
        let sl = UILabel()
        sl.textColor = UIColor.gray
        sl.font = UIFont.systemFont(ofSize: 14)
        return sl
    }()
    
    var release_movie_time: UILabel = {
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
    
    public var item: MovieListModel? {
        
        didSet {
            
            guard let item else { return }
            separatorInset = .zero
            
            backgroundColor = UIColor.white
            
            contentView.addSubview(thumb)
            thumb.snp.makeConstraints {
                $0.left.top.bottom.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0))
                $0.width.equalTo(100)
                $0.height.equalTo(143)
            }
            KF.url(URL(string: item.thumb))
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .onProgress { receivedSize, totalSize in  }
                .onSuccess { result in  }
                .onFailure { error in }
                .set(to: thumb)
            
            contentView.addSubview(title)
            title.snp.makeConstraints {
                $0.left.equalTo(thumb.snp.right).offset(10)
                $0.right.equalToSuperview().offset(-10)
                $0.height.equalTo(30)
                $0.top.equalTo(thumb)
            }
            title.text = item.title
            
            contentView.addSubview(en)
            en.snp.makeConstraints {
                $0.left.equalTo(thumb.snp.right).offset(10)
                $0.right.equalToSuperview().offset(-10)
                $0.height.equalTo(20)
                $0.top.equalTo(title.snp.bottom).offset(5)
            }
            en.text = item.en
            
            contentView.addSubview(release_movie_time)
            release_movie_time.snp.makeConstraints {
                $0.left.equalTo(thumb.snp.right).offset(10)
                $0.right.equalToSuperview().offset(-10)
                $0.height.equalTo(30)
                $0.bottom.equalTo(thumb)
            }
            release_movie_time.text = item.release_movie_time
            
            if (style.contains("MyFavourite")) {
                contentView.addSubview(discard)
                discard.snp.makeConstraints {
                    $0.right.equalToSuperview().offset(10)
                    $0.height.equalTo(96)
                    $0.width.equalTo(96)
                    $0.centerY.equalTo(thumb)
                }
            }
        }
    }
}

