//
//  UserListViewController.swift
//  GitHubSearchProject
//
//  Created by Vinay Ponna on 3/31/20.
//  Copyright © 2020 Vinay Ponna. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    private let cellIdentifier = "UserListTableViewCell"
    private var gitUsers: [GitHubUser] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)

        NetworkManager().fetchUsers { [weak self] (gitHubUsers) in
            guard let self = self else { return }
            self.gitUsers = gitHubUsers
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gitUsers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? UserListTableViewCell else {
            fatalError("Issue dequeuing \(cellIdentifier)")
        }
        cell.configure(with: gitUsers[indexPath.row])
        return cell
    }
}

extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detail", sender: indexPath)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            guard let indexPath = tableView.indexPathForSelectedRow else {
                return
            }
            let controller = segue.destination as? GitUserDetailViewController
            controller?.selectedUserData = [gitUsers[indexPath.row]]
        }
    }
}
