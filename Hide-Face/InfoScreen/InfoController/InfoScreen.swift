//
//  InfoScreen.swift
//  Hide-Face
//
//  Created by Данила on 09.12.2023.
//

import UIKit

class InfoScreenController: UIViewController {

    let infoView = InfoView()
    let size = Size()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Информация".localize()
    }
    
    override func loadView() {
        super.loadView()
        self.view = infoView
    }
}
