//
//  ResultInfoScreen.swift
//  Hide-Face
//
//  Created by Данила on 18.04.2024.
//

import Foundation
import UIKit


class ResultInfoScreen: UIViewController {
    let size = Size()
    var type1 = String()
    var type2 = String()
    var type3 = String()
    var type4 = String()
    var type5 = String()
    
    let view1 = ResultInfoView(frame: CGRect(), title: "Используемый алгоритм".localize())
    let view2 = ResultInfoView(frame: CGRect(), title: "Тип удаления лица".localize())
    let view3 = ResultInfoView(frame: CGRect(), title: "Качество кодирования (видео)".localize())
    let view4 = ResultInfoView(frame: CGRect(), title: "Доп. ободок (в пикселях)".localize())
    let view5 = ResultInfoView(frame: CGRect(), title: "Надпись Hide-Face".localize())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTypeView()
        setupView()
        view.backgroundColor = .white
    }
    
    private func setTypeView() {
        view1.mainType.text = type1
        view2.mainType.text = type2
        view3.mainType.text = type3
        view4.mainType.text = type4
        view5.mainType.text = type5
    }
    
    private func setupView() {
        view.addSubview(view1)
        view.addSubview(view2)
        view.addSubview(view3)
        view.addSubview(view4)
        view.addSubview(view5)
        NSLayoutConstraint.activate([
            view1.topAnchor.constraint(equalTo: view.topAnchor, constant: size.scaleHeight(100)),
            view1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view1.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view1.heightAnchor.constraint(equalToConstant: size.scaleHeight(110)),
            
            view2.topAnchor.constraint(equalTo: view1.bottomAnchor, constant: size.scaleHeight(18)),
            view2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view2.heightAnchor.constraint(equalToConstant: size.scaleHeight(100)),
            
            view3.topAnchor.constraint(equalTo: view2.bottomAnchor, constant: size.scaleHeight(18)),
            view3.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view3.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view3.heightAnchor.constraint(equalToConstant: size.scaleHeight(100)),
            
            view4.topAnchor.constraint(equalTo: view3.bottomAnchor, constant: size.scaleHeight(18)),
            view4.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view4.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view4.heightAnchor.constraint(equalToConstant: size.scaleHeight(100)),
            
            view5.topAnchor.constraint(equalTo: view4.bottomAnchor, constant: size.scaleHeight(18)),
            view5.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view5.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view5.heightAnchor.constraint(equalToConstant: size.scaleHeight(100)),
        ])
        view.layoutIfNeeded()
    }
}
