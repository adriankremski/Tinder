//
//  RegistrationViewModel.swift
//  Tinder
//
//  Created by Adrian Kremski on 31/10/2019.
//  Copyright © 2019 Adrian Kremski. All rights reserved.
//

import Foundation
import UIKit

class RegistrationViewModel {
    var fullName: String? {
        didSet {
            checkFormValidity()
        }
    }
    
    var email: String? {
        didSet {
            checkFormValidity()
        }
    }
    
    var password: String? {
        didSet {
            checkFormValidity()
        }
    }
    
    var isFormValidObserver: ((Bool) -> ())?

    fileprivate func checkFormValidity() {
        isFormValidObserver?(fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false)
    }
}
