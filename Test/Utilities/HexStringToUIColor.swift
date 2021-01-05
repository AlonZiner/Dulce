//
//  HexStringToUIColor.swift
//  Dulce
//
//  Created by Yoni Hodeffi on 05/01/2021.
//  Copyright © 2021 colman. All rights reserved.
//

import Foundation
import UIKit


class HexStringToUIColor {
    
    /**
     * Take HEX string and return UI color
     *
     */
    static func hexStringToUIColor (hex:String, alpha: Float) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
}
