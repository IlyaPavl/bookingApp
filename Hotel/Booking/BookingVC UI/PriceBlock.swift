//
//  PriceBlock.swift
//  Hotel
//
//  Created by ily.pavlov on 11.01.2024.
//

import UIKit

final class PriceBlock: UIView {
    let constants = Constants()
    
    private let tourLabel = UILabel()
    private let tourInfo = UILabel()
    private let fuelLabel = UILabel()
    private let fuelInfo = UILabel()
    private let serviceLabel = UILabel()
    private let serviceInfo = UILabel()
    private let toPayLabel = UILabel()
    private let toPayInfo = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("\nPriceBlock init")
        setupPriceBlockUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        print("layoutSubviews PriceBlock")
        super.layoutSubviews()
        setupPriceBlockLayout()
    }
    
    func setPriceDataFor(tour: String, fuel: String, service: String, toPay: String) {
        tourInfo.text = tour
        fuelInfo.text = fuel
        serviceInfo.text = service
        toPayInfo.text = toPay
    }

}

// MARK: - TravelInfoBlock setup UI and layout

extension PriceBlock {
    private func setupPriceBlockUI() {
        // MARK: - Настройка tourLabel
        tourLabel.text = "Тур"
        tourLabel.font = constants.travelBlockInfoFont
        tourLabel.textColor = constants.lightGreyTextColor
        addSubview(tourLabel)
        
        // MARK: - Настройка tourInfo
        tourInfo.numberOfLines = 0
        tourInfo.textAlignment = .right
        tourInfo.font = constants.travelBlockInfoFont
        addSubview(tourInfo)
        
        // MARK: - Настройка fuelLabel
        fuelLabel.text = "Топливный сбор"
        fuelLabel.font = constants.travelBlockInfoFont
        fuelLabel.textColor = constants.lightGreyTextColor
        addSubview(fuelLabel)
        
        // MARK: - Настройка fuelInfo
        fuelInfo.numberOfLines = 0
        fuelInfo.textAlignment = .right
        fuelInfo.font = constants.travelBlockInfoFont
        addSubview(fuelInfo)
        
        // MARK: - Настройка serviceLabel
        serviceLabel.text = "Сервисный сбор"
        serviceLabel.font = constants.travelBlockInfoFont
        serviceLabel.textColor = constants.lightGreyTextColor
        addSubview(serviceLabel)
        
        // MARK: - Настройка serviceInfo
        serviceInfo.numberOfLines = 0
        serviceInfo.textAlignment = .right
        serviceInfo.font = constants.travelBlockInfoFont
        addSubview(serviceInfo)
        
        // MARK: - Настройка toPayLabel
        toPayLabel.text = "К оплате"
        toPayLabel.font = constants.travelBlockInfoFont
        toPayLabel.textColor = constants.lightGreyTextColor
        addSubview(toPayLabel)
        
        // MARK: - Настройка toPayInfo
        toPayInfo.numberOfLines = 0
        toPayInfo.textAlignment = .right
        toPayInfo.textColor = constants.blueTextColor
        toPayInfo.font = UIFont(name: constants.SemiboldFont, size: 16)
        addSubview(toPayInfo)
    }
    
    
    private func setupPriceBlockLayout() {
        print(#function)
        
        let tourLabelSize = tourLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        tourLabel.frame = CGRect(x: constants.leftPadding, y: 16,
                                 width: tourLabelSize.width, height: tourLabelSize.height)
        
        let tourInfoSize = tourInfo.sizeThatFits(CGSize(width: 132, height: CGFloat.greatestFiniteMagnitude))
        tourInfo.frame = CGRect(x: self.frame.minX + constants.paddingForCost, y: constants.commonPadding * 2, width: 132, height: tourInfoSize.height)
        
        let fuelLabelSize = fuelLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        fuelLabel.frame = CGRect(x: constants.leftPadding, y: tourLabel.frame.maxY + constants.commonPadding * 2,
                                 width: fuelLabelSize.width, height: fuelLabelSize.height)
        
        let fuelInfoSize = fuelInfo.sizeThatFits(CGSize(width: 132, height: CGFloat.greatestFiniteMagnitude))
        fuelInfo.frame = CGRect(x: self.frame.minX + constants.paddingForCost, y: tourInfo.frame.maxY + constants.commonPadding * 2,
                                width: 132, height: fuelInfoSize.height)
        
        let serviceLabelSize = serviceLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        serviceLabel.frame = CGRect(x: constants.leftPadding, y: fuelLabel.frame.maxY + constants.commonPadding * 2,
                                    width: serviceLabelSize.width, height: serviceLabelSize.height)
        
        let serviceInfoSize = serviceInfo.sizeThatFits(CGSize(width: 132, height: CGFloat.greatestFiniteMagnitude))
        serviceInfo.frame = CGRect(x: self.frame.minX + constants.paddingForCost, y: fuelInfo.frame.maxY + constants.commonPadding * 2,
                                   width: 132, height: serviceInfoSize.height)
        
        let toPayLabelSize = toPayLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        toPayLabel.frame = CGRect(x: constants.leftPadding, y: serviceLabel.frame.maxY + constants.commonPadding * 2,
                                  width: toPayLabelSize.width, height: toPayLabelSize.height)
        
        let toPayInfoSize = toPayInfo.sizeThatFits(CGSize(width: 132, height: CGFloat.greatestFiniteMagnitude))
        toPayInfo.frame = CGRect(x: self.frame.minX + constants.paddingForCost, y: serviceInfo.frame.maxY + constants.commonPadding * 2,
                                 width: 132, height: toPayInfoSize.height)

        let totalHeight = tourInfo.frame.height + fuelInfo.frame.height + serviceInfo.frame.height + toPayInfo.frame.height + (constants.leftPadding * 5)
        self.frame.size.height = totalHeight
    }
}
