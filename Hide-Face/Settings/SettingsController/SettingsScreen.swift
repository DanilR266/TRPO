//
//  SettingsScreen.swift
//  Hide-Face
//
//  Created by Данила on 18.04.2024.
//

import Foundation
import UIKit


class SettingsScreen: UIViewController, UITextFieldDelegate {
    let settingsView = SettingsView()
    let model = ModelLogin()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Настройки".localize()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        buttonsTap()
    }
    
    override func loadView() {
        super.loadView()
        self.view = settingsView
    }
    
    private func setupTextFields() {
        settingsView.oldPassword.delegate = self
        settingsView.newPassword.delegate = self
    }
    
    private func buttonsTap() {
        settingsView.buttonChange.addTarget(self, action: #selector(buttonSaveTap), for: .touchUpInside)
        settingsView.buttonLanguage.addTarget(self, action: #selector(buttonLanguageTap), for: .touchUpInside)
    }
    
    @objc func buttonLanguageTap() {
        showLanguageChangeAlert(in: self)
    }
    
    @objc func buttonSaveTap() {
        let name = UserDefaults.standard.value(forKey: "UserName") as? String
        print(name, type(of: name), settingsView.oldPassword.text!, settingsView.newPassword.text!)
        if let name = name {
            model.changePassword(email: name, oldPassword: settingsView.oldPassword.text!, newPassword: settingsView.newPassword.text!, controller: self) { result in
                switch result {
                case .success(let success):
                    print("success")
                case .failure(let failure):
                    print("error", failure)
                }
            }
        }
    }
    
    func showAlert(title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func changeLanguage() {
        // Переключаемся на следующий язык из списка
        
        let currentLanguage = UserDefaults.standard.string(forKey: "AppLanguage") ?? Locale.current.languageCode
        let newLanguage: String
        if currentLanguage == "ru" {
            newLanguage = "en"
        } else {
            newLanguage = "ru"
        }
        Bundle.setLanguage(newLanguage)
        UserDefaults.standard.set(newLanguage, forKey: "AppLanguage")
    }
    
    func showLanguageChangeAlert(in viewController: UIViewController) {
        let alertController = UIAlertController(
            title: "Смена языка".localize(),
            message: "Для изменения языка необходимо перезапустить приложение.".localize(),
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.changeLanguage()
            exit(0)
        }
        let cancelAction = UIAlertAction(title: "Отмена".localize(), style: .cancel) { _ in

        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
}
