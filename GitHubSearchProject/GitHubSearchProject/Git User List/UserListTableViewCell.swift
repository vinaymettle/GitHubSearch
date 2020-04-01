//
//  UserListTableViewCell.swift
//  GitHubSearchProject
//
//  Created by Vinay Ponna on 3/31/20.
//  Copyright © 2020 Vinay Ponna. All rights reserved.
//

import UIKit

class UserListTableViewCell: UITableViewCell {
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var repoLabel: UILabel!

    func configure(with gitHubUser: GitHubUser) {
        userNameLabel.text = gitHubUser.login
        repoLabel.text = String(format: "Repo: \(gitHubUser.id ?? 0)")
        guard let url = gitHubUser.avatarURL,
            let data = try? Data(contentsOf: url) else {
                return
        }
        avatarImageView.image = UIImage(data: data)
    }
}

