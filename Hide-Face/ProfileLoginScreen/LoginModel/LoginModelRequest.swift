//
//  LoginModelRequest.swift
//  Hide-Face
//
//  Created by Данила on 23.04.2024.
//

import Foundation
import UIKit


class ModelLogin {
    
    func logIn(email: String, password: String, controller: UIViewController, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.center = controller.view.center
        controller.view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
        controller.view.isUserInteractionEnabled = false
        let stringServer: String = "\(Constatnts.transferProtocol.rawValue)\(Constatnts.serverURL.rawValue)/v1/login"
        print(stringServer)
        var session = URLSession.shared
        guard let url = URL(string: stringServer) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            controller.view.isUserInteractionEnabled = true
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let loginRequest = LoginRequest(id: email, password: password)
        do {
            request.httpBody = try JSONEncoder().encode(loginRequest)
        } catch {
            completion(.failure(error))
            controller.view.isUserInteractionEnabled = true
            return
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                controller.view.isUserInteractionEnabled = true
                loadingIndicator.stopAnimating()
            }
            if let error = error {
                completion(.failure(error))
                return
            }
            print(error?.localizedDescription, "Error request")
            guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data or invalid response"])))
                return
            }
            print(httpResponse.statusCode, "Status Code")
            if httpResponse.statusCode == 200 {
                do {
                    let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                    print(loginResponse, "Good decode")
                    completion(.success(loginResponse))
                } catch {
                    completion(.failure(error))
                }
            }
            else {
                do {
                    let loginResponseError = try JSONDecoder().decode(ResponseError.self, from: data)
                    DispatchQueue.main.async {
                        self.showInvalidPasswordAlert(in: controller, message: loginResponseError.message)
                    }
                } catch {
                    // Обработка ошибки декодирования
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
    func validUserInputEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func validUserInputPassword(_ password: String) -> Bool {
        return password.count >= 16
    }
    
    
    func registerUser(email: String, password: String, controller: UIViewController, completion: @escaping (Result<Void, Error>) -> Void) {
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.center = controller.view.center
        controller.view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
        controller.view.isUserInteractionEnabled = false
        let stringServer: String = "\(Constatnts.transferProtocol.rawValue)\(Constatnts.serverURL.rawValue)/v1/register"
//        var session = URLSession.shared
        guard let url = URL(string: stringServer) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            controller.view.isUserInteractionEnabled = true
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let registerRequest = RegisterRequest(id: email, password: password)
        do {
            request.httpBody = try JSONEncoder().encode(registerRequest)
        } catch {
            completion(.failure(error))
            controller.view.isUserInteractionEnabled = true
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                controller.view.isUserInteractionEnabled = true
                loadingIndicator.stopAnimating()
            }
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data or invalid response"])))
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                print("200 reg")
                completion(.success(()))
            default:
                if let data = data {
                    do {
                        let loginResponseError = try JSONDecoder().decode(ResponseError.self, from: data)
                        DispatchQueue.main.async {
                            self.showInvalidPasswordAlert(in: controller, message: loginResponseError.message)
                        }
                    } catch {
                        // Обработка ошибки декодирования
                        completion(.failure(error))
                    }
                }
            }
        }
        
        task.resume()
    }
    
    
    func changePassword(email: String, oldPassword: String, newPassword: String, controller: UIViewController, completion: @escaping (Result<Void, Error>) -> Void) {
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.center = controller.view.center
        controller.view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
        controller.view.isUserInteractionEnabled = false
        let stringServer: String = "\(Constatnts.transferProtocol.rawValue)\(Constatnts.serverURL.rawValue)/v1/password-reset"
//        var session = URLSession.shared
        guard let url = URL(string: stringServer) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            controller.view.isUserInteractionEnabled = true
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print(UserDefaults.standard.string(forKey: "JWT"))
        let jwt = UserDefaults.standard.string(forKey: "JWT")!
        request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        let changePasswordRequest = ChangePasswordRequest(id: email, old_password: oldPassword, new_password: newPassword)
        do {
            request.httpBody = try JSONEncoder().encode(changePasswordRequest)
            print(String(data: request.httpBody!, encoding: .utf8)!)
        } catch {
            completion(.failure(error))
            controller.view.isUserInteractionEnabled = true
            return
        }
        
        let session = URLSession.shared

        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                controller.view.isUserInteractionEnabled = true
                loadingIndicator.stopAnimating()
            }
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data or invalid response"])))
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                DispatchQueue.main.async {
                    self.goodResponseAlert(in: controller)
                }
                completion(.success(()))
            default:
                if let data = data {
                    do {
                        let loginResponseError = try JSONDecoder().decode(ResponseError.self, from: data)
                        DispatchQueue.main.async {
                            self.showInvalidPasswordAlert(in: controller, message: loginResponseError.message)
                        }
                    } catch {
                        // Обработка ошибки декодирования
                        completion(.failure(error))
                    }
                }
            }
        }
        
        task.resume()
    }
    
    
    
    func showInvalidPasswordAlert(in viewController: UIViewController, message: String) {
        let alert = UIAlertController(
            title: "Ошибка".localize(),
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    func goodResponseAlert(in viewController: UIViewController) {
        // Создаем UIAlertController с заголовком и сообщением
        let alert = UIAlertController(
            title: "Успешно".localize(),
            message: nil,
            preferredStyle: .alert
        )
        
        // Добавляем действие "ОК", чтобы пользователь мог закрыть алерт
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        
        // Показываем алерт на переданном ViewController'е
        viewController.present(alert, animated: true, completion: nil)
    }
    
    
}

