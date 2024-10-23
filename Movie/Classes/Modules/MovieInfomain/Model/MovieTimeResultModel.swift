//
//  MovieTimeResultModel.swift
//  Movie
//
//  Created by User on 2024/10/2.
//

import Foundation

class MovieTimeResultModel: Codable {
    /// 单条新闻内容(返回数据为 JSON 字符串)
    let id: String
    let theater: String
    let types: [TypesModel]
}
