//
//  Slider.swift
//  SimpleChat
//
//  Created by Станислав Шульц on 10.01.2023.
//

import UIKit

class Slider {
    
    func getSlides() -> [Model] {
        var slides: [Model] = []
        
        let slide1 = Model(id: 1, text: "Пора начать пользоваться чатом",
                           img: UIImage(imageLiteralResourceName: "backimg.jpeg")
        )
        slides.append(slide1)
        return slides
    }
}
