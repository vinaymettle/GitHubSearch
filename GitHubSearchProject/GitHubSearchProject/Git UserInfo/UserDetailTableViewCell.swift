//
//  UserDetailTableViewCell.swift
//  GitHubSearchProject
//
//  Created by Vinay Ponna on 3/31/20.
//  Copyright © 2020 Vinay Ponna. All rights reserved.
//

import UIKit

class UserDetailTableViewCell: UITableViewCell {
    @IBOutlet var repoNameLabel: UILabel!
    @IBOutlet var forksLabel: UILabel!
    @IBOutlet var starsLabel: UILabel!

    func configure(with gitRepo: GitRepos) {
        repoNameLabel.text = gitRepo.repoName
        forksLabel.text = String("\(gitRepo.forks ?? 0) forks")
        starsLabel.text = String("\(gitRepo.stars ?? 0) stars")
      }
}
