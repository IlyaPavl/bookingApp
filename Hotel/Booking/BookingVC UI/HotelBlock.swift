//
//  HotelBlock.swift
//  Hotel
//
//  Created by ily.pavlov on 11.01.2024.
//

import UIKit

final class HotelBlock: UIView {
    let constants = Constants()
    
    private let yellowView = UIView()
    private let ratingValueLabel = UILabel()
    private let starImage = UIImageView(image: UIImage(systemName: "star.fill"))
    private let hotelNameLabel = UILabel()
    private let hotelAddressLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("\nHotelBlock init")
        setupHotelBlockUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        print("layoutSubviews HotelBlock")
        super.layoutSubviews()
        setupHotelBlockLayout()
    }
    
    func setHotelBlockDataFor(ratingValue: String, hotelNameText: String, hotelAddressText: String) {
        ratingValueLabel.text = ratingValue
        hotelNameLabel.text = hotelNameText
        hotelAddressLabel.text = hotelAddressText
    }
}

// MARK: - HotelBlock setup UI and layout

extension HotelBlock {
    private func setupHotelBlockUI() {
        print(#function)
        // MARK: - Настройка ScoreTab
        yellowView.backgroundColor = constants.ratingBgColor
        yellowView.layer.cornerRadius = 5
        addSubview(yellowView)
        
        ratingValueLabel.font = UIFont(name: constants.MediumFont, size: 16)
        ratingValueLabel.textColor = constants.ratingTextColor
        yellowView.addSubview(ratingValueLabel)
        
        starImage.tintColor = constants.starColor
        yellowView.addSubview(starImage)
        
        // MARK: - Настройка hotelNameLabel
        hotelNameLabel.numberOfLines = 0
        hotelNameLabel.font = UIFont(name: constants.MediumFont, size: 22)
        addSubview(hotelNameLabel)
        
        // MARK: - Настройка hotelAddressLabel
        hotelAddressLabel.numberOfLines = 0
        hotelAddressLabel.font = UIFont(name: constants.MediumFont, size: 14)
        hotelAddressLabel.textColor = constants.blueTextColor
        addSubview(hotelAddressLabel)
    }
    
    
    private func setupHotelBlockLayout() {
        print(#function)
        let ratingValueLabelSize = ratingValueLabel.sizeThatFits(CGSize(width: 343, height: CGFloat.greatestFiniteMagnitude))
        yellowView.frame = CGRect(x: constants.leftPadding, y: self.frame.minY + 16, width: 0, height: 29)
        ratingValueLabel.frame = CGRect(x: 30, y: 0, width: ratingValueLabelSize.width, height: ratingValueLabelSize.height)
        starImage.frame = CGRect(x: 10, y: 0, width: 15, height: 15)
        starImage.center = CGPoint(x: 10 + starImage.frame.width / 2, y: yellowView.frame.height / 2)
        yellowView.frame.size.width = ratingValueLabel.frame.width + starImage.frame.width + 20 + 2
        ratingValueLabel.center = CGPoint(x: (yellowView.frame.width + 2 + starImage.frame.width) / 2, y: yellowView.frame.height / 2)
        
        let hotelNameLabelSize = hotelNameLabel.sizeThatFits(CGSize(width: 343, height: CGFloat.greatestFiniteMagnitude))
        hotelNameLabel.frame = CGRect(x: constants.leftPadding, y: yellowView.frame.maxY + 8, width: hotelNameLabelSize.width, height: hotelNameLabelSize.height)
        let hotelAddressLabelSize = hotelAddressLabel.sizeThatFits(CGSize(width: 343, height: CGFloat.greatestFiniteMagnitude))
        hotelAddressLabel.frame = CGRect(x: constants.leftPadding, y: hotelNameLabel.frame.maxY + 8, width: hotelAddressLabelSize.width, height: hotelAddressLabelSize.height)
        
        let totalHeight = yellowView.frame.height + hotelNameLabel.frame.height + hotelAddressLabel.frame.height + (constants.leftPadding * 4)
        self.frame.size.height = totalHeight
    }
}
