//
//  TheaterAreaModel.swift
//  Movie
//
//  Created by User on 2024/9/4.
//

import Foundation

class TheaterAreaModel: Codable {
    /// 单条新闻内容(返回数据为 JSON 字符串)
    let theater_top: String
    let theater_list: [TheaterInfoModel]
}
