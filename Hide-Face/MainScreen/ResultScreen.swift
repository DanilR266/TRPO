//
//  ResultScreen.swift
//  Hide-Face
//
//  Created by Данила on 17.03.2024.
//

import Foundation
import UIKit
import AVFoundation
import AVKit
import MobileCoreServices
import Photos


class ResultScreenController: UIViewController {
    
    init(type1: String, type2: String, type3: String, type4: String, type5: String) {
        self.type1 = type1
        self.type2 = type2
        self.type3 = type3
        self.type4 = type4
        self.type5 = type5
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let type1: String
    let type2: String
    let type3: String
    let type4: String
    let type5: String
    let resultView = ResultView()
    var dataImage: Data?
    var player: AVPlayer?
    var dataFromHistory: Data?
    var playerViewController = AVPlayerViewController()
    var mediaURL: URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Результат".localize()
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        if let dataFromHistory = dataFromHistory {
            if let image = UIImage(data: dataFromHistory) {
                resultView.imageResult.image = UIImage(data: dataFromHistory)
            } else {
                let fileManager = FileManager.default
                let temporaryDirectory = fileManager.temporaryDirectory
                let videoName = "video.mp4" // Название вашего видео файла
                let videoURL = temporaryDirectory.appendingPathComponent(videoName)
                do {
                    try dataFromHistory.write(to: videoURL)
                    self.playerViewController.removeFromParent()
                    self.playerViewController.view.removeFromSuperview()
                    self.player?.pause()
                    showVideoPlaybackController(with: videoURL)
                } catch {
                    print("Ошибка при сохранении видео: \(error.localizedDescription)")
                }
            }
        }
        if let dataImage = dataImage {
            resultView.imageResult.image = UIImage(data: dataImage)
        } else {
            if let mediaURL = mediaURL {
                self.playerViewController.removeFromParent()
                self.playerViewController.view.removeFromSuperview()
                self.player?.pause()
                showVideoPlaybackController(with: mediaURL)
            }
        }
        buttonTap()
    }
    
    override func loadView() {
        super.loadView()
        self.view = resultView
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.playerViewController.removeFromParent()
//        self.playerViewController.view.removeFromSuperview()
        self.player?.pause()
    }
    
    private func buttonTap() {
        resultView.buttonSave.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)
        resultView.checkInfo.addTarget(self, action: #selector(buttonInfoResult), for: .touchUpInside)
    }
    
    @objc func buttonInfoResult() {
        print(type1)
        let vc = ResultInfoScreen()
        vc.type1 = type1
        vc.type2 = type2
        vc.type3 = type3
        vc.type4 = type4
        vc.type5 = type5
        present(vc, animated: true)
    }
    
    @objc func downloadButtonTapped(_ sender: UIButton) {
        if let dataImage = dataImage, let image = UIImage(data: dataImage) {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageSaved(_:didFinishSavingWithError:contextInfo:)), nil)
        }
        else if let dataImage = dataFromHistory {
            
            if let image2 = UIImage(data: dataImage) {
                UIImageWriteToSavedPhotosAlbum(image2, self, #selector(imageSaved(_:didFinishSavingWithError:contextInfo:)), nil)
            } else {
                let fileManager = FileManager.default
                let temporaryDirectory = fileManager.temporaryDirectory
                let videoName = "video.mp4" // Название вашего видео файла
                let videoURL = temporaryDirectory.appendingPathComponent(videoName)
                do {
                    try dataImage.write(to: videoURL)
                    saveVideoToLibrary(at: videoURL)
                } catch {
                    print("Ошибка при сохранении видео: \(error.localizedDescription)")
                    self.showAlert(title: "Ошибка сохранения результата".localize())
                }
            }
        }
        else if let mediaURL = mediaURL {
            saveVideoToLibrary(at: mediaURL)
        }
    }
    
    func saveVideoToLibrary(at videoURL: URL) {
        PHPhotoLibrary.shared().performChanges({
            let request = PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: videoURL)
            request?.creationDate = Date()
        }) { success, error in
            if success {
                DispatchQueue.main.async {
                    print("Видео успешно сохранено в галерею.")
                    self.showAlert(title: "Результат сохранен в галерею".localize())
                }
            } else {
                DispatchQueue.main.async {
                    print("Ошибка сохранения видео в галерею: \(error?.localizedDescription ?? "Unknown error")")
                    self.showAlert(title: "Ошибка сохранения результата".localize())
                }
            }
        }
    }
    
    // Функция, вызываемая после сохранения изображения
    @objc func imageSaved(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // Если при сохранении возникла ошибка, выводим сообщение об ошибке
            showAlert(title: "Ошибка сохранения результата".localize())
        } else {
            // Если сохранение прошло успешно, выводим сообщение об успешном сохранении
            showAlert(title: "Результат сохранен в галерею".localize())
        }
    }
    
    func showAlert(title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}


extension ResultScreenController {

    func showVideoPlaybackController(with videoURL: URL) {
        //        let playbackViewController = VideoPlaybackViewController()
        //        playbackViewController.videoURL = videoURL
        //        present(playbackViewController, animated: true, completion: nil)
        self.player = AVPlayer(url: videoURL)
        playerViewController.player = player
        
        // Масштабирование видео для заполнения экрана
        playerViewController.videoGravity = .resizeAspectFill
        
        // Показывать контролы плеера
        playerViewController.showsPlaybackControls = true
        
        // Разрешить вращение устройства во время воспроизведения видео
        NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
            self.playerViewController.view.frame = self.resultView.imageResult.bounds
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        
        // Добавить плеер на экран
        //        addChild(playerViewController)
        resultView.imageResult.addSubview(playerViewController.view)
        playerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerViewController.view.widthAnchor.constraint(equalTo: resultView.imageResult.widthAnchor),
            playerViewController.view.heightAnchor.constraint(equalTo: resultView.imageResult.heightAnchor)
        ])
        playerViewController.view.isUserInteractionEnabled = true
        resultView.imageResult.isUserInteractionEnabled = true
        playerViewController.view.backgroundColor = .clear
        
        // Установить размер плеера в размер экрана
        //        playerViewController.view.frame = view.bounds
        
        // Начать воспроизведение видео
        player?.play()
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        if let playerItem = note.object as? AVPlayerItem {
            // Сбросить воспроизведение к началу
            playerItem.seek(to: CMTime.zero)
            player?.play()
        }
    }
}
