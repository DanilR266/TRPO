//
//  ResultView.swift
//  Hide-Face
//
//  Created by Данила on 17.03.2024.
//

import Foundation
import UIKit


class ResultView: UIView {
    
    let size = Size()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Удаление лиц завершено!".localize()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageResult: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: size.scaleWidth(327)).isActive = true
        image.heightAnchor.constraint(equalToConstant: size.scaleHeight(255)).isActive = true
        return image
    }()
    
    lazy var checkInfo = UIButton().buttonsRegLog(text: "Посмотреть информацию".localize(), size: size)
    
    lazy var buttonSave = UIButton().applyCustomStyle(size: size)
    private func setupButtons() {
        buttonSave.setTitle("Скачать результат".localize(), for: .normal)
    }
    
    private func setUpConstait() {
        setupButtons()
        addSubview(descriptionLabel)
        addSubview(imageResult)
        addSubview(buttonSave)
        addSubview(checkInfo)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: size.scaleHeight(112)),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            imageResult.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageResult.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: size.scaleHeight(25)),
            
            buttonSave.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonSave.topAnchor.constraint(equalTo: imageResult.bottomAnchor, constant: size.scaleHeight(25)),
            
            checkInfo.centerXAnchor.constraint(equalTo: buttonSave.centerXAnchor),
            checkInfo.topAnchor.constraint(equalTo: buttonSave.bottomAnchor, constant: size.scaleHeight(16)),
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUpConstait()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
