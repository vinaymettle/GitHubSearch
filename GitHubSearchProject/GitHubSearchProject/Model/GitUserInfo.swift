//
//  GitUserInfo.swift
//  GitHubSearchProject
//
//  Created by Vinay Ponna on 3/31/20.
//  Copyright © 2020 Vinay Ponna. All rights reserved.
//

import Foundation

struct MyGitHub: Codable {

    let name: String?
    let location: String?
    let followers: Int?
    let avatarUrl: URL?
    let repos: Int?
    let following: Int?
    let email: String?

    private enum CodingKeys: String, CodingKey {
        case name
        case location
        case followers
        case following
        case email
        case repos = "public_repos"
        case avatarUrl = "avatar_url"

    }
}
