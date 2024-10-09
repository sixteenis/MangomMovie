//
//  UIColor+.swift
//  MangomMovie
//
//  Created by 박성민 on 10/8/24.
//

import UIKit

extension UIColor {
    static let asBackground = UIColor(hex: "000000")
    static let asFont = UIColor(hex: "FFFFFF")
    static let asDarkBlack = UIColor(hex: "1B1B1E")
    static let asRed = UIColor(hex: "FC2125")
    
    static let asGray = UIColor.gray
    static let asWhite = UIColor(hex: "FFFFFF")
}

extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
