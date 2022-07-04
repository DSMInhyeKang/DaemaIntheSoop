//
//  TokenModel.swift
//  DaemaIntheSoop
//
//  Created by 강인혜 on 2022/07/04.
//

import Foundation

struct TokenModel: Codable {
    let accessToken: String
    let refreshToken: String
    let expiredAt: String
}
