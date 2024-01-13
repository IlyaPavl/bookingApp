//
//  Extension + Int.swift
//  Hotel
//
//  Created by ily.pavlov on 09.01.2024.
//

import Foundation

extension Int {
    func formattedWithSeparator() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
