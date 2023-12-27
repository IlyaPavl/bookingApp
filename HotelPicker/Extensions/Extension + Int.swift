//
//  Extension + Int.swift
//  HotelPicker
//
//  Created by ily.pavlov on 26.12.2023.
//

import Foundation

extension Int {
    func formattedWithSeparator() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
