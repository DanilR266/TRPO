//
//  ResultInfoView.swift
//  Hide-Face
//
//  Created by Данила on 18.04.2024.
//

import Foundation
import UIKit


class ResultInfoView: UIView {
    
    let title: String
    let size = Size()
    lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var mainType: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var grayLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 217/255)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: size.screenWidth()).isActive = true
        view.heightAnchor.constraint(equalToConstant: size.scaleHeight(2)).isActive = true
        return view
    }()
    
    private func setupUIInfoResult() {
        addSubview(mainTitle)
        addSubview(mainType)
        addSubview(grayLine)
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            mainTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: size.scaleWidth(24)),
            mainTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -size.scaleWidth(24)),
            
            mainType.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: size.scaleHeight(15)),
            mainType.leadingAnchor.constraint(equalTo: leadingAnchor, constant: size.scaleWidth(24)),
            mainType.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -size.scaleWidth(24)),
            
            grayLine.centerXAnchor.constraint(equalTo: centerXAnchor),
            grayLine.topAnchor.constraint(equalTo: mainType.bottomAnchor, constant: size.scaleHeight(18))
        ])
    }
    
    init(frame: CGRect, title: String) {
        self.title = title
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupUIInfoResult()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
