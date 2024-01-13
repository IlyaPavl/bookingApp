//
//  TouristInfoBlock.swift
//  Hotel
//
//  Created by ily.pavlov on 13.01.2024.
//

import UIKit

protocol TouristInfoBlockProtocol: AnyObject {
    func collapseButtonWasTapped(isCollapsed: Bool)
}

final class TouristInfoBlock: UIView {
    let constants = Constants()
    
    private let firstTouristLabel = UILabel()
    private let nameTouristField = CommonTextField(placeholder: "Имя", keyboardType: .default, fieldType: .commonText)
    private let surnameTouristField = CommonTextField(placeholder: "Фамилия", keyboardType: .default, fieldType: .commonText)
    private let dateOfBirthField = CommonTextField(placeholder: "Дата рождения", keyboardType: .default, fieldType: .dateOfBirth)
    private let countryField = CommonTextField(placeholder: "Гражданство", keyboardType: .default, fieldType: .commonText)
    private let passportNumberField = CommonTextField(placeholder: "Номер загранпаспорта", keyboardType: .numberPad, fieldType: .numbers)
    private let passportDateField = CommonTextField(placeholder: "Срок действия загранпаспорта", keyboardType: .default, fieldType: .dateOfBirth)
    private let hideShowButton = UIButton()
    private var isDataInfoCollapsed = false
    private var textFields: [UITextField] = []
    
    weak var delegate: TouristInfoBlockProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("\nTouristInfoBlock init")
        setupTouristInfoBlockUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        print("layoutSubviews TouristInfoBlock")
        super.layoutSubviews()
        setupTouristInfoBlockLayout()
    }
    
    func validateTouristInfo() -> Bool {
        for textField in textFields {
            guard let text = textField.text, !text.isEmpty else {
                print("Error: Please fill in all required fields.")
                return false
            }
        }
        return true
    }
}

// MARK: - TravelInfoBlock setup UI and layout

extension TouristInfoBlock {
    private func setupTouristInfoBlockUI() {
        // MARK: - Настройка firstTouristLabel
        firstTouristLabel.text = "Первый турист"
        firstTouristLabel.font = UIFont(name: constants.MediumFont, size: 22)
        addSubview(firstTouristLabel)
        addSubview(nameTouristField)
        addSubview(surnameTouristField)
        addSubview(dateOfBirthField)
        addSubview(countryField)
        addSubview(passportNumberField)
        addSubview(passportDateField)
        textFields = [nameTouristField, surnameTouristField, dateOfBirthField, countryField, passportNumberField, passportDateField]

        
        hideShowButton.backgroundColor = UIColor(red: 0.051, green: 0.447, blue: 1, alpha: 0.1)
        hideShowButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        hideShowButton.layer.cornerRadius = 6
        hideShowButton.addTarget(self, action: #selector(toggleDataInfo), for: .touchUpInside)
        addSubview(hideShowButton)
        
    }
    
    @objc private func toggleDataInfo() {
        isDataInfoCollapsed.toggle()
        updateDataInfoLayout()
        delegate?.collapseButtonWasTapped(isCollapsed: isDataInfoCollapsed)
    }
    private func updateDataInfoLayout() {
        UIView.animate(withDuration: 0.2) {
            self.textFields.forEach {
                $0.alpha = self.isDataInfoCollapsed ? 0.0 : 1.0
            }
            self.setupTouristInfoBlockLayout()
        }
    }

    private func setupTouristInfoBlockLayout() {
        print(#function)
        
        let firstTouristLabelSize = firstTouristLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        firstTouristLabel.frame = CGRect(x: constants.leftPadding, y: constants.leftPadding, width: firstTouristLabelSize.width, height: firstTouristLabelSize.height)
        nameTouristField.frame = CGRect(x: 16, y: firstTouristLabel.frame.maxY + 20, width: self.frame.width - 32, height: 52)
        surnameTouristField.frame = CGRect(x: 16, y: nameTouristField.frame.maxY + constants.commonPadding, width: self.frame.width - 32, height: 52)
        dateOfBirthField.frame = CGRect(x: 16, y: surnameTouristField.frame.maxY + constants.commonPadding, width: self.frame.width - 32, height: 52)
        countryField.frame = CGRect(x: 16, y: dateOfBirthField.frame.maxY + constants.commonPadding, width: self.frame.width - 32, height: 52)
        passportNumberField.frame = CGRect(x: 16, y: countryField.frame.maxY + constants.commonPadding, width: self.frame.width - 32, height: 52)
        passportDateField.frame = CGRect(x: 16, y: passportNumberField.frame.maxY + constants.commonPadding, width: self.frame.width - 32, height: 52)
        hideShowButton.frame = CGRect(x: self.frame.width - 48, y: 13, width: 32, height: 32)
        hideShowButton.setImage(isDataInfoCollapsed ? UIImage(systemName: "chevron.down") : UIImage(systemName: "chevron.up"), for: .normal)

        let totalHeight = firstTouristLabel.frame.height + nameTouristField.frame.height + surnameTouristField.frame.height + dateOfBirthField.frame.height + countryField.frame.height + passportNumberField.frame.height + passportDateField.frame.height + (constants.leftPadding * 6)
        self.frame.size.height = isDataInfoCollapsed ? firstTouristLabelSize.height + 32 : totalHeight
        
    }
}
