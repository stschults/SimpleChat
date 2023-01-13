//
//  SlideCollectionViewCell.swift
//  SimpleChat
//
//  Created by Станислав Шульц on 22.12.2022.
//

import UIKit

class SlideCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var registerButtonOutlet: UIButton!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    
    var delegate: LoginViewControllerDelegate!
    
    @IBAction func registerButton(_ sender: Any) {
    }
    @IBAction func loginButton(_ sender: Any) {
        delegate.openAuthVC()
    }
    @IBAction func regButton(_ sender: Any) {
        delegate.openRegVC()
    }
    
    
    static let reuseID = "SlideCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureSlide(slide: Model) {
        backgroundImage.image = slide.img
        descriptionText.text = slide.text
        if slide.id == 1 {
            registerButtonOutlet.isHidden = false
            loginButtonOutlet.isHidden = false
        }
    }
    
}
