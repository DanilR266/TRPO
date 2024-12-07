//
//  MainView.swift
//  Hide-Face
//
//  Created by Данила on 11.12.2023.
//

import Foundation
import UIKit


class MainView: UIView {
    
    let size = Size()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.contentSize = CGSize(width: frame.width, height: size.scaleHeight(420))
        scrollView.frame = bounds
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.mask
//        imageView.scalesLargeContentImage = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: size.scaleWidth(260)).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: size.scaleHeight(150)).isActive = true
        return imageView
    }()
    lazy var placeholderLabel: UILabel = {
        let placeholderLabel = UILabel()
        placeholderLabel.text = "Предпросмотр".localize()
        placeholderLabel.textColor = .black
        placeholderLabel.textAlignment = .center
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        return placeholderLabel
    }()
    
    lazy var labelAlgorithm: UILabel = {
        let label = UILabel()
        label.titleScreen(text: "Используемый алгоритм".localize(), weight: .regular)
        return label
    }()
    
    lazy var buttonAlgorithm: UIButton = {
        let button = UIButton()
        button.buttonWithPicker(size: size, text: "Face Align + Yolov5l-Face (многоугольники, точно)".localize())
        return button
    }()
    
    lazy var labelTypeFace: UILabel = {
        let label = UILabel()
        label.titleScreen(text: "Тип удаления лица".localize(), weight: .regular)
        return label
    }()
    
    lazy var buttonTypeFace: UIButton = {
        let button = UIButton()
        button.buttonWithPicker(size: size, text: "Размытие".localize())
        return button
    }()
    
    lazy var labelQuality: UILabel = {
        let label = UILabel()
        label.titleScreen(text: "Качество кодирования (видео)".localize(), weight: .regular)
        return label
    }()
    
    lazy var buttonQuality: UIButton = {
        let button = UIButton()
        button.buttonWithPicker(size: size, text: "16".localize())
        return button
    }()
    
    lazy var labelBorder: UILabel = {
        let label = UILabel()
        label.titleScreen(text: "Доп. ободок (в пикселях)".localize(), weight: .regular)
        return label
    }()
    
    lazy var buttonBorder: UIButton = {
        let button = UIButton()
        button.buttonWithPicker(size: size, text: "0")
        return button
    }()
    
    lazy var labelLogo: UILabel = {
        let label = UILabel()
        label.titleScreen(text: "Надпись Hide-Face".localize(), weight: .regular)
        return label
    }()
    
    lazy var buttonLogo: UIButton = {
        let button = UIButton()
        button.buttonWithPicker(size: size, text: "С надписью".localize())
        return button
    }()
    
    lazy var buttonAddFile: UIButton = {
        let button = UIButton()
        button.applyCustomStyle(size: size)
        button.setTitle("Добавить файл (до 100 мб)".localize(), for: .normal)
        button.widthAnchor.constraint(equalToConstant: size.scaleWidth(283)).isActive = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    lazy var buttonCheckInfo: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        button.layer.cornerRadius = size.scaleWidth(34)/2
        button.setTitle("?", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: size.scaleWidth(34)).isActive = true
        button.heightAnchor.constraint(equalToConstant: size.scaleHeight(34)).isActive = true
        return button
    }()
    
    lazy var buttonDeleteFace: UIButton = {
        let button = UIButton()
        button.applyCustomStyle(size: size)
        button.setTitle("Удалить лица".localize(), for: .normal)
        button.isUserInteractionEnabled = false
//        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    private func setUpConstraints() {
        addSubview(imageView)
        addSubview(buttonAddFile)
        addSubview(buttonCheckInfo)
        addSubview(scrollView)
        scrollView.addSubview(labelAlgorithm)
        scrollView.addSubview(buttonAlgorithm)
        scrollView.addSubview(labelTypeFace)
        scrollView.addSubview(buttonTypeFace)
        scrollView.addSubview(labelQuality)
        scrollView.addSubview(buttonQuality)
        scrollView.addSubview(labelBorder)
        scrollView.addSubview(buttonBorder)
        scrollView.addSubview(labelLogo)
        scrollView.addSubview(buttonLogo)
        addSubview(buttonDeleteFace)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 261),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: size.scaleHeight(112)),
            
            buttonAddFile.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: size.scaleHeight(32)),
            buttonAddFile.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            buttonCheckInfo.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonCheckInfo.centerYAnchor.constraint(equalTo: buttonAddFile.centerYAnchor),
            
            scrollView.topAnchor.constraint(equalTo: buttonAddFile.bottomAnchor, constant: 34),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: size.scaleHeight(230)),
            
            labelAlgorithm.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 5),
            buttonAlgorithm.topAnchor.constraint(equalTo: labelAlgorithm.bottomAnchor, constant: 9),
            
            labelTypeFace.topAnchor.constraint(equalTo: buttonAlgorithm.bottomAnchor, constant: 16),
            buttonTypeFace.topAnchor.constraint(equalTo: labelTypeFace.bottomAnchor, constant: 9),
            
            labelQuality.topAnchor.constraint(equalTo: buttonTypeFace.bottomAnchor, constant: 16),
            buttonQuality.topAnchor.constraint(equalTo: labelQuality.bottomAnchor, constant: 9),
            
            labelBorder.topAnchor.constraint(equalTo: buttonQuality.bottomAnchor, constant: 16),
            buttonBorder.topAnchor.constraint(equalTo: labelBorder.bottomAnchor, constant: 9),
            
            labelLogo.topAnchor.constraint(equalTo: buttonBorder.bottomAnchor, constant: 16),
            buttonLogo.topAnchor.constraint(equalTo: labelLogo.bottomAnchor, constant: 9),
            
            buttonDeleteFace.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: size.scaleHeight(32)),
            buttonDeleteFace.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        setPlaceholderText()
    }
    
    func setPlaceholderText() {
        imageView.addSubview(placeholderLabel)
        NSLayoutConstraint.activate([
            placeholderLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            placeholderLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
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
