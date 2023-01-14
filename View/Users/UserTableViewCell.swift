//
//  UserTableViewCell.swift
//  SimpleChat
//
//  Created by Станислав Шульц on 14.01.2023.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    static let reuseID = "UserTableViewCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(_ name: String) {
        userName.text = name
    }
    
    func setupCell() {
        parentView.layer.cornerRadius = 10
        userImage.layer.cornerRadius = userImage.frame.width / 2
    }
}
