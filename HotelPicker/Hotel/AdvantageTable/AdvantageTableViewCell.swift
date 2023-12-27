//
//  AdvantageTableViewCell.swift
//  HotelPicker
//
//  Created by ily.pavlov on 23.12.2023.
//

import UIKit

class AdvantageTableViewCell: UITableViewCell {

    static let identifier = "AdvantageCell"

    private let imageCell = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let chevronImageView = UIImageView()
    
    let constants = Constants()

    func configureCell(imageName: String, title: String) {
        imageCell.image = UIImage(systemName: imageName)
        titleLabel.text = title
        subtitleLabel.text = "Самое необходимое"
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(red: 0.984, green: 0.984, blue: 0.988, alpha: 1)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageCell.frame = CGRect(x: 15, y: 22, width: 24, height: 24)
        titleLabel.frame = CGRect(x: imageCell.frame.maxX + 12, y: 15, width: 123, height: 19)
        let subtitleLabelSize = subtitleLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        subtitleLabel.frame = CGRect(x: imageCell.frame.maxX + 12, y: titleLabel.frame.maxY + 2, width: subtitleLabelSize.width, height: 17)
        chevronImageView.frame = CGRect(x: self.frame.width - 42, y: 22, width: 24, height: 24)
    }

    private func setupUI() {
        // MARK: - Настройка imageCell
        imageCell.contentMode = .scaleAspectFit
        imageCell.tintColor = .label
        self.addSubview(imageCell)
        
        // MARK: - Настройка titleLabel
        titleLabel.textColor = UIColor(red: 0.174, green: 0.189, blue: 0.209, alpha: 1)
        titleLabel.font = UIFont(name: constants.MediumFont, size: 16)
        self.addSubview(titleLabel)
        
        // MARK: - Настройка subtitleLabel
        subtitleLabel.font = UIFont(name: constants.MediumFont, size: 14)
        subtitleLabel.textColor = UIColor(red: 0.511, green: 0.528, blue: 0.588, alpha: 1)
        self.addSubview(subtitleLabel)
        
        // MARK: - Настройка chevronImageView
        chevronImageView.image = UIImage(systemName: "chevron.forward")
        chevronImageView.contentMode = .scaleAspectFit
        chevronImageView.tintColor = .label
        self.addSubview(chevronImageView)
    }

}

