//
//  GitUserDetailViewController.swift
//  GitHubSearchProject
//
//  Created by Vinay Ponna on 3/31/20.
//  Copyright © 2020 Vinay Ponna. All rights reserved.
//

import UIKit

class GitUserDetailViewController: UIViewController {

   public var selectedUserData: [GitHubUser] = []
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var infoLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet private var followersLabel: UILabel!
    @IBOutlet private var emailLabel: UILabel!
    @IBOutlet private var tableView: UITableView!

    private let cellIdentifier = "UserDetailTableViewCell"
    private var gitRepos: [GitRepos] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)

        NetworkManager().fetchUserdetails(userName: (selectedUserData.first?.login)!) {[weak self] (GitUserInfo) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.userNameLabel.text = GitUserInfo.name
                self.followersLabel.text = String(format: "\(GitUserInfo.followers ?? 0) followers")
                self.locationLabel.text = GitUserInfo.location
                self.emailLabel.text = GitUserInfo.email
            }
        }

        NetworkManager().fetchRepos(userName: (selectedUserData.first?.login)!) {[weak self] (gitRepos) in
            guard let self = self else { return }
            self.gitRepos = gitRepos
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }

        }
        userNameLabel.text = selectedUserData.first?.login
        infoLabel.text = "This is their biography. It may be long and needs to all fit"
        guard let url = selectedUserData.first?.avatarURL,
                let data = try? Data(contentsOf: url) else {
                    return
            }
            avatarImageView.image = UIImage(data: data)
        }
    }
    
extension GitUserDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gitRepos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? UserDetailTableViewCell else {
            fatalError("Issue dequeuing \(cellIdentifier)")
        }
        cell.configure(with: gitRepos[indexPath.row])
        return cell

    }


}

