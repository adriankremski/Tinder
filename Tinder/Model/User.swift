//
//  User.swift
//  Tinder
//
//  Created by Adrian Kremski on 29/10/2019.
//  Copyright © 2019 Adrian Kremski. All rights reserved.
//

import Foundation
import UIKit

struct User : ProducesCardViewModel{
    let name: String
    let age: Int
    let profession: String
    let imageName: String
    
    func toCardViewModel() -> CardViewModel {
        let nameAttributes = [
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(32), weight: .heavy)
        ]
        
        let nameAttributedText = NSMutableAttributedString(string: name, attributes: nameAttributes)
        
        let ageAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(24), weight: .light)
        ]
         
        let ageAttributedText = NSMutableAttributedString(string:"  \(age)", attributes: ageAttributes)
         
         
        let professionAttributes = [
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(20))
        ]
         
        let professionAttributedText = NSMutableAttributedString(string:"\n\(profession)", attributes: professionAttributes)

        nameAttributedText.append(ageAttributedText)
        nameAttributedText.append(professionAttributedText)
        
        return CardViewModel(
            imageName: imageName, attributedString: nameAttributedText, textAlignment: .left
        )
    }
}
