//
//  PickerProtocol.swift
//  Hide-Face
//
//  Created by Данила on 13.01.2024.
//

import Foundation
import UIKit

protocol CustomPickerDelegate: AnyObject {
    func didSelectValue(_ value: String, forPicker pickerView: UIPickerView)
}

class CustomPickerViewController: UIViewController {

    weak var delegate: CustomPickerDelegate?
    var pickerView: UIPickerView!
    var data: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
    }
}

extension CustomPickerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedValue = data[row]
        delegate?.didSelectValue(selectedValue, forPicker: pickerView)
    }
}
