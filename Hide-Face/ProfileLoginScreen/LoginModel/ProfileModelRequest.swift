//
//  ProfileModelRequest.swift
//  Hide-Face
//
//  Created by Данила on 11.05.2024.
//

import Foundation
import UIKit


class ModelProfileRequest {
    
    func getJob(id: Int, controller: UIViewController, completion: @escaping (Result<Data, Error>) -> Void) {
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.center = controller.view.center
        controller.view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
        controller.view.isUserInteractionEnabled = false
        let stringServer: String = "\(Constatnts.transferProtocol.rawValue)\(Constatnts.serverURL.rawValue)/v1/job-auth?id=\(id)"
//        var session = URLSession.shared
        guard let url = URL(string: stringServer) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            controller.view.isUserInteractionEnabled = true
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json, photo/*, video/*", forHTTPHeaderField: "Accept")
        let jwt = UserDefaults.standard.string(forKey: "JWT")!
        print(jwt)
        request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { [self] data, response, error in

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
                print("200 Get Good")
                print(data, "Data")
                DispatchQueue.main.async {
                    loadingIndicator.stopAnimating()
                }
                if let data = data {
                    completion(.success((data)))
                }
            case 202:
                if let data = data {
                    do {
                        let loginResponseError = try JSONDecoder().decode(ResponseError.self, from: data)
                        DispatchQueue.main.async {
                            self.showError(in: controller, message: "В обработке")
                        }
                    } catch {
                        // Обработка ошибки декодирования
                        completion(.failure(error))
                    }
                }
                print("202 wait")
            default:
                DispatchQueue.main.async {
                    loadingIndicator.stopAnimating()
                }
                if let data = data {
                    do {
                        let loginResponseError = try JSONDecoder().decode(ResponseError.self, from: data)
                        DispatchQueue.main.async {
                            self.showError(in: controller, message: loginResponseError.message)
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
    
    
    func showError(in viewController: UIViewController, message: String) {
        // Создаем UIAlertController с заголовком и сообщением
        let alert = UIAlertController(
            title: "Ошибка".localize(),
            message: message,
            preferredStyle: .alert
        )
        
        // Добавляем действие "ОК", чтобы пользователь мог закрыть алерт
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        
        // Показываем алерт на переданном ViewController'е
        viewController.present(alert, animated: true, completion: nil)
    }
    
}
