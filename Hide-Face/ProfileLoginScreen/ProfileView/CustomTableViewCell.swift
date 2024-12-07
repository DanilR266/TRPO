//
//  CustomTableViewCell.swift
//  Hide-Face
//
//  Created by Данила on 17.04.2024.
//

import Foundation
import UIKit


class CustomTableViewCell: UITableViewCell {
    let size = Size()
    var buttonTapCallback: () -> ()  = { }
    @objc func didTapButton() {
        buttonTapCallback()
    }
    var buttonVisibilityTapCallback: () -> ()  = { }
    @objc func didVisibilityTapButton() {
        buttonVisibilityTapCallback()
    }
    lazy var viewCell: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: size.scaleHeight(35)).isActive = true
        return view
    }()
    
    lazy var mainText: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "delete"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.widthAnchor.constraint(equalToConstant: size.scaleWidth(24)).isActive = true
        button.imageView?.heightAnchor.constraint(equalToConstant: size.scaleHeight(24)).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: size.scaleWidth(24)).isActive = true
        button.heightAnchor.constraint(equalToConstant: size.scaleHeight(24)).isActive = true
        return button
    }()
    
    lazy var visibilityButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "visibility"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.widthAnchor.constraint(equalToConstant: size.scaleWidth(24)).isActive = true
        button.imageView?.heightAnchor.constraint(equalToConstant: size.scaleHeight(24)).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: size.scaleWidth(24)).isActive = true
        button.heightAnchor.constraint(equalToConstant: size.scaleHeight(24)).isActive = true
        return button
    }()
    
    private func setupViewCell() {
        deleteButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        visibilityButton.addTarget(self, action: #selector(didVisibilityTapButton), for: .touchUpInside)
        addSubview(viewCell)
        viewCell.addSubview(mainText)
        contentView.addSubview(deleteButton)
        contentView.addSubview(visibilityButton)
        NSLayoutConstraint.activate([
            viewCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: size.scaleWidth(24)),
            viewCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -size.scaleWidth(24)),
            viewCell.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            visibilityButton.centerYAnchor.constraint(equalTo: viewCell.centerYAnchor),
            visibilityButton.trailingAnchor.constraint(equalTo: viewCell.trailingAnchor, constant: -size.scaleWidth(6)),
            
            deleteButton.centerYAnchor.constraint(equalTo: viewCell.centerYAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: visibilityButton.leadingAnchor, constant: -size.scaleWidth(8)),
            
            mainText.centerYAnchor.constraint(equalTo: viewCell.centerYAnchor),
            mainText.leadingAnchor.constraint(equalTo: viewCell.leadingAnchor, constant: size.scaleWidth(9)),
            mainText.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -size.scaleWidth(5)),
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewCell()
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
