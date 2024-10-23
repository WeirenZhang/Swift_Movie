//
//  TheaterInfoModel.swift
//  Movie
//
//  Created by User on 2024/9/4.
//

import Foundation

struct TheaterInfoModel: Codable {
    /// 单条新闻内容(返回数据为 JSON 字符串)
    let id: String
    let name: String
    let adds: String
    let tel: String
}
