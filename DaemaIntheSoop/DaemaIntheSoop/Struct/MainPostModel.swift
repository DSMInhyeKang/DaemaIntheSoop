//
//  PostInfo.swift
//  DaemaIntheSoop
//
//  Created by 강인혜 on 2022/06/17.
//

import Foundation

struct MainPostModel: Codable {
    let content: [Content]
}

struct Content: Codable {
    var id: Int
    var username: String
    var title: String
    var content: String
    var comments: [String]
}
