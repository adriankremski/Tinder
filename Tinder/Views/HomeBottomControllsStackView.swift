//
//  HomeBottomControllsStackView.swift
//  Tinder
//
//  Created by Adrian Kremski on 29/10/2019.
//  Copyright © 2019 Adrian Kremski. All rights reserved.
//

import UIKit

class HomeBottomControllsStackView: UIStackView {

   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let views = ["refresh_circle", "dismiss_circle", "super_like_circle", "like_circle", "boost_circle"].map { (image) -> UIView in
            let button = UIButton(type: .system)
            button.setImage(UIImage(named: image)?.withRenderingMode(.alwaysOriginal), for: .normal)
            return button
        }

        views.forEach { (view) in
            addArrangedSubview(view)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}
