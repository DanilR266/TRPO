//
//  Extension+String.swift
//  Hide-Face
//
//  Created by Данила on 21.04.2024.
//

import Foundation


import Foundation

public extension String {
    func localize(tableName: String? = "Localizable", comment: String = "") -> String {
        // Получаем текущий язык из UserDefaults
        let languageCode = UserDefaults.standard.string(forKey: "AppLanguage") ?? Locale.current.languageCode

        // Получаем bundle с учетом языка, заданного в UserDefaults
        let bundle: Bundle
        if let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
           let langBundle = Bundle(path: path) {
            bundle = langBundle
        } else {
            bundle = Bundle.main // Если путь не найден, используем основной Bundle
        }

        // Возвращаем локализованную строку
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: "", comment: comment)
    }
}

