//
//  Extension+UIButton.swift
//  Hide-Face
//
//  Created by Данила on 11.12.2023.
//

import Foundation
import UIKit


extension UIButton {
    func applyCustomStyle(size: Size) -> UIButton {
        self.backgroundColor = UIColor.buttonColor
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .highlighted)
        self.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        self.layer.cornerRadius = 22
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 4
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: size.scaleWidth(327)).isActive = true
        self.heightAnchor.constraint(equalToConstant: size.scaleHeight(58)).isActive = true
        return self
    }
    
    func buttonWithPicker(size: Size, text: String) {
        self.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        self.layer.cornerRadius = 13
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(text, for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.contentHorizontalAlignment = .left
        let padding: CGFloat = 10.0
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        self.widthAnchor.constraint(equalToConstant: size.scaleWidth(320)).isActive = true
        self.heightAnchor.constraint(equalToConstant: size.scaleHeight(32)).isActive = true
    }
    
    func buttonsRegLog(text: String, size: Size) -> UIButton {
        self.setTitle(text, for: .normal)
        self.setTitleColor(.buttonColor, for: .normal)
        self.setTitleColor(.buttonColor.withAlphaComponent(0.5), for: .highlighted)
        self.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func buttonsProfile(size: Size, image: UIImage, width: CGFloat, height: CGFloat) -> UIButton {
        self.setImage(image, for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        self.tintColor = .black
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: size.scaleWidth(width)).isActive = true
        self.heightAnchor.constraint(equalToConstant: size.scaleHeight(height)).isActive = true
        self.imageView?.translatesAutoresizingMaskIntoConstraints = false
        self.imageView?.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.imageView?.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        return self
    }
}
