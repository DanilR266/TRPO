//
//  ProfileView.swift
//  Hide-Face
//
//  Created by Данила on 04.02.2024.
//

import Foundation
import UIKit


class ProfileView: UIView {

    let size = Size()
    
    lazy var helloLabel = UILabel().titleScreen(text: "Приветствуем,".localize(), weight: .regular)
    lazy var nameLabel = UILabel().titleScreen(text: "user@gmail.com", weight: .bold)
    
    lazy var buttonSettings = UIButton().buttonsProfile(size: size, image: UIImage(systemName: "gearshape.fill")!, width: 42, height: 42)
    lazy var buttonLogout = UIButton().buttonsProfile(size: size, image: UIImage(systemName: "rectangle.portrait.and.arrow.forward")!, width: 50, height: 50)
    
    lazy var creditsText = UILabel().titleScreen(text: "Количество кредитов:".localize(), weight: .regular)
    
    lazy var viewCredits: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 9
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: size.scaleWidth(92)).isActive = true
        view.heightAnchor.constraint(equalToConstant: size.scaleHeight(30)).isActive = true
        return view
    }()
    
    lazy var grayLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 217/255)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: size.screenWidth()).isActive = true
        view.heightAnchor.constraint(equalToConstant: size.scaleHeight(2)).isActive = true
        return view
    }()
    
    lazy var textHistory: UILabel = {
        let label = UILabel()
        label.text = "История запросов".localize()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var creditsCount = UILabel().titleScreen(text: "0", weight: .bold)
    
    lazy var buttonCredits = UIButton().applyCustomStyle(size: size)
    
    private func setUpConstraints() {
        buttonCredits.isHidden = true
        addSubview(helloLabel)
        addSubview(nameLabel)
        addSubview(buttonSettings)
        addSubview(buttonLogout)
        addSubview(creditsText)
        addSubview(viewCredits)
        viewCredits.addSubview(creditsCount)
        addSubview(buttonCredits)
        buttonCredits.setTitle("Купить кредиты".localize(), for: .normal)
        addSubview(grayLine)
        addSubview(textHistory)
        NSLayoutConstraint.activate([
            helloLabel.topAnchor.constraint(equalTo: topAnchor, constant: size.scaleHeight(120)),
            helloLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: size.scaleWidth(24)),
            nameLabel.leadingAnchor.constraint(equalTo: helloLabel.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: helloLabel.bottomAnchor, constant: size.scaleHeight(5)),
            nameLabel.trailingAnchor.constraint(equalTo: buttonSettings.leadingAnchor),
            
            buttonLogout.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -size.scaleWidth(24)),
            buttonLogout.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            
            buttonSettings.trailingAnchor.constraint(equalTo: buttonLogout.leadingAnchor, constant: -size.scaleWidth(10)),
            buttonSettings.centerYAnchor.constraint(equalTo: buttonLogout.centerYAnchor),
            
            creditsText.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: size.scaleHeight(47)),
            creditsText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: size.scaleWidth(24)),
            
            viewCredits.centerYAnchor.constraint(equalTo: creditsText.centerYAnchor),
            viewCredits.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -size.scaleWidth(24)),
            creditsCount.centerYAnchor.constraint(equalTo: viewCredits.centerYAnchor),
            creditsCount.centerXAnchor.constraint(equalTo: viewCredits.centerXAnchor),
            
            buttonCredits.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonCredits.topAnchor.constraint(equalTo: creditsText.bottomAnchor, constant: size.scaleHeight(26)),
            
//            grayLine.topAnchor.constraint(equalTo: buttonCredits.bottomAnchor, constant: size.scaleHeight(27)),
            grayLine.topAnchor.constraint(equalTo: viewCredits.bottomAnchor, constant: size.scaleHeight(27)),
            grayLine.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            textHistory.centerXAnchor.constraint(equalTo: centerXAnchor),
            textHistory.topAnchor.constraint(equalTo: grayLine.bottomAnchor, constant: size.scaleHeight(27)),
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
