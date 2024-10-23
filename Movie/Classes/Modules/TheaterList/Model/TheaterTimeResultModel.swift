//
//  TheaterResultModel.swift
//  Movie
//
//  Created by User on 2024/9/7.
//

import Foundation

struct TheaterTimeResultModel: Codable {
    /// 单条新闻内容(返回数据为 JSON 字符串)
    let id: String
    let release_foto: String
    let theaterlist_name: String
    let length: String
    let icon: String
    let types: [TypesModel]
}

