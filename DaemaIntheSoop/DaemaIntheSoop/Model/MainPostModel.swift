//
//  PostInfo.swift
//  DaemaIntheSoop
//
//  Created by 강인혜 on 2022/06/17.
//

import Foundation

struct MainPostModel: Codable {
    var content = [Content]()
}

struct Content: Codable {
    var id: Int = .init()
    var username: String = .init()
    var title: String = .init()
    var content: String = .init()
    var comments: [String] = .init()
}
