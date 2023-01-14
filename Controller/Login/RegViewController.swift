//
//  RegViewController.swift
//  SimpleChat
//
//  Created by Станислав Шульц on 10.01.2023.
//

import UIKit

class RegViewController: UIViewController {
    
    var delegate: LoginViewControllerDelegate!
    var checkField = CheckField.shared
    var service = Service.shared
    
    @IBOutlet var regMainView: UIView!
    
    var tapGest: UITapGestureRecognizer?
    
    @IBOutlet weak var emailOutlet: UITextField!
    @IBOutlet weak var passOutlet: UITextField!
    @IBOutlet weak var confirmPassOutlet: UITextField!
    @IBOutlet weak var emailBorderOutlet: UIView!
    @IBOutlet weak var passBorederOutlet: UIView!
    @IBOutlet weak var confimPassBorderOutlet: UIView!
    
    @IBAction func closeVCButton(_ sender: Any) {
        delegate.closeVC()
    }
    @IBAction func regButton(_ sender: Any) {
        if checkField.validField(emailBorderOutlet, emailOutlet),
           checkField.validField(passBorederOutlet, passOutlet)
        {
            if passOutlet.text == confirmPassOutlet.text {
                service.createNewUser(LoginField(email: emailOutlet.text!, password: passOutlet.text!)) { [weak self]
                    code in
                    switch code.code {
                    case 0:
                        print("Ошибка регистрации")
                    case 1:
                        self?.service.confirmEmail()
                        let alert = UIAlertController(title: "Success", message: "Регистрация прошла успешно", preferredStyle: .alert)
                        let okBtn = UIAlertAction(title: "Авторизоваться", style: .default) { _ in
                            self?.delegate.closeVC()
                        }
                        alert.addAction(okBtn)
                        self?.present(alert, animated: true)
                    default:
                        print("Неизвестная ошибка®")
                    }
                }
            } else {
                print("At least one field is incorrect")
            }
        }
    }
    @IBAction func haveAccButton(_ sender: Any) {
        
    }
    
    @objc func endEditing() {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGest = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        regMainView.addGestureRecognizer(tapGest!)

        // Do any additional setup after loading the view.
    }
    
    


}
