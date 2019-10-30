//
//  CustomTextField.swift
//  Tinder
//
//  Created by Adrian Kremski on 30/10/2019.
//  Copyright © 2019 Adrian Kremski. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    let padding: CGFloat
    
    init(padding: CGFloat) {
        self.padding = padding
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.layer.cornerRadius = 25
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 0, height: 50)
    }
}
