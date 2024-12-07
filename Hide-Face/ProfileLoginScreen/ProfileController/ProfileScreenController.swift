//
//  ProfileScreenController.swift
//  Hide-Face
//
//  Created by Данила on 04.02.2024.
//

import Foundation
import UIKit
import CoreData

class ProfileScreenController: UIViewController, NSFetchedResultsControllerDelegate {
    var history = [HistoryItem]()
    let profileView = ProfileView()
    let modelGetJob = ModelProfileRequest()
    let requestHistory = ModelRequestHistory()
    let tableView = UITableView()
    let size = Size()
    var userName = "user"
    let supportedLanguages = [("English", "en"), ("Русский", "ru")]
    private var frc: NSFetchedResultsController<CoreDataModel>?
    override func viewDidLoad() {
        navigationItem.title = "Профиль".localize()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        navigationItem.hidesBackButton = true
        super.viewDidLoad()
        
        if let name = UserDefaults.standard.string(forKey: "UserName") {
            if let atIndex = name.firstIndex(of: "@") {
                userName = String(name[..<atIndex])
            } else {
                userName = name
            }
        }
        if let credits = UserDefaults.standard.value(forKey: "Credits") {
            profileView.creditsCount.text = "\((credits as? Int) ?? 0)"
        }
        if !UserDefaults.standard.bool(forKey: "firstLaunch") {
            UserDefaults.standard.setValue(true, forKey: "firstLaunch")
//            history = [History(date: "2023-13-09", data: UIImage(named: "imageTest")!.jpegData(compressionQuality: 1.0)!, type1: "Face Align".localize(), type2: "Размытие".localize(), type3: "16", type4: "2", type5: "С надписью".localize()),
//                       History(date: "2023-12-09", data: UIImage(named: "imageTest")!.jpegData(compressionQuality: 1.0)!, type1: "Face Align".localize(), type2: "Размытие".localize(), type3: "16", type4: "3", type5: "С надписью".localize()),
//                       History(date: "2023-11-09", data: UIImage(named: "imageTest")!.jpegData(compressionQuality: 1.0)!, type1: "Face Align".localize(), type2: "Размытие".localize(), type3: "16", type4: "5", type5: "С надписью".localize())]
//            for item in history {
//                CoreDataManagerMain.shared.createFile(date: item.date, data: item.data, type1: item.type1, type2: item.type2, type3: item.type3, type4: item.type4, type5: item.type5)
//            }
        } else {
            
        }
        buttonTap()
        setupTableView()
        profileView.nameLabel.text = userName
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        setupFRC(with: sortDescriptor)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        requestHistory.getCurrentHistory(controller: self) { result in
//            switch result {
//            case .success(let arrayHistory):
//                DispatchQueue.main.async {
//                    self.history = arrayHistory
//                    self.tableView.reloadData()
//                }
//            case .failure(let failure):
//                print(failure)
//            }
//        }
    }
    
    private func buttonTap() {
        profileView.buttonLogout.addTarget(self, action: #selector(buttonExit), for: .touchUpInside)
        profileView.buttonSettings.addTarget(self, action: #selector(buttonSettings), for: .touchUpInside)
    
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
    
    
    
    @objc func buttonSettings() {
//        changeLanguage()
//        showLanguageChangeAlert(in: self)
//
        let vc = SettingsScreen()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func buttonExit() {
        UserDefaults.standard.setValue(false, forKey: "SignIn")
//        UserDefaults.standard.setValue(nil, forKey: "JWT")
        if let window = UIApplication.shared.windows.first,
           let tabBar = window.rootViewController as? UITabBarController {
            let navMain = UINavigationController(rootViewController: MainScreenController())
            let navLogin = UINavigationController(rootViewController: LoginScreenController())
            navMain.tabBarItem = UITabBarItem(title: "Главная".localize(), image: nil, tag: 0)
            navLogin.tabBarItem = UITabBarItem(title: "Профиль".localize(), image: nil, tag: 1)
            tabBar.viewControllers = [navMain, navLogin]
        }
    }
    
    func setupFRC(with sortDescriptor: NSSortDescriptor) {
        let fetchRequest = CoreDataModel.fetchRequest()
        
        let descriptor = NSSortDescriptor(key: "isoDate", ascending: false)
        
        var predicates = [NSPredicate]()

        
        // Создание составного предиката
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        
        // Установка составного предиката как предиката запроса
        fetchRequest.predicate = compoundPredicate
        
        fetchRequest.sortDescriptors = [descriptor, sortDescriptor]
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: CoreDataManagerMain.shared.context,
                                             sectionNameKeyPath: "isoDate",
                                             cacheName: nil)
        frc.delegate = self
        do {
            try frc.performFetch()
        } catch {
            print("Failed to perform fetch: \(error)")
        }
        
        self.frc = frc
        tableView.reloadData()
    }
    
    private func checkHistoryItem(indexPath: IndexPath) {
        modelGetJob.getJob(id: history[indexPath.row].id, controller: self) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    var type1 = "Face Align + Yolov5l-Face (многоугольники, точно)".localize()
                    var type2 = "Размытие".localize()
                    var type3 = String(self.history[indexPath.row].video_encoding_quality)
                    var type4 = String(self.history[indexPath.row].extra_pixels)
                    var type5 = "С надписью".localize()
                    switch self.history[indexPath.row].algorithm {
                    case 0:
                        type1 = "Face Align + Yolov5l-Face (многоугольники, точно)".localize()
                    case 1:
                        type1 = "Yolov5l-Face (прямоугольники, точно)".localize()
                    case 2:
                        type1 = "Face Align + SFD (многоугольники, точно)".localize()
                    case 3:
                        type1 = "MTCNN (прямоугольники)".localize()
                    case 4:
                        type1 = "RetinaFace + ResNet50 (прямоугольники, точно)".localize()
                    case 5:
                        type1 = "RetinaFace + MobileNet (прямоугольники, быстро)".localize()
                    case 6:
                        type1 = "DLIB (многоугольники)".localize()
                    case 7:
                        type1 = "DLIB (прямоугольники)".localize()
                    case 8:
                        type1 = "Face Align + BlazeFace (многоугольники, быстро)".localize()
                    case 9:
                        type1 = "Yolov5n-Face (прямоугольники, быстро)".localize()
                    case 10:
                        type1 = "Несколько алгоритмов вместе (прямоугольники, очень точно)".localize()
                    default:
                        type1 = "Face Align + Yolov5l-Face (многоугольники, точно)".localize()
                        
                    }
                    
                    switch self.history[indexPath.row].erasion_type {
                    case 0:
                        type2 = "Размытие".localize()
                    case 1:
                        type2 = "Черный квадрат".localize()
                    case 2:
                        type2 = "Средний цвет".localize()
                    default:
                        type2 = "Размытие".localize()
                    }
                    
                    switch self.history[indexPath.row].add_watermark {
                    case 0:
                        type5 = "Без надписи".localize()
                    case 1:
                        type5 = "С надписью".localize()
                    default:
                        type5 = "С надписью".localize()
                    }
                    
                    //        history.append(History(date: "2023-12-09", data: UIImage(named: "imageTest")!.jpegData(compressionQuality: 1.0)!, type1: "Face Align", type2: "Размытие", type3: "16", type4: "2", type5: "С надписью"))
                    let vc = ResultScreenController(type1: type1, type2: type2, type3: type3, type4: type4, type5: type5)
                    vc.dataFromHistory = data
                    self.navigationController?.pushViewController(vc, animated: true)
                    //        tableView.reloadData()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func showAlertForDelete(indexPath: IndexPath) {
        let alertController = UIAlertController(title: nil, message: "Вы уверены, что хотите удалить этот запрос?".localize(), preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Отмена".localize(), style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "Удалить".localize(), style: .destructive) { [weak self] _ in
//            self?.history.remove(at: indexPath.row)
            self!.requestHistory.deleteHistoryItem(id: self!.history[indexPath.row].id, controller: self!) { result in
                switch result {
                case .success(let arrayHistory):
                    DispatchQueue.main.async {
                        self!.history = arrayHistory
                        self!.tableView.reloadData()
                    }
                case .failure(let failure):
                    print(failure)
                }
            }
        }
        alertController.addAction(deleteAction)
        
        present(alertController, animated: true, completion: nil)
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
    
    private func setupTableView() {
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = size.scaleHeight(53)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        profileView.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: profileView.textHistory.bottomAnchor, constant: size.scaleHeight(21)),
            tableView.centerXAnchor.constraint(equalTo: profileView.centerXAnchor),
            tableView.widthAnchor.constraint(equalToConstant: size.screenWidth()),
            tableView.bottomAnchor.constraint(equalTo: profileView.bottomAnchor)
        ])
    }
    
    override func loadView() {
        self.view = profileView
    }
}

extension ProfileScreenController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        cell.mainText.text = "\(history[indexPath.row].datetime)"
        cell.buttonTapCallback = {
            self.showAlertForDelete(indexPath: indexPath)
        }
        cell.buttonVisibilityTapCallback = {
            self.checkHistoryItem(indexPath: indexPath)
        }
        return cell
    }
    
    
}
