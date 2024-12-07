//
//  ModelRequestHistory.swift
//  Hide-Face
//
//  Created by Данила on 12.05.2024.
//

import Foundation
import UIKit


class ModelRequestHistory {
    
    
    func getCurrentHistory(controller: UIViewController, completion: @escaping (Result<[HistoryItem], Error>) -> Void) {
        let stringServer: String = "\(Constatnts.transferProtocol.rawValue)\(Constatnts.serverURL.rawValue)/v1/jobs"
//        var session = URLSession.shared
        guard let url = URL(string: stringServer) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let jwt = UserDefaults.standard.string(forKey: "JWT")!
        print(jwt)
        request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { [self] data, response, error in

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
                if let data = data {
                    do {
                        let loginResponse = try JSONDecoder().decode([HistoryItem].self, from: data)
                        print(loginResponse, "Good decode")
                        completion(.success(loginResponse))
                    } catch {
                        completion(.failure(error))
                    }
                }
            default:
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
    
    
    func deleteHistoryItem(id: Int, controller: UIViewController, completion: @escaping (Result<[HistoryItem], Error>) -> Void) {
        let stringServer: String = "\(Constatnts.transferProtocol.rawValue)\(Constatnts.serverURL.rawValue)/v1/job-auth?id=\(id)"
//        var session = URLSession.shared
        guard let url = URL(string: stringServer) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let jwt = UserDefaults.standard.string(forKey: "JWT")!
        print(jwt)
        request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { [self] data, response, error in

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
                if let data = data {
                    do {
                        let loginResponse = try JSONDecoder().decode([HistoryItem].self, from: data)
                        print(loginResponse, "Good decode")
                        completion(.success(loginResponse))
                    } catch {
                        completion(.failure(error))
                    }
                }
            default:
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
