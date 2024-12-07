//
//  ProfileScreen.swift
//  Hide-Face
//
//  Created by Данила on 09.12.2023.
//
import UIKit


class LoginScreenController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    let modelLogin = ModelLogin()
    var loginView = LoginView()
    var size = Size()
    
    var buttonLoginConstraint: NSLayoutConstraint!
    var buttonRegistrationConstraint: NSLayoutConstraint!
    var fieldEdit = false
    var buttonRegTap = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Вход".localize()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        navigationController?.navigationItem.setHidesBackButton(true, animated: false)
        // Do any additional setup after loading the view.
        setUpUI()
//        setUpScrollView()
        buttonsTap()
        setupButtonsAnimation()
        setupTextFields()
    }
    
    
    private func setUpScrollView() {
        loginView.scrollView.delegate = self
        loginView.scrollView.showsVerticalScrollIndicator = false
        loginView.scrollView.isScrollEnabled = false
        loginView.scrollView.contentSize.height = size.screenHeight() + 100
        loginView.scrollView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func buttonsTap() {
        loginView.subButtonReg.addTarget(self, action: #selector(buttonSubRegTap), for: .touchUpInside)
        loginView.subButtonLogin.addTarget(self, action: #selector(buttonSubLoginTap), for: .touchUpInside)
        loginView.buttonLogin.addTarget(self, action: #selector(buttonLoginTap), for: .touchUpInside)
        loginView.buttonRegistration.addTarget(self, action: #selector(buttonRegisterTap), for: .touchUpInside)
        loginView.buttonLanguage.addTarget(self, action: #selector(buttonLanguageTap), for: .touchUpInside)
    }
    
    @objc func buttonLanguageTap() {
        showLanguageChangeAlert(in: self)
    }
    
    @objc private func buttonSubRegTap() {
        buttonLoginConstraint.constant = 500
        buttonRegistrationConstraint.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    @objc private func buttonSubLoginTap() {
        buttonLoginConstraint.constant = 0
        buttonRegistrationConstraint.constant = -500
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func buttonRegisterTap() {
        if fieldEdit {
            let newOffset = CGPoint(x: 0, y: loginView.scrollView.contentOffset.y - size.scaleHeight(110))
            loginView.scrollView.setContentOffset(newOffset, animated: true)
        }
        fieldEdit = false
        if modelLogin.validUserInputEmail(loginView.loginField.text!) && modelLogin.validUserInputPassword(loginView.passwordField.text!) {
            modelLogin.registerUser(email: loginView.loginField.text!, password: loginView.passwordField.text!, controller: self) { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self.loginView.loginField.text = ""
                        self.loginView.passwordField.text = ""
                        self.buttonSubLoginTap()
                        self.view.layoutIfNeeded()
                    }
                case .failure(let error):
                    print("Failed to log in: \(error.localizedDescription)")
                }
            }
        }
    }
    
    
    
    @objc func buttonLoginTap() {
        if fieldEdit {
            let newOffset = CGPoint(x: 0, y: loginView.scrollView.contentOffset.y - size.scaleHeight(110))
            loginView.scrollView.setContentOffset(newOffset, animated: true)
        }
        fieldEdit = false
        if modelLogin.validUserInputEmail(loginView.loginField.text!) && modelLogin.validUserInputPassword(loginView.passwordField.text!) {
            DispatchQueue.main.async {
                UserDefaults.standard.setValue(true, forKey: "SignIn")
                UserDefaults.standard.setValue(self.loginView.loginField.text ?? "user", forKey: "UserName")
                self.view.endEditing(true)
                if let window = UIApplication.shared.windows.first,
                   let tabBar = window.rootViewController as? UITabBarController {
                    let profileVC = ProfileScreenController()
                    let navMain = UINavigationController(rootViewController: MainScreenController())
                    let navLogin = UINavigationController(rootViewController: profileVC)
                    navMain.tabBarItem = UITabBarItem(title: "Главная".localize(), image: nil, tag: 0)
                    navLogin.tabBarItem = UITabBarItem(title: "Профиль".localize(), image: nil, tag: 1)
                    tabBar.viewControllers = [navMain, navLogin]
                }
            }
//            modelLogin.logIn(email: loginView.loginField.text!, password: loginView.passwordField.text!, controller: self) { result in
//                switch result {
//                case .success(let response):
//                    DispatchQueue.main.async {
//                        UserDefaults.standard.setValue(true, forKey: "SignIn")
//                        UserDefaults.standard.setValue(response.token, forKey: "JWT")
//                        UserDefaults.standard.setValue(response.credits, forKey: "Credits")
//                        UserDefaults.standard.setValue(self.loginView.loginField.text ?? "user", forKey: "UserName")
//                        self.view.endEditing(true)
//                        if let window = UIApplication.shared.windows.first,
//                           let tabBar = window.rootViewController as? UITabBarController {
//                            let profileVC = ProfileScreenController()
//                            profileVC.history = response.history
//                            let navMain = UINavigationController(rootViewController: MainScreenController())
//                            let navLogin = UINavigationController(rootViewController: profileVC)
//                            navMain.tabBarItem = UITabBarItem(title: "Главная".localize(), image: nil, tag: 0)
//                            navLogin.tabBarItem = UITabBarItem(title: "Профиль".localize(), image: nil, tag: 1)
//                            tabBar.viewControllers = [navMain, navLogin]
//                        }
//                    }
//                case .failure(let error):
//                    print("Failed to log in: \(error.localizedDescription)")
//                }
//            }
        }
        
        
//        UserDefaults.standard.setValue(true, forKey: "SignIn")
//        self.view.endEditing(true)
//        if let window = UIApplication.shared.windows.first,
//           let tabBar = window.rootViewController as? UITabBarController {
//            let vc = ProfileScreenController()
//            UserDefaults.standard.setValue(self.loginView.loginField.text ?? "user", forKey: "UserName")
//            vc.userName = self.loginView.loginField.text ?? "user"
//            let navMain = UINavigationController(rootViewController: MainScreenController())
//            let navLogin = UINavigationController(rootViewController: vc)
//            
//            navMain.tabBarItem = UITabBarItem(title: "Главная".localize(), image: nil, tag: 0)
//            navLogin.tabBarItem = UITabBarItem(title: "Профиль".localize(), image: nil, tag: 1)
//            tabBar.viewControllers = [navMain, navLogin]
//        }
    }
    
    func changeLanguage() {
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
    
    func updateButtonColor() {
        let hasTextInField1 = !(loginView.loginField.text?.isEmpty ?? true)
        let hasTextInField2 = !(loginView.passwordField.text?.isEmpty ?? true)
        print(hasTextInField1, hasTextInField2)
        if hasTextInField1 && hasTextInField2 {
            loginView.buttonLogin.backgroundColor = .buttonColor
            loginView.buttonLogin.setTitleColor(.white, for: .normal)
            loginView.buttonRegistration.backgroundColor = .buttonColor
            loginView.buttonRegistration.setTitleColor(.white, for: .normal)
            loginView.buttonLogin.isEnabled = true
            loginView.buttonRegistration.isEnabled = true
        } else {
            loginView.buttonLogin.backgroundColor = .buttonColor.withAlphaComponent(0.5)
            loginView.buttonLogin.setTitleColor(.white.withAlphaComponent(0.5), for: .normal)
            loginView.buttonRegistration.backgroundColor = .buttonColor.withAlphaComponent(0.5)
            loginView.buttonRegistration.setTitleColor(.white.withAlphaComponent(0.5), for: .normal)
            loginView.buttonLogin.isEnabled = false
            loginView.buttonRegistration.isEnabled = false
        }
        
    }
    
    private func setupTextFields() {
        loginView.loginField.delegate = self
        loginView.passwordField.delegate = self
    }
    
    private func setupButtonsAnimation() {
        buttonLoginConstraint = loginView.buttonLogin.centerXAnchor.constraint(equalTo: loginView.scrollView.centerXAnchor, constant: 0)
        buttonRegistrationConstraint = loginView.buttonRegistration.centerXAnchor.constraint(equalTo: loginView.scrollView.centerXAnchor, constant: -500)
        NSLayoutConstraint.activate([
            buttonLoginConstraint,
            buttonRegistrationConstraint
        ])
    }
    
    private func setUpUI() {
        view.addSubview(loginView)
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: size.scaleWidth(24)),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -size.scaleWidth(24)),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        setUpScrollView()
    }
}

extension LoginScreenController {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        updateButtonColor()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if !fieldEdit {
            fieldEdit = true
            let newOffset = CGPoint(x: 0, y: loginView.scrollView.contentOffset.y + size.scaleHeight(110))
            loginView.scrollView.setContentOffset(newOffset, animated: true)
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if fieldEdit {
            let newOffset = CGPoint(x: 0, y: loginView.scrollView.contentOffset.y - size.scaleHeight(110))
            loginView.scrollView.setContentOffset(newOffset, animated: true)
        }
        fieldEdit = false
        self.view.endEditing(true)
        return false
    }
}
