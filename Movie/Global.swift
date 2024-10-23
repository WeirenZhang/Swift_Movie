//
//  VideoViewModel.swift
//  Movie
//
//  Created by User on 2024/10/2.
//

import SnapKit
import SQLite

//MARK: SnapKit
extension ConstraintView {
    
    var usnp: ConstraintBasicAttributesDSL {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        } else {
            return self.snp
        }
    }
}

let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
let db = try? Connection("\(path)/Movie.sqlite")

let movie = Table("movie")
let theater = Table("theater")

let id = Expression<Int64>("id")
let ahref = Expression<String>("ahref")
let imgsrc = Expression<String>("imgsrc")
let release_movie_name = Expression<String>("release_movie_name")
let en = Expression<String>("en")
let release_movie_time = Expression<String>("release_movie_time")

let href = Expression<String>("href")
let name = Expression<String>("name")
let tel = Expression<String>("tel")
let adds = Expression<String>("adds")



