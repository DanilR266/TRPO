//
//  TabBarController.swift
//  Hide-Face
//
//  Created by Данила on 09.12.2023.
//

import UIKit
class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var navigationController3 = UINavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: "SignIn") {
            self.navigationController3 = UINavigationController(rootViewController: ProfileScreenController())
        } else {
            self.navigationController3 = UINavigationController(rootViewController: LoginScreenController())
        }
        self.delegate = self
        self.tabBar.backgroundColor = .tabBarColor
        self.tabBar.layer.borderWidth = 0.5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let navigationController = UINavigationController(rootViewController: MainScreenController())
        let tabOne = navigationController
        let tabOneBarItem = UITabBarItem(title: "Главная".localize(), image: nil, tag: 0)
        tabOne.tabBarItem = tabOneBarItem
        
//        let navigationController2 = UINavigationController(rootViewController: InfoScreenController())
//        let tabTwo = navigationController2
//        let tabTwoBarItem = UITabBarItem(title: "Информация", image: nil, tag: 1)
//        tabTwo.tabBarItem = tabTwoBarItem
    
        let tabThree = self.navigationController3
        let tabThreeBarItem = UITabBarItem(title: "Профиль".localize(), image: nil, tag: 1)
        tabThree.tabBarItem = tabThreeBarItem
        self.viewControllers = [tabOne, tabThree]
        self.selectedIndex = 0
    }
}
