//
//  RegistrationViewController.swift
//  Tinder
//
//  Created by Adrian Kremski on 30/10/2019.
//  Copyright © 2019 Adrian Kremski. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 300).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    let fullNameTextField: CustomTextField = {
        let textField = CustomTextField(padding: 24)
        textField.placeholder = "Enter full name"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 25
        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textField
    }()
    
    let emailTextField: CustomTextField = {
        let textField = CustomTextField(padding: 24)
        textField.placeholder = "Email"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 25
        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textField
    }()
    
    let passwordTextField: CustomTextField = {
        let textField = CustomTextField(padding: 24)
        textField.placeholder = "Enter password"
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textField
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .lightGray
        button.setTitleColor(.darkGray, for: .disabled)
        button.isEnabled = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 25
        return button
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Go to login"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy fileprivate var fieldsStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [selectPhotoButton, fullNameTextField, emailTextField, passwordTextField, registerButton])
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        return stackView
    }()
    
    lazy fileprivate var mainStackView = UIStackView(arrangedSubviews: [selectPhotoButton, fieldsStackView])
    
    private let gradientLayer = CAGradientLayer()
    fileprivate let registrationViewModel = RegistrationViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientLayer()
        setupLayout()
        setupNotificationObservers()
        setupTapGesture()
        
        registrationViewModel.isFormValidObserver = { (isValid) in
            if (isValid) {
                self.registerButton.backgroundColor = #colorLiteral(red: 0.8032532334, green: 0.1261852384, blue: 0.3370009065, alpha: 1)
                self.registerButton.setTitleColor(.white, for: .normal)
                self.registerButton.isEnabled = true
            } else {
                self.registerButton.backgroundColor = .lightGray
                self.registerButton.setTitleColor(.darkGray, for: .disabled)
                self.registerButton.isEnabled = false
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Remember to remove reference to self! Otherwise you will get a memory leak
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = view.frame
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        invalidateViewsDependingOnOrientation()
    }
    
    @objc fileprivate func handleTextChange(textField: UITextField) {
        if textField == fullNameTextField {
            registrationViewModel.fullName = fullNameTextField.text
        } else if textField == emailTextField {
            registrationViewModel.email = emailTextField.text
        } else if textField == passwordTextField {
            registrationViewModel.password = passwordTextField.text
        }
    }
    
    //MARK: - Private
    
    fileprivate func invalidateViewsDependingOnOrientation() {
        if self.traitCollection.verticalSizeClass == .compact {
            mainStackView.axis = .horizontal
            selectPhotoButton.widthAnchor.constraint(equalToConstant: 275).isActive = true
        } else {
            mainStackView.axis = .vertical
        }
    }
    
    fileprivate func setupGradientLayer() {
        let topColor = #colorLiteral(red: 0.9886363149, green: 0.365362227, blue: 0.3822939992, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.8938800097, green: 0.1125626937, blue: 0.4639956951, alpha: 1)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }
    
    fileprivate func setupLayout() {
        view.addSubview(mainStackView)
        mainStackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top:0, left:50, bottom: 0, right: 50))
        mainStackView.axis = .vertical
        mainStackView.spacing = 8
        mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(loginLabel)
        loginLabel.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 32, right: 0))
        
        invalidateViewsDependingOnOrientation()
    }
    
    fileprivate func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func handleKeyboardShow(notifiation: Notification) {
        guard let value = notifiation.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let keyboardFrame = value.cgRectValue
        
        let bottomSpace = view.frame.height - mainStackView.frame.origin.y - mainStackView.frame.height
        let difference = keyboardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference)
    }
    
    @objc fileprivate func handleKeyboardHide(notifiation: Notification) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        })
    }
    
    fileprivate func setupTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    @objc fileprivate func handleTapDismiss() {
        self.view.endEditing(true) // dismisses keyboard
    }
}
