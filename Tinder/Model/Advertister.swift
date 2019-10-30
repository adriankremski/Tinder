//
//  Advertister.swift
//  Tinder
//
//  Created by Adrian Kremski on 30/10/2019.
//  Copyright © 2019 Adrian Kremski. All rights reserved.
//

import Foundation
import UIKit

struct Advertiser : ProducesCardViewModel{
    let title: String
    let brandName: String
    let posterPhotoName: String
    
    func toCardViewModel() -> CardViewModel {
        let titleAttrs = [
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(34), weight: .heavy)
        ]
        
        let titleAttrText = NSMutableAttributedString(string: title, attributes: titleAttrs)
         
        let subtitleAttrs = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(24), weight: .bold)
        ]
         
        let subtitleAttrText = NSMutableAttributedString(string:"\n\(brandName)", attributes: subtitleAttrs)

        titleAttrText.append(subtitleAttrText)
        
        return CardViewModel(
            imageNames: [posterPhotoName], attributedString: titleAttrText, textAlignment: .center
        )
    }
}
