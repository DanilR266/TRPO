//
//  ProfileView.swift
//  Hide-Face
//
//  Created by Данила on 17.01.2024.
//

import Foundation
import UIKit


class LoginView: UIView {
    
    let size = Size()
    
    lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "Logo")
        logo.contentMode = .scaleAspectFill
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        return logo
    }()
    
    lazy var loginField = UITextField().signIn(text: "Логин".localize(), size: size)
    lazy var passwordField = UITextField().signIn(text: "Пароль".localize(), size: size)
    lazy var buttonLogin = UIButton().applyCustomStyle(size: size)
    lazy var buttonRegistration = UIButton().applyCustomStyle(size: size)
    
    lazy var textRegistration = UILabel().loginScreen(text: "Создать аккаунт?".localize())
    lazy var textLogin = UILabel().loginScreen(text: "Уже есть аккаунт?".localize())
    
    lazy var subButtonReg = UIButton().buttonsRegLog(text: "Регистрация".localize(), size: size)
    lazy var subButtonLogin = UIButton().buttonsRegLog(text: "Войти".localize(), size: size)
    let scrollView = UIScrollView()
    lazy var stackView1: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    lazy var stackView2: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private func setupButtons() {
        buttonLogin.setTitle("Войти".localize(), for: .normal)
        buttonLogin.isEnabled = false
        buttonLogin.backgroundColor = .buttonColor.withAlphaComponent(0.5)
        buttonLogin.setTitleColor(.white.withAlphaComponent(0.5), for: .normal)
        buttonRegistration.setTitle("Регистрация".localize(), for: .normal)
        buttonRegistration.backgroundColor = .buttonColor.withAlphaComponent(0.5)
        buttonRegistration.setTitleColor(.white.withAlphaComponent(0.5), for: .normal)
        buttonRegistration.isEnabled = false
        buttonRegistration.accessibilityIdentifier = "buttonRegistration"
        
        passwordField.accessibilityIdentifier = "passwordField"
        loginField.accessibilityIdentifier = "emailField"
    }
    
    lazy var buttonLanguage: UIButton = {
        let button = UIButton()
        button.setTitle(UserDefaults.standard.string(forKey: "AppLanguage") ?? Locale.current.languageCode, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: size.scaleWidth(82)).isActive = true
        button.heightAnchor.constraint(equalToConstant: size.scaleHeight(55)).isActive = true
        return button
    }()
    
    
    private func setUpConstraints() {
        setupButtons()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        scrollView.addSubview(logo)
        scrollView.addSubview(buttonLanguage)
        scrollView.addSubview(loginField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(buttonRegistration)
        scrollView.addSubview(buttonLogin)
        scrollView.addSubview(stackView1)
        stackView1.addArrangedSubview(textRegistration)
        stackView1.addArrangedSubview(subButtonReg)
        scrollView.addSubview(stackView2)
        stackView2.addArrangedSubview(textLogin)
        stackView2.addArrangedSubview(subButtonLogin)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            logo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: size.scaleHeight(75)),
            logo.widthAnchor.constraint(equalToConstant: size.scaleWidth(158)),
            logo.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            logo.heightAnchor.constraint(equalToConstant: size.scaleWidth(158)),
            
            buttonLanguage.topAnchor.constraint(equalTo: topAnchor, constant: size.scaleHeight(115)),
            buttonLanguage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -size.scaleWidth(24)),
            
            loginField.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: size.scaleHeight(20)),
            passwordField.topAnchor.constraint(equalTo: loginField.bottomAnchor, constant: size.scaleHeight(16)),
            
            buttonLogin.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: size.scaleHeight(24)),
//            buttonLogin.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            buttonRegistration.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: size.scaleHeight(24)),
//            buttonRegistration.leadingAnchor.constraint(equalTo: trailingAnchor, constant: 50),
            
            stackView1.topAnchor.constraint(equalTo: buttonLogin.bottomAnchor, constant: size.scaleHeight(16)),
            stackView1.centerXAnchor.constraint(equalTo: buttonLogin.centerXAnchor),
            
            stackView2.topAnchor.constraint(equalTo: buttonRegistration.bottomAnchor, constant: size.scaleHeight(16)),
            stackView2.centerXAnchor.constraint(equalTo: buttonRegistration.centerXAnchor),
            
            
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        setUpConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
