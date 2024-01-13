//
//  BuyerInfoBlock.swift
//  Hotel
//
//  Created by ily.pavlov on 13.01.2024.
//

import UIKit

final class BuyerInfoBlock: UIView {
    private let constants = Constants()
    private let textFieldHieght: CGFloat = 52
    
    private let buyerInfoLabel = UILabel()
    private let phoneField = CommonTextField(placeholder: "+7 (***) ***-**-**", keyboardType: .numberPad, fieldType: .phoneNumber)
    private let emailField = CommonTextField(placeholder: "yourmail@email.com", keyboardType: .emailAddress, fieldType: .email)
    private let disclaimerLabel = UILabel()
    private var textFields: [UITextField] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("\nBuyerInfoBlock init")
        setupBuyerInfoBlockUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        print("layoutSubviews BuyerInfoBlock")
        super.layoutSubviews()
        setupBuyerInfoBlockLayout()
    }
    
    func validateBuyerInfo() -> Bool {
        
        if textFields.contains(where: { $0.text?.isEmpty ?? true }) {
            textFields.forEach { $0.backgroundColor = UIColor(red: 1, green: 0.8471, blue: 0.8471, alpha: 1.0) }
        } else {
            textFields.forEach { $0.backgroundColor = UIColor(red: 0.9647, green: 0.9647, blue: 0.9765, alpha: 1.0) }
        }
        
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

extension BuyerInfoBlock {
    private func setupBuyerInfoBlockUI() {
        // MARK: - Настройка buyerInfoLabel
        buyerInfoLabel.text = "Информация о покупателе"
        buyerInfoLabel.font = UIFont(name: constants.MediumFont, size: 22)
        
        addSubview(buyerInfoLabel)
        
        // MARK: - Настройка phoneField и emailField
        addSubview(phoneField)
        addSubview(emailField)
        
        textFields = [emailField, phoneField]

        
        // MARK: - Настройка disclaimerLabel
        disclaimerLabel.textColor = constants.lightGreyTextColor
        disclaimerLabel.font = UIFont(name: constants.RegularFont, size: 14)
        disclaimerLabel.numberOfLines = 0
        disclaimerLabel.lineBreakMode = .byWordWrapping
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        disclaimerLabel.attributedText = NSMutableAttributedString(
            string: "Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту",
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        )
        addSubview(disclaimerLabel)
    }
    
    private func setupBuyerInfoBlockLayout() {
        print(#function)
        
        let buyerInfoLabelSize = buyerInfoLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        buyerInfoLabel.frame = CGRect(x: constants.leftPadding, y: constants.leftPadding, width: buyerInfoLabelSize.width, height: buyerInfoLabelSize.height)
        phoneField.frame = CGRect(x: constants.leftPadding, y: buyerInfoLabel.frame.maxY + 20, width: self.frame.width - 32, height: textFieldHieght)
        emailField.frame = CGRect(x: constants.leftPadding, y: phoneField.frame.maxY + constants.commonPadding, width: self.frame.width - 32, height: textFieldHieght)
        disclaimerLabel.frame = CGRect(x: constants.leftPadding, y: emailField.frame.maxY + constants.commonPadding, width: constants.commonWidth, height: 34)
        
        let totalHeight = buyerInfoLabel.frame.height + phoneField.frame.height + emailField.frame.height + disclaimerLabel.frame.height + (constants.leftPadding * 4)
        self.frame.size.height = totalHeight
    }
}
