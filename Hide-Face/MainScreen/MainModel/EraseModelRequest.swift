//
//  EraseModelRequest.swift
//  Hide-Face
//
//  Created by Данила on 23.04.2024.
//

import Foundation
import UIKit
import AVFoundation

class ModelErase {
    let apiServer: String = "\(Constatnts.transferProtocol.rawValue)s://api.example.com/eraseFaces"
    var timer: Timer?
    var viewShow = false
    let signIn = UserDefaults.standard.bool(forKey: "SignIn")
    let loadingIndicatorGetJob = UIActivityIndicatorView(style: .large)
    func uploadImage(controller: UIViewController, image: UIImage, algorithm: Int, erasionType: Int, videoEncodingQuality: Int, extraPixels: Int, addWatermark: Int, completion: @escaping (Result<HistoryItem, Error>) -> Void) {
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.center = controller.view.center
        controller.view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
        controller.view.isUserInteractionEnabled = false
        var stringURL = String()
        if signIn {
            stringURL = "\(Constatnts.transferProtocol.rawValue)\(Constatnts.serverURL.rawValue)/v1/job-auth?algorithm=\(algorithm)&erasion_type=\(erasionType)&video_encoding_quality=\(videoEncodingQuality)&extra_pixels=\(extraPixels)&add_watermark=\(addWatermark)"
        } else {
            stringURL = "\(Constatnts.transferProtocol.rawValue)\(Constatnts.serverURL.rawValue)/v1/job?algorithm=\(algorithm)&erasion_type=\(erasionType)&video_encoding_quality=\(videoEncodingQuality)&extra_pixels=\(extraPixels)&add_watermark=\(addWatermark)"
        }
        let url = URL(string: stringURL)!
        // generate boundary string using a unique per-app string
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // Генерируем уникальную строку разделителя
        let boundary = UUID().uuidString

        // Заголовки запроса для указания типа содержимого как multipart/form-data с указанием разделителя
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        if signIn {
            let jwt = UserDefaults.standard.string(forKey: "JWT")!
            request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        }
        var body = Data()

        body.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"data\"; filename=\"image.png\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        body.append(image.pngData()!)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        // Устанавливаем тело запроса
        request.httpBody = body

        // Создаем сессию URLSession и отправляем запрос
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                controller.view.isUserInteractionEnabled = true
                loadingIndicator.stopAnimating()
            }
            // Обработка ответа от сервера
            if let error = error {
                print("Error: \(error)")
            } else if let data = data, let response = response as? HTTPURLResponse {
                print("Response status code: \(response.statusCode)")
                if response.statusCode == 200 {
                    let jsonData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    if let json = jsonData as? [String: Any] {
                        print(json)
                    }
                    do {
                        let loginResponse = try JSONDecoder().decode(HistoryItem.self, from: data)
                        print(loginResponse, "Good decode")
                        completion(.success(loginResponse))
                    } catch {
                        completion(.failure(error))
                    }
                }
                else if response.statusCode == 500 {
                    self.showServerErrorAlert(in: controller, message: "Server error")
                }
                else {
                    
                    do {
                        let loginResponseError = try JSONDecoder().decode(ResponseError.self, from: data)
                        DispatchQueue.main.async {
                            self.showErrorAlert(in: controller, message: loginResponseError.message)
                            
                        }
                    } catch {
                        
                    }
                }
            }
        }
        task.resume()
    }
    
    
    func uploadVideo(controller: UIViewController, videoURL: URL, algorithm: Int, erasionType: Int, videoEncodingQuality: Int, extraPixels: Int, addWatermark: Int, completion: @escaping (Result<HistoryItem, Error>) -> Void) {
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.center = controller.view.center
        controller.view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
        controller.view.isUserInteractionEnabled = false
        var stringURL = String()
        if signIn {
            stringURL = "\(Constatnts.transferProtocol.rawValue)\(Constatnts.serverURL.rawValue)/v1/job-auth?algorithm=\(algorithm)&erasion_type=\(erasionType)&video_encoding_quality=\(videoEncodingQuality)&extra_pixels=\(extraPixels)&add_watermark=\(addWatermark)"
        } else {
            stringURL = "\(Constatnts.transferProtocol.rawValue)\(Constatnts.serverURL.rawValue)/v1/job?algorithm=\(algorithm)&erasion_type=\(erasionType)&video_encoding_quality=\(videoEncodingQuality)&extra_pixels=\(extraPixels)&add_watermark=\(addWatermark)"
        }
        let url = URL(string: stringURL)!
        // generate boundary string using a unique per-app string
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let asset = AVURLAsset(url: videoURL)
        for format in asset.availableMetadataFormats {
            print("Format: \(format.rawValue)")
        }
        // Генерируем уникальную строку разделителя
        let boundary = UUID().uuidString

        // Заголовки запроса для указания типа содержимого как multipart/form-data с указанием разделителя
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        if signIn {
            let jwt = UserDefaults.standard.string(forKey: "JWT")!
            request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        }
        // Создаем тело запроса
        var body = Data()

        // Добавляем видео в тело запроса
        body.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"data\"; filename=\"video.mov\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: video/quicktime\r\n\r\n".data(using: .utf8)!)
        do {
            let videoData = try Data(contentsOf: videoURL)
            body.append(videoData)
        } catch {
            print("Error converting video to Data: \(error)".data(using: .utf8)!)
            controller.view.isUserInteractionEnabled = true
            return
        }
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        // Устанавливаем тело запроса
        request.httpBody = body

        // Создаем сессию URLSession и отправляем запрос
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                controller.view.isUserInteractionEnabled = true
                loadingIndicator.stopAnimating()
            }
            // Обработка ответа от сервера
            if let error = error {
                print("Error: \(error)")
            } else if let data = data, let response = response as? HTTPURLResponse {
                print("Response status code: \(response)")
                if response.statusCode == 200 {
                    let jsonData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    if let json = jsonData as? [String: Any] {
                        print(json)
                    }
                    do {
                        let loginResponse = try JSONDecoder().decode(HistoryItem.self, from: data)
                        print(loginResponse, "Good decode")
                        completion(.success(loginResponse))
                    } catch {
                        completion(.failure(error))
                    }
                }
                else if response.statusCode == 500 {
                    self.showServerErrorAlert(in: controller, message: "Server error")
                }
                else {
                    completion( .failure(() as! Error) )
                    do {
                        let loginResponseError = try JSONDecoder().decode(ResponseError.self, from: data)
                        DispatchQueue.main.async {
                            self.showErrorAlert(in: controller, message: loginResponseError.message)
                        }
                    } catch {
                        // Обработка ошибки декодирования
//                        completion(.failure(error))
                    }
                }
            }
        }
        task.resume()
    }
    
    
    func getJob(id: Int, controller: UIViewController, completion: @escaping (Result<Data, Error>) -> Void) {
        DispatchQueue.main.async {
            self.loadingIndicatorGetJob.center = controller.view.center
            controller.view.addSubview(self.loadingIndicatorGetJob)
        }
        var stringServer = String()
        if signIn {
            stringServer = "\(Constatnts.transferProtocol.rawValue)\(Constatnts.serverURL.rawValue)/v1/job-auth?id=\(id)"
        } else {
            stringServer = "\(Constatnts.transferProtocol.rawValue)\(Constatnts.serverURL.rawValue)/v1/job?id=\(id)"
        }
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
        if signIn {
            let jwt = UserDefaults.standard.string(forKey: "JWT")!
            request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        }
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { [self] data, response, error in

            if let error = error {
                completion(.failure(error))
                controller.view.isUserInteractionEnabled = true
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data or invalid response"])))
                controller.view.isUserInteractionEnabled = true
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                print("200 Get Good")
                print(data, "Data")
                
                self.viewShow = false
                DispatchQueue.main.async {
                    self.loadingIndicatorGetJob.stopAnimating()
                    controller.view.isUserInteractionEnabled = true
                    if let data = data {
                        completion(.success((data)))
                    }
                }
            case 202:
                if !self.viewShow {
                    DispatchQueue.main.async {
                        self.loadingIndicatorGetJob.startAnimating()
                        controller.view.isUserInteractionEnabled = false
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    self.getJob(id: id, controller: controller, completion: completion)
                    return
                }
                self.viewShow = true
                print("202 wait")
            default:
                self.viewShow = false
                DispatchQueue.main.async {
                    self.loadingIndicatorGetJob.stopAnimating()
                    controller.view.isUserInteractionEnabled = true
                }
                if let data = data {
                    do {
                        let loginResponseError = try JSONDecoder().decode(ResponseError.self, from: data)
                        DispatchQueue.main.async {
                            self.showErrorAlert(in: controller, message: loginResponseError.message)
                        }
                    } catch {
                        // Обработка ошибки декодирования
//                        completion(.failure(error))
                    }
                }
            }
        }
        
        task.resume()
    }

    
    func showServerErrorAlert(in viewController: UIViewController, message: String) {
        // Создаем UIAlertController с заголовком и сообщением
        let alert = UIAlertController(
            title: "Ошибка сервера".localize(),
            message: message,
            preferredStyle: .alert
        )
        
        // Добавляем действие "ОК", чтобы пользователь мог закрыть алерт
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        
        // Показываем алерт на переданном ViewController'е
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlert(in viewController: UIViewController, message: String) {
        // Создаем UIAlertController с заголовком и сообщением
        let alert = UIAlertController(
            title: "Ошибка".localize(),
            message: message,
            preferredStyle: .alert
        )
        
        // Добавляем действие "ОК", чтобы пользователь мог закрыть алерт
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { handler in
            if message.lowercased() == "unauthorized" {
                if let window = UIApplication.shared.windows.first,
                   let tabBar = window.rootViewController as? UITabBarController {
                    let navMain = UINavigationController(rootViewController: MainScreenController())
                    let navLogin = UINavigationController(rootViewController: LoginScreenController())
                    navMain.tabBarItem = UITabBarItem(title: "Главная".localize(), image: nil, tag: 0)
                    navLogin.tabBarItem = UITabBarItem(title: "Профиль".localize(), image: nil, tag: 1)
                    tabBar.viewControllers = [navMain, navLogin]
                }
            }
        }))
        
        // Показываем алерт на переданном ViewController'е
        viewController.present(alert, animated: true, completion: nil)
    }
}
