//
//  String + Extension.swift
//  HotelPicker
//
//  Created by ily.pavlov on 26.12.2023.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}\\?").evaluate(with: self)
    }
    
    var containsOnlyLettersAndDigits: Bool {
        let allowedCharacters = CharacterSet.alphanumerics
        return self.rangeOfCharacter(from: allowedCharacters.inverted) == nil
    }
    
    var containsOnlyCustomCharacters: Bool {
        let customCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@!")
        
        return self.rangeOfCharacter(from: customCharacters.inverted) == nil
    }
}

