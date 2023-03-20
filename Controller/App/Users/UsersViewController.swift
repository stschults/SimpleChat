//
//  UsersViewController.swift
//  SimpleChat
//
//  Created by Станислав Шульц on 14.01.2023.
//

import UIKit

class UsersViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    let service = Service.shared
    var users = [CurrentUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: UserTableViewCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        getUsers()
    }
    
    func getUsers() {
        service.getAllUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    
}


extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.reuseID, for: indexPath) as! UserTableViewCell
        cell.selectionStyle = .none
        let cellName = users[indexPath.row]
        cell.configCell(cellName.email)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userID = users[indexPath.row].id
        let vc = ChatViewController()
        vc.otherID = userID
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
