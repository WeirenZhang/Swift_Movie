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
let db = try? Connection("\(path)/db.sqlite3")

let movie = Table("movie")
let theater = Table("theater")

let id = SQLite.Expression<Int64>("id")
let ahref = SQLite.Expression<String>("ahref")
let imgsrc = SQLite.Expression<String>("imgsrc")
let release_movie_name = SQLite.Expression<String>("release_movie_name")
let en = SQLite.Expression<String>("en")
let release_movie_time = SQLite.Expression<String>("release_movie_time")

let href = SQLite.Expression<String>("href")
let name = SQLite.Expression<String>("name")
let tel = SQLite.Expression<String>("tel")
let adds = SQLite.Expression<String>("adds")



