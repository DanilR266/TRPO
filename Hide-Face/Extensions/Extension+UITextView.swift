//
//  Extension+UITextView.swift
//  Hide-Face
//
//  Created by Данила on 25.12.2023.
//

import Foundation
import UIKit

extension UILabel {
    
    func customTextView(text: String) -> UILabel {
        self.text = text
        self.font = .systemFont(ofSize: 16, weight: .regular)
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
}
