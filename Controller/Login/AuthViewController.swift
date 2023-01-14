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
    var service = Service.shared
    var userDefault = UserDefaults.standard
    
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
            service.authInApp(LoginField(email: emailOutlet.text!, password: passOutlet.text!)) { [weak self] responce in
                switch responce {
                case .success:
                    print("next")
                    self?.delegate.startApp()
                    self?.delegate.closeVC()
                    self?.userDefault.set(true, forKey: "isLogin")
                case .noVerify:
                    let alert = self?.alertWindow("Ошибка верификации", "E-mail не верифицирован. На вашу почту отправлена ссылка.")
                    let alertBtn = UIAlertAction(title: "OK", style: .cancel)
                    alert?.addAction(alertBtn)
                    self?.present(alert!, animated: true)
                case .error:
                    let alert = self?.alertWindow("Ошибка", "Неизвестный пароль или e-mail.")
                    let alertBtn = UIAlertAction(title: "OK", style: .cancel)
                    alert?.addAction(alertBtn)
                    self?.present(alert!, animated: true)
                }
            }
        } else {
            let alert = self.alertWindow("Ошибка", "E-mail или пароль не подходят!")
            let alertBtn = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(alertBtn)
            self.present(alert, animated: true)
        }
    }
    
    func alertWindow(_ header: String?, _ message: String?) -> UIAlertController {
        let alert = UIAlertController(title: header, message: message, preferredStyle: .alert)
        
        return alert
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
