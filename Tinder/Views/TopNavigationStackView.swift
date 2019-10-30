//
//  TopNavigationStackView.swift
//  Tinder
//
//  Created by Adrian Kremski on 29/10/2019.
//  Copyright © 2019 Adrian Kremski. All rights reserved.
//

import UIKit

class TopNavigationStackView: UIStackView {

    let settingsButton : UIButton = {
        let button = UIButton(type: .system)
        // Rendering mode is needed to be set, without it the icons will have blue color
        button.setImage(UIImage(named: "top_left_profile")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let fireButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "app_icon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let messageButton : UIButton = {
        let button = UIButton(type: .system)
        
        button.setImage(UIImage(named: "top_right_messages")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        distribution = .equalCentering
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        [settingsButton, UIView(), fireButton, UIView(), messageButton].forEach { (view) in
            addArrangedSubview(view)
        }
        
        // Adding margins to the stack view
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}
