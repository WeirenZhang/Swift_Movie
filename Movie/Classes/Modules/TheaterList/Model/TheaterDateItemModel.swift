//
//  TheaterDateItemModel.swift
//  Movie
//
//  Created by User on 2024/9/13.
//

import Foundation

public struct TheaterDateItemModel: Codable {
    /// 单条新闻内容(返回数据为 JSON 字符串)
    let date: String
    let data: [TheaterTimeResultModel]
}
