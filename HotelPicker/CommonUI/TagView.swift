//
//  TagView.swift
//  HotelPicker
//
//  Created by ily.pavlov on 22.12.2023.
//

import UIKit

class TagCloudView: UIView {
    let constants = Constants()
    var tags: [String] = [] {
        didSet {
            updateUI()
        }
    }

    private let spacing: CGFloat = 8
    private let tagHeight: CGFloat = 29
    private var currentX: CGFloat = 0
    private var currentY: CGFloat = 0

    func updateUI() {
        subviews.forEach { $0.removeFromSuperview() }

        currentX = 0
        currentY = 0

        for tag in tags {
            let tagLabel = UILabel()
            tagLabel.text = tag
            tagLabel.font = UIFont(name: constants.MediumFont, size: 14)
            tagLabel.backgroundColor = UIColor(red: 0.984, green: 0.984, blue: 0.988, alpha: 1)
            tagLabel.layer.cornerRadius = 5
            tagLabel.clipsToBounds = true
            tagLabel.textColor = UIColor(red: 0.51, green: 0.529, blue: 0.588, alpha: 1)
            tagLabel.textAlignment = .center

            let tagWidth = tagLabel.intrinsicContentSize.width + 16

            if currentX + tagWidth > bounds.width {
                // Move to the next line
                currentX = 0
                currentY += tagHeight + spacing
            }

            let tagFrame = CGRect(x: currentX, y: currentY, width: tagWidth, height: tagHeight)
            tagLabel.frame = tagFrame

            addSubview(tagLabel)

            currentX += tagWidth + spacing
        }

        frame.size.width = bounds.width
        frame.size.height = currentY + tagHeight
    }
}



