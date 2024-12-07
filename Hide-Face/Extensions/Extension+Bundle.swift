//
//  Extension+Bundle.swift
//  Hide-Face
//
//  Created by Данила on 21.04.2024.
//

import Foundation
import UIKit


extension Bundle {
    static var bundle: Bundle?
    
    static func setLanguage(_ language: String) {
        object_setClass(Bundle.main, LocalizableBundle.self)
        bundle = Bundle(path: Bundle.main.path(forResource: language, ofType: "lproj")!)
    }
}

class LocalizableBundle: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        return Bundle.bundle?.localizedString(forKey: key, value: value, table: tableName) ?? super.localizedString(forKey: key, value: value, table: tableName)
    }
}
