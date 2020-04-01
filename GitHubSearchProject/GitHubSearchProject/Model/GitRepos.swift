//
//  GitRepos.swift
//  GitHubSearchProject
//
//  Created by Vinay Ponna on 3/31/20.
//  Copyright © 2020 Vinay Ponna. All rights reserved.
//

import Foundation

struct GitRepos: Codable {
    let repoName: String?
    let forks: Int?
    let stars: Int?

    private enum CodingKeys: String, CodingKey {
        case repoName = "name"
        case forks
        case stars = "stargazers_count"
    }
}

