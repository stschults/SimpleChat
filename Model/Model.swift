//
//  Slide.swift
//  SimpleChat
//
//  Created by Станислав Шульц on 22.12.2022.
//

import UIKit

enum AuthResponce {
    case success, error, noVerify
}

struct Model {
    var id: Int
    var text: String
    var img: UIImage
}

struct LoginField {
    var email: String
    var password: String
}

struct ResponceCode {
    var code: Int
}

struct CurrentUser {
    var id: String
    var email: String
}
