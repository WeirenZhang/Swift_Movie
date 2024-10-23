//
//  MovieDateTabItemModel.swift
//  Movie
//
//  Created by User on 2024/10/2.
//

import Foundation

public struct MovieDateTabItemModel: Codable {
    /// 单条新闻内容(返回数据为 JSON 字符串)
    let date: String
    let list: [MovieTimeTabItemModel]
}
