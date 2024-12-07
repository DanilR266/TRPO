//
//  ViewController.swift
//  Hide-Face
//
//  Created by Данила on 09.12.2023.
//

import UIKit
import AVFoundation
import AVKit

class MainScreenController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CustomPickerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    let modelRequest = ModelErase()
    var pickerData = [String]()
    let model = MainModel()
    var mainView = MainView()
    let size = Size()
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    var player: AVPlayer?
    var playerViewController = AVPlayerViewController()
    var picker = UIPickerView()
    var mediaURL: URL?
    var buttonsActive = [false, false, false, false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Главная".localize()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        setUpUI()
        buttonsTarget()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        autoScroll()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.player?.pause()
    }
    
    private func setUpUI() {
        view.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: size.scaleWidth(24)),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -size.scaleWidth(24)),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func autoScroll() {
        let bottomOffset = CGPoint(x: 0, y: mainView.scrollView.contentSize.height - mainView.scrollView.bounds.size.height)
        mainView.scrollView.setContentOffset(bottomOffset, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let topOffset = CGPoint(x: 0, y: -self.mainView.scrollView.contentInset.top)
            self.mainView.scrollView.setContentOffset(topOffset, animated: true)
        }
    }
    
    @objc func presentVCAsBottomSheet() {
        let vc = InfoScreenController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func addFileButtonTapped() {
        let actionSheet = UIAlertController()
        actionSheet.addAction(UIAlertAction(title: "Камера".localize(), style: .default, handler: { _ in
//            self.navigationController?.pushViewController(VideoCaptureViewController(), animated: true)
            self.player?.pause()
            self.activityIndicator.startAnimating()
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            
            // Устанавливаем типы медиа (фото и видео)
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera) ?? []
            
            imagePicker.modalPresentationStyle = .overFullScreen
            self.present(imagePicker, animated: true)
        }))


        actionSheet.addAction(UIAlertAction (title: "Выбрать из галереи".localize(), style: .default, handler: { _ in
            self.player?.pause()
            self.activityIndicator.startAnimating()
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = ["public.image", "public.movie"]
            self.present(imagePicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Отмена".localize(), style: .cancel, handler: { _ in
            
        }))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func buttonPicker(_ sender: UIButton) {
        let tag = sender.tag
        picker = UIPickerView.init()
        self.pickerData = model.pickersData[tag]
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.layer.borderWidth = 1
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.translatesAutoresizingMaskIntoConstraints = false
        buttonsActive[tag] = true
        self.view.addSubview(picker)
        picker.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        picker.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        picker.heightAnchor.constraint(equalToConstant: size.scaleHeight(350)).isActive = true
        
        enableButtons(bool: false)
        
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)

        if !picker.frame.contains(location) {
            enableButtons(bool: true)
            buttonsActive = buttonsActive.map { _ in false }
            picker.removeFromSuperview()
        }
    }
    
    @objc func buttonDelete() {
        
        var type1 = 0
        var type2 = 0
        var type3 = Int((self.mainView.buttonQuality.titleLabel?.text!)!)!
        var type4 = Int((self.mainView.buttonBorder.titleLabel?.text!)!)!
        var type5 = 0
        switch self.mainView.buttonAlgorithm.titleLabel?.text! {
        case "Face Align + Yolov5l-Face (многоугольники, точно)".localize():
            type1 = 0
        case "Yolov5l-Face (прямоугольники, точно)".localize():
            type1 = 1
        case "Face Align + SFD (многоугольники, точно)".localize():
            type1 = 2
        case "MTCNN (прямоугольники)".localize():
            type1 = 3
        case "RetinaFace + ResNet50 (прямоугольники, точно)".localize():
            type1 = 4
        case "RetinaFace + MobileNet (прямоугольники, быстро)".localize():
            type1 = 5
        case "DLIB (многоугольники)".localize():
            type1 = 6
        case "DLIB (прямоугольники)".localize():
            type1 = 7
        case "Face Align + BlazeFace (многоугольники, быстро)".localize():
            type1 = 8
        case "Yolov5n-Face (прямоугольники, быстро)".localize():
            type1 = 9
        case "Несколько алгоритмов вместе (прямоугольники, очень точно)".localize():
            type1 = 10
        default:
            type1 = 0
        }
        switch self.mainView.buttonTypeFace.titleLabel?.text! {
        case "Размытие".localize():
            type2 = 0
        case "Черный квадрат".localize():
            type2 = 1
        case "Средний цвет".localize():
            type2 = 2
        default:
            type2 = 0
        }
        switch self.mainView.buttonLogo.titleLabel?.text! {
        case "С надписью".localize():
            type5 = 1
        case "Без надписи".localize():
            type5 = 0
        default:
            type5 = 1
        }
        if let mediaURL = mediaURL {
            modelRequest.uploadVideo(controller: self, videoURL: mediaURL, algorithm: type1, erasionType: type2, videoEncodingQuality: type3, extraPixels: type4, addWatermark: type5) { result in
                switch result {
                case .success(let success):
                    print("start getjob")
                    self.modelRequest.getJob(id: success.id, controller: self) { result in
                        switch result {
                        case .success(let data):
                            DispatchQueue.main.async {
                                let vc = ResultScreenController(type1: self.mainView.buttonAlgorithm.titleLabel?.text ?? "none", type2: self.mainView.buttonTypeFace.titleLabel?.text ?? "none", type3: self.mainView.buttonQuality.titleLabel?.text ?? "none", type4: self.mainView.buttonBorder.titleLabel?.text ?? "none", type5: self.mainView.buttonLogo.titleLabel?.text ?? "none")
                                let fileManager = FileManager.default
                                let temporaryDirectory = fileManager.temporaryDirectory
                                let videoName = "video.mp4" // Название вашего видео файла
                                let videoURL = temporaryDirectory.appendingPathComponent(videoName)
                                do {
                                    try data.write(to: videoURL)
                                    vc.mediaURL = videoURL
                                } catch {
                                    print("Ошибка при сохранении видео: \(error.localizedDescription)")
                                }
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        case .failure(let failure):
                            break
                        }
                    }

                case .failure(let failure):
                    break
                }
            }
        }
        if let image = self.mainView.imageView.image?.pngData() {
            modelRequest.uploadImage(controller: self, image: self.mainView.imageView.image!, algorithm: type1, erasionType: type2, videoEncodingQuality: type3, extraPixels: type4, addWatermark: type5) { result in
                switch result {
                case .success(let success):
                    print("start getjob")
                    self.modelRequest.getJob(id: success.id, controller: self) { resultGet in
                        switch resultGet {
                        case .success(let data):
                            DispatchQueue.main.async {
                                let vc = ResultScreenController(type1: self.mainView.buttonAlgorithm.titleLabel?.text ?? "none", type2: self.mainView.buttonTypeFace.titleLabel?.text ?? "none", type3: self.mainView.buttonQuality.titleLabel?.text ?? "none", type4: self.mainView.buttonBorder.titleLabel?.text ?? "none", type5: self.mainView.buttonLogo.titleLabel?.text ?? "none")
//                                vc.dataImage = self.mainView.imageView.image?.jpegData(compressionQuality: 1.0) ?? UIImage(named: "imageTest")?.pngData()
                                vc.dataImage = data
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        case .failure(let failure):
                            print("error", failure)
                        }
                    }

                case .failure(let failure):
                    break
                }
            }
            let today = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-dd-MM"
            let formattedDate = dateFormatter.string(from: today)
        }

    }
    
    private func buttonsTarget() {
        mainView.buttonAddFile.addTarget(self, action: #selector(addFileButtonTapped), for: .touchUpInside)
        mainView.buttonCheckInfo.addTarget(self, action: #selector(presentVCAsBottomSheet), for: .touchUpInside)
        mainView.buttonDeleteFace.addTarget(self, action: #selector(buttonDelete), for: .touchUpInside)
        mainView.buttonAlgorithm.addTarget(self, action: #selector(buttonPicker), for: .touchUpInside)
        mainView.buttonAlgorithm.tag = 0
        mainView.buttonTypeFace.addTarget(self, action: #selector(buttonPicker), for: .touchUpInside)
        mainView.buttonTypeFace.tag = 1
        mainView.buttonQuality.addTarget(self, action: #selector(buttonPicker), for: .touchUpInside)
        mainView.buttonQuality.tag = 2
        mainView.buttonBorder.addTarget(self, action: #selector(buttonPicker), for: .touchUpInside)
        mainView.buttonBorder.tag = 3
        mainView.buttonLogo.addTarget(self, action: #selector(buttonPicker), for: .touchUpInside)
        mainView.buttonLogo.tag = 4
    }
}
