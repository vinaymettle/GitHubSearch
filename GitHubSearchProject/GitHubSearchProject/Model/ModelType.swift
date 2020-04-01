//
//  ModelType.swift
//  GitHubSearchProject
//
//  Created by Vinay Ponna on 3/31/20.
//  Copyright © 2020 Vinay Ponna. All rights reserved.
//

import Foundation

struct GitHubUser: Codable {
    let login: String?
    let id: Int?
    let avatarURL: URL?

enum CodingKeys: String, CodingKey {
    case login = "login"
    case id = "id"
    case avatarURL = "avatar_url"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        login = try container.decode(String.self, forKey: .login)
        id = try container.decode(Int.self, forKey: .id)
        avatarURL = try container.decode(URL.self, forKey: .avatarURL )
    }
}


