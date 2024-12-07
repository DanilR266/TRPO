//
//  Extension+MainScreenConroller.swift
//  Hide-Face
//
//  Created by Данила on 15.01.2024.
//

import Foundation
import UIKit
import AVFoundation
import AVKit
import MobileCoreServices


extension MainScreenController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.mainView.buttonDeleteFace.isUserInteractionEnabled = true
            self.playerViewController.removeFromParent()
            self.playerViewController.view.removeFromSuperview()
            self.player?.pause()
            self.mediaURL = nil
            mainView.imageView.image = selectedImage
            //            mainView.imageView.widthAnchor.constraint(equalToConstant: model.getWidthForImage(heightDefault: size.scaleWidth(261), heightImage: selectedImage.size.width)).isActive = true
            mainView.placeholderLabel.text = ""
        }
        if let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String {
            if mediaType == kUTTypeMovie as String {
                    if let mediaURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
                        print(mediaURL, "Video")
                        self.mainView.buttonDeleteFace.isUserInteractionEnabled = true
                        mainView.imageView.image = nil
                        self.mediaURL = mediaURL
                        print("MediaURL set", self.mediaURL)
                        self.playerViewController.removeFromParent()
                        self.playerViewController.view.removeFromSuperview()
                        self.player?.pause()
                        showVideoPlaybackController(with: mediaURL)
                    }
                }
        }
        activityIndicator.stopAnimating()
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        activityIndicator.stopAnimating()
        picker.dismiss(animated: true, completion: nil)
    }
    
    
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
            self.playerViewController.view.frame = self.mainView.imageView.bounds
        }

        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        
        // Добавить плеер на экран
//        addChild(playerViewController)
        mainView.imageView.addSubview(playerViewController.view)
        playerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerViewController.view.widthAnchor.constraint(equalTo: mainView.imageView.widthAnchor),
            playerViewController.view.heightAnchor.constraint(equalTo: mainView.imageView.heightAnchor)
        ])
        playerViewController.view.isUserInteractionEnabled = true
        mainView.imageView.isUserInteractionEnabled = true
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
    
    @objc func handleTapPlayer() {
        print("Tap", player?.rate)
        if let player = player {
            if player.rate == 0 {
                // Видео на паузе, начать воспроизведение
                player.play()
            } else {
                // Видео воспроизводится, поставить на паузу
                player.pause()
            }
        }
    }
}


extension MainScreenController {
    
    func enableButtons(bool: Bool) {
        mainView.buttonAlgorithm.isEnabled = bool
        mainView.buttonTypeFace.isEnabled = bool
        mainView.buttonQuality.isEnabled = bool
        mainView.buttonBorder.isEnabled = bool
        mainView.buttonLogo.isEnabled = bool
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        picker.removeFromSuperview()
        enableButtons(bool: true)
        for i in 0..<buttonsActive.count {
            if buttonsActive[i] {
                switch i {
                case 0:
                    mainView.buttonAlgorithm.setTitle(pickerData[row], for: .normal)
                case 1:
                    mainView.buttonTypeFace.setTitle(pickerData[row], for: .normal)
                case 2:
                    mainView.buttonQuality.setTitle(pickerData[row], for: .normal)
                case 3:
                    mainView.buttonBorder.setTitle(pickerData[row], for: .normal)
                case 4:
                    mainView.buttonLogo.setTitle(pickerData[row], for: .normal)
                default:
                    continue
                }
            }
        }
        buttonsActive = buttonsActive.map { _ in false }
    }
    
    func didSelectValue(_ value: String, forPicker pickerView: UIPickerView) {
        print(value, "SELECTED")
        picker.removeFromSuperview()
    }
}









