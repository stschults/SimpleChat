//
//  AuthViewController.swift
//  SimpleChat
//
//  Created by Станислав Шульц on 10.01.2023.
//

import UIKit

class AuthViewController: UIViewController {

    var delegate: LoginViewControllerDelegate!
    var checkField = CheckField.shared
    
    @IBOutlet var mainView: UIView!
    
    var tapGest: UITapGestureRecognizer?
    
    @IBOutlet weak var emailOutlet: UITextField!
    @IBOutlet weak var passOutlet: UITextField!
    @IBOutlet weak var emailBorderOutlet: UIView!
    @IBOutlet weak var passBorderOutlet: UIView!
    
    
    
    @IBAction func forgotPassButton(_ sender: Any) {
        
    }
    @IBAction func noAccButton(_ sender: Any) {
        
    }
    @IBAction func closeVCButton(_ sender: Any) {
        delegate.closeVC()
    }
    
    @IBAction func authButton(_ sender: Any) {
        if checkField.validField(emailBorderOutlet, emailOutlet),
           checkField.validField(passBorderOutlet, passOutlet) {
            
        }
    }
    
    @objc func endEditing() {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGest = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        mainView.addGestureRecognizer(tapGest!)
        // Do any additional setup after loading the view.
    }
    


}
