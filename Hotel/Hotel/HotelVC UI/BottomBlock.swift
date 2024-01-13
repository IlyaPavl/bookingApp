//
//  BottomBlock.swift
//  Hotel
//
//  Created by ily.pavlov on 08.01.2024.
//

import UIKit

class BottomBlock: UIView {
    
    private let aboutHotelLabel = UILabel()
    private let tagCloudView = TagCloudView()
    private let aboutHotelDescriptionLabel = UILabel()
    let advantage = AdvantageTableVC()
    
    let constants = Constants()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBottomUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupBottomLayout()
    }
    
    func setBotoomBlockDataFor(tagCloudViewTags: [String], aboutHotelDescription: String) {
        tagCloudView.tags = tagCloudViewTags
        aboutHotelDescriptionLabel.text = aboutHotelDescription
    }
    
    private func setupBottomUI() {
        print(#function)

        // MARK: - Настройка aboutHotelLabel
        aboutHotelLabel.text = "Об отеле"
        aboutHotelLabel.font = UIFont(name: constants.MediumFont, size: 22)
        addSubview(aboutHotelLabel)
        
        // MARK: - Настройка tagCloudView
        addSubview(tagCloudView)
        
        // MARK: - Настройка aboutHotelDescriptionLabel
        aboutHotelDescriptionLabel.numberOfLines = 0
        aboutHotelDescriptionLabel.font = UIFont(name: constants.RegularFont, size: 16)
        addSubview(aboutHotelDescriptionLabel)
        
        // MARK: - Настройка advantageTable
        advantage.view.layer.cornerRadius = 15
        addSubview(advantage.view)
    }
    
    private func setupBottomLayout() {
        print(#function)

        aboutHotelLabel.frame = CGRect(x: constants.leftPadding, y: 16, width: 275, height: 26)
        
        let tagCloudViewSize = tagCloudView.sizeThatFits(CGSize(width: 295, height: CGFloat.greatestFiniteMagnitude))
        tagCloudView.frame = CGRect(x: constants.leftPadding, y: aboutHotelLabel.frame.maxY + constants.commonPadding * 2,
                                    width: 295, height: tagCloudViewSize.height)
        
        let descriptionLabelSize = aboutHotelDescriptionLabel.sizeThatFits(CGSize(width: constants.commonWidth, height: CGFloat.greatestFiniteMagnitude))
        aboutHotelDescriptionLabel.frame = CGRect(x: constants.leftPadding, y: tagCloudView.frame.maxY + 12,
                                                  width: descriptionLabelSize.width, height: descriptionLabelSize.height)
        
        advantage.view.frame = CGRect(x: constants.leftPadding, y: aboutHotelDescriptionLabel.frame.maxY + 20, width: self.frame.width - 32, height: 190)
        
        let totalHeight = aboutHotelLabel.frame.height + tagCloudView.frame.height + aboutHotelDescriptionLabel.frame.height + advantage.view.frame.height + (constants.leftPadding * 5)
        self.frame.size.height = totalHeight
    }
}
