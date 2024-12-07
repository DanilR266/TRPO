//
//  Extension+UILabel.swift
//  Hide-Face
//
//  Created by Данила on 24.12.2023.
//

import Foundation
import UIKit


extension UILabel {
    func customTitle(text: String) -> UILabel {
        self.text = text
        self.font = .systemFont(ofSize: 20, weight: .bold)
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func titleScreen(text: String, weight: UIFont.Weight) -> UILabel {
        self.text = text
        self.font = .systemFont(ofSize: 20, weight: weight)
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func loginScreen(text: String) -> UILabel {
        self.text = text
        self.font = .systemFont(ofSize: 20, weight: .regular)
        self.textColor = .black
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
