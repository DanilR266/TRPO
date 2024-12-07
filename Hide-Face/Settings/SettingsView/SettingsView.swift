//
//  SettingsView.swift
//  Hide-Face
//
//  Created by Данила on 18.04.2024.
//

import Foundation
import UIKit


class SettingsView: UIView {
    let size = Size()
    lazy var titleChange: UILabel = {
        let label = UILabel()
        label.text = "Сменить пароль".localize()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
    
    lazy var oldPassword = UITextField().signIn(text: "Старый пароль".localize(), size: size)
    lazy var newPassword = UITextField().signIn(text: "Новый пароль".localize(), size: size)
    lazy var buttonChange = UIButton().applyCustomStyle(size: size)
    
    private func setupUI() {
        buttonChange.setTitle("Сохранить".localize(), for: .normal)
        addSubview(buttonLanguage)
        addSubview(titleChange)
        addSubview(oldPassword)
        addSubview(newPassword)
        addSubview(buttonChange)
        
        NSLayoutConstraint.activate([
            buttonLanguage.topAnchor.constraint(equalTo: topAnchor, constant: size.scaleHeight(109)),
            buttonLanguage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -size.scaleWidth(29)),
            
            titleChange.topAnchor.constraint(equalTo: topAnchor, constant: size.scaleHeight(187)),
            titleChange.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            oldPassword.topAnchor.constraint(equalTo: titleChange.bottomAnchor, constant: size.scaleHeight(20)),
            oldPassword.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            newPassword.topAnchor.constraint(equalTo: oldPassword.bottomAnchor, constant: size.scaleHeight(20)),
            newPassword.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            buttonChange.topAnchor.constraint(equalTo: newPassword.bottomAnchor, constant: size.scaleHeight(20)),
            buttonChange.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
