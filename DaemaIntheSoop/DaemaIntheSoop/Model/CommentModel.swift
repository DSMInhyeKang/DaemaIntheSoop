//
//  CommentModel.swift
//  DaemaIntheSoop
//
//  Created by 강인혜 on 2022/08/06.
//

import Foundation

struct CommentModel: Codable {
    var content = [Reply]()
}

struct Reply: Codable {
    var commentId: Int = .init()
    var username: String = .init()
    var comment: String = .init()
}
