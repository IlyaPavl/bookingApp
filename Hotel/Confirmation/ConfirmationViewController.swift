//
//  ConfirmationViewController.swift
//  Hotel
//
//  Created by ily.pavlov on 08.01.2024.
//

import UIKit

final class ConfirmationViewController: UIViewController {
    
    // MARK: - UI elements
    private let roundView = UIView()
    private let emojiLabel = UILabel()
    
    private let confirmLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    private let buttonBackgroundView = UIView()
    private let button = CustomButton(text: "Супер!")
    
    // MARK: - Property
    private let constants = Constants()
    private var orderNumber = Int.random(in: 0...1000000)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }
}

// MARK: - ConfirmationViewController setupUI
extension ConfirmationViewController {
    private func setupUI() {
        view.backgroundColor = .white
        
        // MARK: - Настройка roundView
        roundView.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.976, alpha: 1)
        roundView.layer.cornerRadius = 94 / 2
        view.addSubview(roundView)
        
        // MARK: - Настройка emojiLabel
        emojiLabel.font = UIFont(name: constants.MediumFont, size: 44)
        emojiLabel.text = "🎉"
        roundView.addSubview(emojiLabel)
        
        // MARK: - Настройка descriptionLabel
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = UIColor(red: 0.51, green: 0.529, blue: 0.588, alpha: 1)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.01
        let attributedString = NSMutableAttributedString(string: "Подтверждение заказа №\(orderNumber) может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление.")
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        descriptionLabel.attributedText = attributedString
        descriptionLabel.textAlignment = .center
        view.addSubview(descriptionLabel)
        
        // MARK: - Настройка confirmLabel
        confirmLabel.numberOfLines = 0
        confirmLabel.font = UIFont(name: constants.MediumFont, size: 22)
        confirmLabel.text = "Ваш заказ принят в работу"
        view.addSubview(confirmLabel)
        
        // MARK: - Настройка bottomButton
        buttonBackgroundView.backgroundColor = .white
        view.addSubview(buttonBackgroundView)
        
        button.addAction { [weak self] in
            guard let self = self else { return }
            let hotelVC = HotelViewController()
            self.navigationController?.pushViewController(hotelVC, animated: true)
        }
        buttonBackgroundView.addSubview(button)
    }
}

// MARK: - ConfirmationViewController setupLayout
extension ConfirmationViewController {
    private func setupLayout() {
        
        let roundViewWidth: CGFloat = 94
        let roundViewHeight: CGFloat = 94
        let roundViewX = (view.bounds.width - roundViewWidth) / 2
        let roundViewY = ((view.bounds.height - roundViewHeight) / 2) - 32
        roundView.frame = CGRect(x: roundViewX, y: roundViewY, width: 94, height: 94)
        
        let emojiLabelSize = emojiLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        emojiLabel.frame = CGRect(x: 0, y: 0, width: emojiLabelSize.width, height: emojiLabelSize.height)
        emojiLabel.center = CGPoint(x: roundView.bounds.midX, y: roundView.bounds.midY)
        
        let confirmLabelSize = confirmLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        confirmLabel.frame = CGRect(x: 0, y: roundView.frame.maxY + 32, width: confirmLabelSize.width, height: confirmLabelSize.height)
        confirmLabel.center.x = view.center.x
        
        descriptionLabel.frame = CGRect(x: 0, y: confirmLabel.frame.maxY + 20, width: view.frame.width - 46, height: 120)
        descriptionLabel.center.x = view.center.x
        
        
        buttonBackgroundView.frame = CGRect(x: 0, y: view.frame.maxY - 88, width: view.frame.width, height: 88)
        button.frame = CGRect(x: 0, y: 0, width: 343, height: 48)
        button.center = CGPoint(x: buttonBackgroundView.bounds.midX, y: buttonBackgroundView.bounds.midY - 7)
    }
}
