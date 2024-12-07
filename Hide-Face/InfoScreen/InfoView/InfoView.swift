//
//  InfoView.swift
//  Hide-Face
//
//  Created by Данила on 24.12.2023.
//

import Foundation
import UIKit


class InfoView: UIView {
    
    let size = Size()
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.text = "Информация".localize()
        title.textColor = .black
        title.font = .systemFont(ofSize: 20, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    lazy var textView1 = UILabel().customTextView(text: StringsInfo.text1.rawValue.localize())
    lazy var title1 = UILabel().customTitle(text: StringsInfo.textFaq.rawValue.localize())
    lazy var titlefaq1 = UILabel().customTitle(text: StringsInfo.faq1.rawValue.localize())
    lazy var titleAns1 = UILabel().customTextView(text: StringsInfo.ans1.rawValue.localize())
    lazy var titleEx = UILabel().customTitle(text: StringsInfo.example.rawValue.localize())
    lazy var titlefaq2 = UILabel().customTitle(text: StringsInfo.faq2.rawValue.localize())
    lazy var titleAns2 = UILabel().customTextView(text: StringsInfo.ans2.rawValue.localize())
    lazy var titlefaq3 = UILabel().customTitle(text: StringsInfo.faq3.rawValue.localize())
    lazy var titleAns3 = UILabel().customTextView(text: StringsInfo.ans3.rawValue.localize())
    lazy var titlefaq4 = UILabel().customTitle(text: StringsInfo.faq4.rawValue.localize())
    lazy var titleAns4 = UILabel().customTextView(text: StringsInfo.ans4.rawValue.localize())
    lazy var titlefaq5 = UILabel().customTitle(text: StringsInfo.faq5.rawValue.localize())
    lazy var titleAns5 = UILabel().customTextView(text: StringsInfo.ans5.rawValue.localize())
    
    lazy var img1: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "img1")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: size.scaleWidth(327)).isActive = true
        image.heightAnchor.constraint(equalToConstant: size.scaleHeight(214)).isActive = true
        return image
    }()
    lazy var img1_1: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "img1_1")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: size.scaleWidth(327)).isActive = true
        image.heightAnchor.constraint(equalToConstant: size.scaleHeight(214)).isActive = true
        return image
    }()
    
    lazy var stackImg1: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var img2: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "img2")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: size.scaleWidth(327)).isActive = true
        image.heightAnchor.constraint(equalToConstant: size.scaleHeight(214)).isActive = true
        return image
    }()
    lazy var img2_1: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "img2_1")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: size.scaleWidth(327)).isActive = true
        image.heightAnchor.constraint(equalToConstant: size.scaleHeight(214)).isActive = true
        return image
    }()
    
    lazy var stackImg2: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var img3: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "img3")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: size.scaleWidth(177)).isActive = true
        image.heightAnchor.constraint(equalToConstant: size.scaleHeight(214)).isActive = true
        return image
    }()
    lazy var img3_1: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "img3_1")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: size.scaleWidth(177)).isActive = true
        image.heightAnchor.constraint(equalToConstant: size.scaleHeight(214)).isActive = true
        return image
    }()
    
    lazy var stackImg3: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let scrollView = UIScrollView()
    let scrollViewStack = UIScrollView()
    
    
    private func setUpConstait() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize.height = size.scaleHeight(1900)
        scrollView.contentSize.width = size.screenWidth()
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        stackImg1.addArrangedSubview(img1)
        stackImg1.addArrangedSubview(img1_1)
        stackImg2.addArrangedSubview(img2)
        stackImg2.addArrangedSubview(img2_1)
        stackImg3.addArrangedSubview(img3)
        stackImg3.addArrangedSubview(img3_1)
        scrollViewStack.translatesAutoresizingMaskIntoConstraints = false
        scrollViewStack.contentSize.width = size.scaleWidth(860)
        scrollViewStack.addSubview(stackImg1)
        scrollViewStack.addSubview(stackImg2)
        scrollViewStack.addSubview(stackImg3)
        
        scrollView.addSubview(textView1)
        scrollView.addSubview(title1)
        scrollView.addSubview(titlefaq1)
        scrollView.addSubview(titleAns1)
        scrollView.addSubview(titleEx)
        scrollView.addSubview(scrollViewStack)
        scrollView.addSubview(titlefaq2)
        scrollView.addSubview(titleAns2)
        scrollView.addSubview(titlefaq3)
        scrollView.addSubview(titleAns3)
        scrollView.addSubview(titlefaq4)
        scrollView.addSubview(titleAns4)
        scrollView.addSubview(titlefaq5)
        scrollView.addSubview(titleAns5)
        NSLayoutConstraint.activate([
            
            textView1.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: size.scaleHeight(10)),
            textView1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -size.scaleWidth(24)),
            textView1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: size.scaleWidth(24)),
            textView1.heightAnchor.constraint(equalToConstant: size.scaleHeight(325)),
            
            title1.topAnchor.constraint(equalTo: textView1.bottomAnchor, constant: 30),
            title1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: size.scaleWidth(24)),
            title1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -size.scaleWidth(24)),
            
            titlefaq1.topAnchor.constraint(equalTo: title1.bottomAnchor, constant: 5),
            titlefaq1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: size.scaleWidth(24)),
            titlefaq1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -size.scaleWidth(24)),
            
            titleAns1.topAnchor.constraint(equalTo: titlefaq1.bottomAnchor, constant: size.scaleHeight(5)),
            titleAns1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: size.scaleWidth(24)),
            titleAns1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -size.scaleWidth(24)),
            
            titleEx.topAnchor.constraint(equalTo: titleAns1.bottomAnchor, constant: size.scaleHeight(5)),
            titleEx.leadingAnchor.constraint(equalTo: leadingAnchor, constant: size.scaleWidth(24)),
            titleEx.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -size.scaleWidth(24)),
            
            scrollViewStack.topAnchor.constraint(equalTo: titleEx.bottomAnchor, constant: 5),
            scrollViewStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: size.scaleWidth(24)),
            scrollViewStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -size.scaleWidth(24)),
            scrollViewStack.heightAnchor.constraint(equalToConstant: size.scaleHeight(445)),
            stackImg1.leadingAnchor.constraint(equalTo: scrollViewStack.leadingAnchor),
            stackImg1.centerYAnchor.constraint(equalTo: scrollViewStack.centerYAnchor),
            stackImg2.leadingAnchor.constraint(equalTo: stackImg1.trailingAnchor, constant: 10),
            stackImg2.centerYAnchor.constraint(equalTo: scrollViewStack.centerYAnchor),
            stackImg3.leadingAnchor.constraint(equalTo: stackImg2.trailingAnchor, constant: 10),
            stackImg3.centerYAnchor.constraint(equalTo: scrollViewStack.centerYAnchor),
            
            titlefaq2.topAnchor.constraint(equalTo: scrollViewStack.bottomAnchor, constant: 10),
            titlefaq2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: size.scaleWidth(24)),
            titlefaq2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -size.scaleWidth(24)),
            
            titleAns2.topAnchor.constraint(equalTo: titlefaq2.bottomAnchor, constant: size.scaleHeight(5)),
            titleAns2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: size.scaleWidth(24)),
            titleAns2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -size.scaleWidth(24)),
            
            titlefaq3.topAnchor.constraint(equalTo: titleAns2.bottomAnchor, constant: 5),
            titlefaq3.leadingAnchor.constraint(equalTo: leadingAnchor, constant: size.scaleWidth(24)),
            titlefaq3.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -size.scaleWidth(24)),
            
            titleAns3.topAnchor.constraint(equalTo: titlefaq3.bottomAnchor, constant: size.scaleHeight(5)),
            titleAns3.leadingAnchor.constraint(equalTo: leadingAnchor, constant: size.scaleWidth(24)),
            titleAns3.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -size.scaleWidth(24)),
            
            titlefaq4.topAnchor.constraint(equalTo: titleAns3.bottomAnchor, constant: 5),
            titlefaq4.leadingAnchor.constraint(equalTo: leadingAnchor, constant: size.scaleWidth(24)),
            titlefaq4.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -size.scaleWidth(24)),
            
            titleAns4.topAnchor.constraint(equalTo: titlefaq4.bottomAnchor, constant: size.scaleHeight(5)),
            titleAns4.leadingAnchor.constraint(equalTo: leadingAnchor, constant: size.scaleWidth(24)),
            titleAns4.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -size.scaleWidth(24)),
            
            titlefaq5.topAnchor.constraint(equalTo: titleAns4.bottomAnchor, constant: 5),
            titlefaq5.leadingAnchor.constraint(equalTo: leadingAnchor, constant: size.scaleWidth(24)),
            titlefaq5.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -size.scaleWidth(24)),
            
            titleAns5.topAnchor.constraint(equalTo: titlefaq5.bottomAnchor, constant: size.scaleHeight(5)),
            titleAns5.leadingAnchor.constraint(equalTo: leadingAnchor, constant: size.scaleWidth(24)),
            titleAns5.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -size.scaleWidth(24)),
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUpConstait()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
