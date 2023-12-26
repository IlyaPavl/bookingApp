//
//  CommonTextField.swift
//  HotelPicker
//
//  Created by ily.pavlov on 26.12.2023.
//

import UIKit


enum CommonTextFieldType {
    case email
    case phoneNumber
    case commonText
    case dateOfBirth
}

class CommonTextField: UITextField {
    
    var fieldType: CommonTextFieldType = .email
    
    private var datePicker: UIDatePicker?
    
    init(placeholder: String, keyboardType: UIKeyboardType, fieldType: CommonTextFieldType) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.fieldType = fieldType
        
        setupTextField()
        
        self.delegate = self
        self.reloadInputViews()
        
        if fieldType == .dateOfBirth {
            setupDatePicker()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextField() {
        self.backgroundColor = UIColor(red: 0.9647, green: 0.9647, blue: 0.9765, alpha: 1.0)
        self.layer.cornerRadius = 10
        self.textColor = UIColor.black
        self.borderStyle = .roundedRect
    }
    
    private func setupDatePicker() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.preferredDatePickerStyle = .wheels
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let doneButton = UIButton(type: .system)
        doneButton.setTitle("Выбрать дату", for: .normal)
        doneButton.addTarget(self, action: #selector(datePickerDoneButtonTapped), for: .touchUpInside)
        let customDoneButton = UIBarButtonItem(customView: doneButton)
        toolbar.setItems([customDoneButton], animated: true)
        
        self.inputAccessoryView = toolbar
        self.inputView = datePicker
    }
    
    @objc private func datePickerDoneButtonTapped() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        self.text = dateFormatter.string(from: datePicker?.date ?? Date())
        self.endEditing(true)
    }
    
    func format(with mask: String, text: String) -> String {
        switch fieldType {
        case .phoneNumber:
            return formatPhoneNumber(with: mask, phone: text)
        case .email:
            return formatEmail(text: text)
        case .commonText, .dateOfBirth:
            return text
        }
    }
    
    private func formatPhoneNumber(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    private func formatEmail(text: String) -> String {
        if text.isValidEmail {
            self.backgroundColor = UIColor(red: 0.9647, green: 0.9647, blue: 0.9765, alpha: 1.0)
            return text
        } else {
            self.backgroundColor = UIColor(red: 1, green: 0.8471, blue: 0.8471, alpha: 1.0)
            return text
        }
    }
    
    private func formatCommonText(text: String) -> String {
        if !text.isEmpty {
            self.backgroundColor = UIColor(red: 0.9647, green: 0.9647, blue: 0.9765, alpha: 1.0)
            return text
        } else {
            self.backgroundColor = UIColor(red: 1, green: 0.8471, blue: 0.8471, alpha: 1.0)
            return text
        }
        
    }

}

extension CommonTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = format(with: "+X (XXX) XXX-XX-XX", text: newString)
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
