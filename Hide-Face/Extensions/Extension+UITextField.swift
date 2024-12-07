//
//  Extension+UITextField.swift
//  Hide-Face
//
//  Created by Данила on 29.01.2024.
//

import Foundation
import UIKit


extension UITextField {
    
    func signIn(text: String, size: Size) -> UITextField {
        self.attributedPlaceholder = NSAttributedString(string: text)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 22
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: size.scaleHeight(48)).isActive = true
        self.widthAnchor.constraint(equalToConstant: size.scaleWidth(327)).isActive = true
        self.textRect(forBounds: bounds).inset(by: UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 0))
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: size.scaleWidth(13), height: self.frame.size.height))
        self.leftView = leftPaddingView
        self.leftViewMode = .always
        return self
    }
    
}
