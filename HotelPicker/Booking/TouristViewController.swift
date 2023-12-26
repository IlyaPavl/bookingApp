//
//  TouristViewController.swift
//  HotelPicker
//
//  Created by ily.pavlov on 26.12.2023.
//

import UIKit

class TouristViewController: UIViewController {
    
    private let paddings: CGFloat = 8
    private let whiteBackDataInfo = UIView()
    private let firstTouristLabel = UILabel()
    private let nameTouristField = CommonTextField(placeholder: "Имя", keyboardType: .default, fieldType: .commonText)
    private let surnameTouristField = CommonTextField(placeholder: "Фамилия", keyboardType: .default, fieldType: .commonText)
    private let dateOfBirthField = CommonTextField(placeholder: "Дата рождения (01.01.1970)", keyboardType: .default, fieldType: .dateOfBirth)
    private let countryField = CommonTextField(placeholder: "Гражданство", keyboardType: .default, fieldType: .commonText)
    private let passportNumberField = CommonTextField(placeholder: "Номер загранпаспорта", keyboardType: .default, fieldType: .commonText)
    private let passportDateField = CommonTextField(placeholder: "Срок действия загранпаспорта", keyboardType: .default, fieldType: .dateOfBirth)
    
    private let hideShowButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        whiteBackDataInfo.frame = CGRect(x: 0, y: view.frame.maxY, width: view.frame.width, height: 400)
        firstTouristLabel.frame = CGRect(x: 16, y: 20, width: 343, height: 52)
        nameTouristField.frame = CGRect(x: 16, y: firstTouristLabel.frame.maxY + paddings, width: 343, height: 52)
        surnameTouristField.frame = CGRect(x: 16, y: nameTouristField.frame.maxY + paddings, width: 343, height: 52)
        dateOfBirthField.frame = CGRect(x: 16, y: surnameTouristField.frame.maxY + paddings, width: 343, height: 52)
        countryField.frame = CGRect(x: 16, y: dateOfBirthField.frame.maxY + paddings, width: 343, height: 52)
        passportNumberField.frame = CGRect(x: 16, y: countryField.frame.maxY + paddings, width: 343, height: 52)
        passportDateField.frame = CGRect(x: 16, y: passportNumberField.frame.maxY + paddings, width: 343, height: 52)

        whiteBackDataInfo.frame.size.height = calculatewhiteBackDataInfoHeight()
    }
    
    func calculatewhiteBackDataInfoHeight() -> CGFloat {
        return nameTouristField.frame.height + surnameTouristField.frame.height + dateOfBirthField.frame.height + countryField.frame.height + passportNumberField.frame.height + passportDateField.frame.height + 16 * 7

    }
}

extension TouristViewController {
    private func setupUI() {
        // MARK: - Настройка whiteBackDataInfo
        whiteBackDataInfo.backgroundColor = .white
        whiteBackDataInfo.layer.cornerRadius = 12
        view.addSubview(whiteBackDataInfo)
        
        // MARK: - Настройка firstTouristLabel
        whiteBackDataInfo.addSubview(firstTouristLabel)
        firstTouristLabel.text = "Первый турист"
        
        whiteBackDataInfo.addSubview(nameTouristField)
        whiteBackDataInfo.addSubview(surnameTouristField)
        whiteBackDataInfo.addSubview(dateOfBirthField)
        whiteBackDataInfo.addSubview(countryField)
        whiteBackDataInfo.addSubview(passportNumberField)
        whiteBackDataInfo.addSubview(passportDateField)
    }
}
