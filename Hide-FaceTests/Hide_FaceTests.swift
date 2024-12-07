//
//  Hide_FaceTests.swift
//  Hide-FaceTests
//
//  Created by Данила on 23.04.2024.
//

import XCTest
@testable import Hide_Face

class TestableMainScreenController: MainScreenController {
    var testNavigationController: UINavigationController?

    override var navigationController: UINavigationController? {
        get {
            return testNavigationController
        }
        set {
            testNavigationController = newValue
        }
    }
}

final class MainScreenXCTest: XCTestCase {
    
    
    func testHandleTapOutsidePicker() {
        // Arrange
        let mainScreenController = TestableMainScreenController()
        mainScreenController.loadViewIfNeeded()
        
        mainScreenController.picker = UIPickerView(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
        mainScreenController.view.addSubview(mainScreenController.picker)
        
        mainScreenController.enableButtons(bool: false)
        mainScreenController.buttonsActive = [true, true, true, true, true]

        let tapGesture = UITapGestureRecognizer(target: mainScreenController, action: nil)
        
        let locationOutsidePicker = CGPoint(x: 10, y: 10)
        tapGesture.state = .ended
        tapGesture.setValue(locationOutsidePicker, forKey: "locationInView")
        
        // Act
        mainScreenController.handleTap(tapGesture)
        
        // Assert
        XCTAssertTrue(mainScreenController.buttonsActive.allSatisfy { $0 == false }, "All buttons should be inactive")
        XCTAssertEqual(mainScreenController.picker.superview, nil, "Picker should be removed from superview")
    }
}




final class LoginScreenControllerTests: XCTestCase {
    
    
    func testInputValid() {
        let loginScreenController = ModelLogin()
        
        XCTAssertTrue(loginScreenController.validUserInputEmail("test@mail.com"), "Email is valid")
        XCTAssertTrue(loginScreenController.validUserInputPassword("Qwerty65"), "Password is valid")
        
        XCTAssertFalse(loginScreenController.validUserInputEmail("test$mail.com"), "Email is invalid")
        XCTAssertFalse(loginScreenController.validUserInputPassword("Qwerty6"), "Password is invalid")
        
    }
    
    func testButtonLoginTap() {
        // Arrange
        let loginScreenController = LoginScreenController()
        loginScreenController.loadViewIfNeeded()
        
        // Act
        loginScreenController.buttonLoginTap()
        
        // Assert
        // Проверяем, что флаг "SignIn" установлен в UserDefaults
        let signInValue = UserDefaults.standard.bool(forKey: "SignIn")
        XCTAssertFalse(signInValue, "SignIn flag should be set to true in UserDefaults")
        
        // Получаем текущий корневой контроллер приложения
        let window = UIApplication.shared.windows.first
        let rootViewController = window?.rootViewController
        
        // Проверяем, что rootViewController является UITabBarController
        guard let tabBarController = rootViewController as? UITabBarController else {
            XCTFail("Root view controller should be UITabBarController")
            return
        }
        
        // Проверяем, что у tabBarController есть 2 контроллера вкладок
        XCTAssertEqual(tabBarController.viewControllers?.count, 2, "Tab bar controller should have 2 view controllers")
        
        // Проверяем, что первый контроллер вкладки является MainScreenController
        let firstController = tabBarController.viewControllers?[0] as? UINavigationController
        XCTAssertNotNil(firstController, "First tab controller should be UINavigationController")
        XCTAssertTrue(firstController?.topViewController is MainScreenController, "Top view controller of first tab should be MainScreenController")
        
        // Проверяем, что второй контроллер вкладки является ProfileScreenController
        let secondController = tabBarController.viewControllers?[1] as? UINavigationController
        XCTAssertNotNil(secondController, "Second tab controller should be UINavigationController")
//        XCTAssertTrue(secondController?.topViewController is ProfileScreenController, "Top view controller of second tab should be ProfileScreenController")
        
        // Дополнительные проверки можно добавить в зависимости от требований
    }
    
    
    func testUpdateButtonColor() {
        // Arrange
        let loginScreenController = LoginScreenController()
        loginScreenController.loadViewIfNeeded()
        
        // Настройте поля ввода
        let loginField = loginScreenController.loginView.loginField
        let passwordField = loginScreenController.loginView.passwordField
        
        // Установим текст в оба поля
        loginField.text = "username"
        passwordField.text = "password"
        
        // Act
        loginScreenController.updateButtonColor()
        
        // Assert
        // Проверяем, что кнопки активированы и имеют правильный цвет
        XCTAssertTrue(loginScreenController.loginView.buttonLogin.isEnabled, "Login button should be enabled")
        XCTAssertEqual(loginScreenController.loginView.buttonLogin.backgroundColor, .buttonColor, "Login button background color should be buttonColor")
        XCTAssertEqual(loginScreenController.loginView.buttonLogin.titleColor(for: .normal), .white, "Login button title color should be white")
        
        XCTAssertTrue(loginScreenController.loginView.buttonRegistration.isEnabled, "Registration button should be enabled")
        XCTAssertEqual(loginScreenController.loginView.buttonRegistration.backgroundColor, .buttonColor, "Registration button background color should be buttonColor")
        XCTAssertEqual(loginScreenController.loginView.buttonRegistration.titleColor(for: .normal), .white, "Registration button title color should be white")
        
        // Тестирование случаев с пустым текстом
        loginField.text = ""  // Устанавливаем пустой текст в поле логина
        loginScreenController.updateButtonColor()
        
        // Проверяем, что кнопки отключены и имеют правильный цвет с альфа-каналом
        XCTAssertFalse(loginScreenController.loginView.buttonLogin.isEnabled, "Login button should be disabled")
        XCTAssertEqual(loginScreenController.loginView.buttonLogin.backgroundColor, .buttonColor.withAlphaComponent(0.5), "Login button background color should be buttonColor with alpha 0.5")
        XCTAssertEqual(loginScreenController.loginView.buttonLogin.titleColor(for: .normal), .white.withAlphaComponent(0.5), "Login button title color should be white with alpha 0.5")
        
        XCTAssertFalse(loginScreenController.loginView.buttonRegistration.isEnabled, "Registration button should be disabled")
        XCTAssertEqual(loginScreenController.loginView.buttonRegistration.backgroundColor, .buttonColor.withAlphaComponent(0.5), "Registration button background color should be buttonColor with alpha 0.5")
        XCTAssertEqual(loginScreenController.loginView.buttonRegistration.titleColor(for: .normal), .white.withAlphaComponent(0.5), "Registration button title color should be white with alpha 0.5")
    }
    
    func testChangeLanguage() {
        // Arrange
        let loginScreenController = ProfileScreenController()
        loginScreenController.loadViewIfNeeded()
        UserDefaults.standard.set("ru", forKey: "AppLanguage")
        loginScreenController.changeLanguage()
        
        // Assert
        let newLanguage = UserDefaults.standard.string(forKey: "AppLanguage")
        XCTAssertEqual(newLanguage, "en", "The language should be changed to 'en'")

        loginScreenController.changeLanguage()

        let revertedLanguage = UserDefaults.standard.string(forKey: "AppLanguage")
        XCTAssertEqual(revertedLanguage, "ru", "The language should be changed back to 'ru'")
    }
    
    func testExit() {
        let loginScreenController = ProfileScreenController()
        loginScreenController.loadViewIfNeeded()
        
        loginScreenController.buttonExit()
        
        XCTAssertFalse(UserDefaults.standard.bool(forKey: "SignIn"), "App is logout")
    }
}


