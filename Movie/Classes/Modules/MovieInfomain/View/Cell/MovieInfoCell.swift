//
//  UComicTCell.swift
//  U17
//
//  Created by charles on 2023/11/8.
//  Copyright © 2023年 None. All rights reserved.
//

import UIKit
import Reusable
import Kingfisher

class MovieInfoCell: TableViewCell, Reusable {
    
    var movie_intro_foto: UIImageView = {
        let iw = UIImageView()
        iw.contentMode = .scaleAspectFill
        iw.clipsToBounds = true
        return iw
    }()
    
    var _h1_h3: UILabel = {
        let tl = UILabel()
        tl.backgroundColor = UIColor.black
        tl.font = UIFont.systemFont(ofSize: 18)
        tl.textColor = UIColor.white
        return tl
    }()
    
    var h1: UILabel = {
        let tl = UILabel()
        tl.textColor = UIColor.darkGray
        tl.font = UIFont.systemFont(ofSize: 16)
        return tl
    }()
    
    var h3: UILabel = {
        let tl = UILabel()
        tl.textColor = UIColor.darkGray
        tl.font = UIFont.systemFont(ofSize: 16)
        return tl
    }()
    
    var _icon: UILabel = {
        let sl = UILabel()
        sl.font = UIFont.systemFont(ofSize: 18)
        sl.backgroundColor = UIColor.black
        sl.textColor = UIColor.white
        return sl
    }()
    
    var icon: UIImageView = {
        let iw = UIImageView()
        iw.contentMode = .scaleAspectFill
        iw.clipsToBounds = true
        return iw
    }()
    
    var _release_movie_time: UILabel = {
        let dl = UILabel()
        dl.numberOfLines = 1
        dl.font = UIFont.systemFont(ofSize: 18)
        dl.backgroundColor = UIColor.black
        dl.textColor = UIColor.white
        return dl
    }()
    
    var release_movie_time: UILabel = {
        let dl = UILabel()
        dl.textColor = UIColor.darkGray
        dl.numberOfLines = 1
        dl.font = UIFont.systemFont(ofSize: 16)
        return dl
    }()
    
    var _length: UILabel = {
        let dl = UILabel()
        dl.numberOfLines = 1
        dl.backgroundColor = UIColor.black
        dl.textColor = UIColor.white
        dl.font = UIFont.systemFont(ofSize: 18)
        return dl
    }()
    
    var length: UILabel = {
        let dl = UILabel()
        dl.textColor = UIColor.darkGray
        dl.numberOfLines = 1
        dl.font = UIFont.systemFont(ofSize: 16)
        return dl
    }()
    
    var _director: UILabel = {
        let dl = UILabel()
        dl.numberOfLines = 1
        dl.backgroundColor = UIColor.black
        dl.textColor = UIColor.white
        dl.font = UIFont.systemFont(ofSize: 18)
        return dl
    }()
    
    var director: UILabel = {
        let dl = UILabel()
        dl.textColor = UIColor.darkGray
        dl.numberOfLines = 0
        dl.font = UIFont.systemFont(ofSize: 16)
        return dl
    }()
    
    var _actor: UILabel = {
        let dl = UILabel()
        dl.numberOfLines = 1
        dl.backgroundColor = UIColor.black
        dl.textColor = UIColor.white
        dl.font = UIFont.systemFont(ofSize: 18)
        return dl
    }()
    
    var actor: UILabel = {
        let dl = UILabel()
        dl.textColor = UIColor.darkGray
        dl.numberOfLines = 0
        dl.font = UIFont.systemFont(ofSize: 16)
        return dl
    }()
    
    public var item: MovieInfoModel? {
        
        didSet {
            
            guard let item else { return }
            separatorInset = .zero
            
            backgroundColor = UIColor.white
            
            contentView.addSubview(movie_intro_foto)
            movie_intro_foto.snp.makeConstraints {
                $0.left.top.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
                $0.width.equalTo(.screenWidth - 0)
                $0.height.equalTo((.screenWidth * 167) / 100)
            }
            KF.url(URL(string: item.movie_intro_foto))
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .onProgress { receivedSize, totalSize in  }
                .onSuccess { result in  }
                .onFailure { error in }
                .set(to: movie_intro_foto)
            
            contentView.addSubview(_h1_h3)
            _h1_h3.snp.makeConstraints {
                $0.left.equalToSuperview().offset(0)
                $0.right.equalToSuperview().offset(0)
                $0.top.equalTo(movie_intro_foto.snp.bottom).offset(0)
            }
            _h1_h3.text = "電影名稱"
            
            contentView.addSubview(h1)
            h1.snp.makeConstraints {
                $0.left.equalToSuperview().offset(10)
                $0.right.equalToSuperview().offset(-10)
                $0.top.equalTo(_h1_h3.snp.bottom).offset(10)
            }
            h1.text = item.h1
            
            contentView.addSubview(h3)
            h3.snp.makeConstraints {
                $0.left.equalToSuperview().offset(10)
                $0.right.equalToSuperview().offset(-10)
                $0.top.equalTo(h1.snp.bottom).offset(10)
            }
            h3.text = item.h3
            
            contentView.addSubview(_icon)
            _icon.snp.makeConstraints {
                $0.left.equalToSuperview().offset(0)
                $0.right.equalToSuperview().offset(0)
                $0.top.equalTo(h3.snp.bottom).offset(10)
            }
            _icon.text = "電影分級"
            
            contentView.addSubview(icon)
            icon.snp.makeConstraints {
                $0.left.equalToSuperview().offset(10)
                $0.width.equalTo(50)
                $0.height.equalTo(50)
                $0.top.equalTo(_icon.snp.bottom).offset(10)
            }
            KF.url(URL(string: item.icon))
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .onProgress { receivedSize, totalSize in  }
                .onSuccess { result in  }
                .onFailure { error in }
                .set(to: icon)
            
            contentView.addSubview(_release_movie_time)
            _release_movie_time.snp.makeConstraints {
                $0.left.equalToSuperview().offset(0)
                $0.right.equalToSuperview().offset(0)
                $0.top.equalTo(icon.snp.bottom).offset(10)
            }
            _release_movie_time.text = "上映日期"
            
            contentView.addSubview(release_movie_time)
            release_movie_time.snp.makeConstraints {
                $0.left.equalToSuperview().offset(10)
                $0.right.equalToSuperview().offset(-10)
                $0.top.equalTo(_release_movie_time.snp.bottom).offset(10)
            }
            release_movie_time.text = item.release_movie_time
            
            contentView.addSubview(_length)
            _length.snp.makeConstraints {
                $0.left.equalToSuperview().offset(0)
                $0.right.equalToSuperview().offset(0)
                $0.top.equalTo(release_movie_time.snp.bottom).offset(10)
            }
            _length.text = "電影長度"
            
            contentView.addSubview(length)
            length.snp.makeConstraints {
                $0.left.equalToSuperview().offset(10)
                $0.right.equalToSuperview().offset(-10)
                $0.top.equalTo(_length.snp.bottom).offset(10)
            }
            length.text = item.length
            
            contentView.addSubview(_director)
            _director.snp.makeConstraints {
                $0.left.equalToSuperview().offset(0)
                $0.right.equalToSuperview().offset(0)
                $0.top.equalTo(length.snp.bottom).offset(10)
            }
            _director.text = "導演"
            
            contentView.addSubview(director)
            director.snp.makeConstraints {
                $0.left.equalToSuperview().offset(10)
                $0.right.equalToSuperview().offset(-10)
                $0.top.equalTo(_director.snp.bottom).offset(10)
            }
            director.text = item.director
            
            contentView.addSubview(_actor)
            _actor.snp.makeConstraints {
                $0.left.equalToSuperview().offset(0)
                $0.right.equalToSuperview().offset(0)
                $0.top.equalTo(director.snp.bottom).offset(10)
            }
            _actor.text = "演員"
            
            contentView.addSubview(actor)
            actor.snp.makeConstraints {
                $0.right.equalToSuperview().offset(-10)
                $0.left.bottom.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 0))
                $0.top.equalTo(_actor.snp.bottom).offset(10)
            }
            actor.text = item.actor
        }
    }
}
