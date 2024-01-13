//
//  TravelInfoBlock.swift
//  Hotel
//
//  Created by ily.pavlov on 11.01.2024.
//

import UIKit

final class TravelInfoBlock: UIView {
    let constants = Constants()
    
    private let departureCityLabel = UILabel()
    private let departureCityInfo = UILabel()
    private let arrivalCityLabel = UILabel()
    private let arrivalCityInfo = UILabel()
    private let dateLabel = UILabel()
    private let dateInfo = UILabel()
    private let nightsLabel = UILabel()
    private let nightsInfo = UILabel()
    private let hotelLabel = UILabel()
    private let hotelInfo = UILabel()
    private let roomLabel = UILabel()
    private let roomInfo = UILabel()
    private let foodLabel = UILabel()
    private let foodInfo = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("\nTravelBlock init")
        setupTravelBlockUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        print("layoutSubviews TravelBlock")
        super.layoutSubviews()
        setupTravelBlockLayout()
    }
    
    func setTravelInfo(departureCity: String, arrivalCity: String, date: String, nights: String, hotel: String, room: String, food: String) {
        departureCityInfo.text = departureCity
        arrivalCityInfo.text = arrivalCity
        dateInfo.text = date
        nightsInfo.text = nights
        hotelInfo.text = hotel
        roomInfo.text = room
        foodInfo.text = food
    }

}

// MARK: - TravelInfoBlock setup UI and layout

extension TravelInfoBlock {
    private func setupTravelBlockUI() {
        // MARK: - Настройка departureCityLabel
        departureCityLabel.text = "Вылет из"
        departureCityLabel.font = constants.travelBlockInfoFont
        departureCityLabel.textColor = constants.lightGreyTextColor
        addSubview(departureCityLabel)
        
        // MARK: - Настройка arrivalCityLabel
        arrivalCityLabel.text = "Страна, город"
        arrivalCityLabel.font = constants.travelBlockInfoFont
        arrivalCityLabel.textColor = constants.lightGreyTextColor
        addSubview(arrivalCityLabel)
        
        // MARK: - Настройка dateLabel
        dateLabel.text = "Даты"
        dateLabel.font = constants.travelBlockInfoFont
        dateLabel.textColor = constants.lightGreyTextColor
        addSubview(dateLabel)
        
        // MARK: - Настройка nightsLabel
        nightsLabel.text = "Кол-во ночей"
        nightsLabel.font = constants.travelBlockInfoFont
        nightsLabel.textColor = constants.lightGreyTextColor
        addSubview(nightsLabel)
        
        // MARK: - Настройка hotelLabel
        hotelLabel.text = "Отель"
        hotelLabel.font = constants.travelBlockInfoFont
        hotelLabel.textColor = constants.lightGreyTextColor
        addSubview(hotelLabel)
        
        // MARK: - Настройка roomLabel
        roomLabel.text = "Номер"
        roomLabel.font = constants.travelBlockInfoFont
        roomLabel.textColor = constants.lightGreyTextColor
        addSubview(roomLabel)
        
        // MARK: - Настройка foodLabel
        foodLabel.text = "Питание"
        foodLabel.font = constants.travelBlockInfoFont
        foodLabel.textColor = constants.lightGreyTextColor
        addSubview(foodLabel)
        
        // MARK: - Настройка departureCityInfo
        departureCityInfo.numberOfLines = 0
        departureCityInfo.font = constants.travelBlockInfoFont
        addSubview(departureCityInfo)
        
        // MARK: - Настройка arrivalCityInfo
        arrivalCityInfo.numberOfLines = 0
        arrivalCityInfo.font = constants.travelBlockInfoFont
        addSubview(arrivalCityInfo)
        
        // MARK: - Настройка dateInfo
        dateInfo.numberOfLines = 0
        dateInfo.font = constants.travelBlockInfoFont
        addSubview(dateInfo)
        
        // MARK: - Настройка nightsInfo
        nightsInfo.numberOfLines = 0
        nightsInfo.font = constants.travelBlockInfoFont
        addSubview(nightsInfo)
        
        // MARK: - Настройка hotelInfo
        hotelInfo.numberOfLines = 0
        hotelInfo.font = constants.travelBlockInfoFont
        addSubview(hotelInfo)
        
        // MARK: - Настройка roomInfo
        roomInfo.numberOfLines = 0
        roomInfo.font = constants.travelBlockInfoFont
        addSubview(roomInfo)
        
        // MARK: - Настройка foodInfo
        foodInfo.numberOfLines = 0
        foodInfo.font = constants.travelBlockInfoFont
        addSubview(foodInfo)
    }
    
    
    private func setupTravelBlockLayout() {
        print(#function)
        
        let departureCityLabelSize = departureCityLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        departureCityLabel.frame = CGRect(x: constants.leftPadding, y: 16, width: departureCityLabelSize.width, height: departureCityLabelSize.height)
        
        departureCityInfo.frame = CGRect(x: self.frame.minX + constants.paddingForOrder, y: 16, width: 203, height: 19)
        
        let arrivalCityLabelSize = arrivalCityLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        arrivalCityLabel.frame = CGRect(x: constants.leftPadding, y: departureCityLabel.frame.maxY + 16, width: arrivalCityLabelSize.width, height: arrivalCityLabelSize.height)
        
        arrivalCityInfo.frame = CGRect(x: self.frame.minX + constants.paddingForOrder, y: departureCityInfo.frame.maxY + 16, width: 203, height: 19)
        
        let dateLabelSize = dateLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        dateLabel.frame = CGRect(x: constants.leftPadding, y: arrivalCityLabel.frame.maxY + 16, width: dateLabelSize.width, height: dateLabelSize.height)
        
        dateInfo.frame = CGRect(x: self.frame.minX + constants.paddingForOrder, y: arrivalCityInfo.frame.maxY + 16, width: 203, height: 19)
        
        let nightsLabelSize = nightsLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        nightsLabel.frame = CGRect(x: constants.leftPadding, y: dateLabel.frame.maxY + 16, width: nightsLabelSize.width, height: nightsLabelSize.height)
        
        nightsInfo.frame = CGRect(x: self.frame.minX + constants.paddingForOrder, y: dateInfo.frame.maxY + 16, width: 203, height: 19)
        
        let hotelLabelSize = hotelLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        hotelLabel.frame = CGRect(x: constants.leftPadding, y: nightsLabel.frame.maxY + 16, width: hotelLabelSize.width, height: hotelLabelSize.height)
        
        hotelInfo.frame = CGRect(x: self.frame.minX + constants.paddingForOrder, y: nightsInfo.frame.maxY + 16, width: 203, height: 40)
        
        let roomLabelSize = roomLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        roomLabel.frame = CGRect(x: constants.leftPadding, y: hotelInfo.frame.maxY + 16, width: roomLabelSize.width, height: roomLabelSize.height)
        
        let roomInfoSize = roomInfo.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        roomInfo.frame = CGRect(x: self.frame.minX + constants.paddingForOrder, y: hotelInfo.frame.maxY + 16, width: 203, height: 40)
        
        let foodLabelSize = foodLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        foodLabel.frame = CGRect(x: constants.leftPadding, y: roomInfo.frame.maxY + 16, width: foodLabelSize.width, height: foodLabelSize.height)
        
        let foodInfoSize = foodInfo.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        foodInfo.frame = CGRect(x: self.frame.minX + constants.paddingForOrder, y: roomInfo.frame.maxY + 16, width: 203, height: foodInfoSize.height)
        
        let totalHeight = departureCityInfo.frame.height + arrivalCityInfo.frame.height + dateInfo.frame.height + nightsInfo.frame.height + hotelInfo.frame.height + roomInfo.frame.height + foodInfo.frame.height + (constants.leftPadding * 8)
        self.frame.size.height = totalHeight
    }
}
