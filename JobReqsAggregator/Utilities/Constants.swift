//
//  Constants.swift
//  JobReqsAggregator
//
//  Created by Alexander Parshakov on 12/12/19.
//  Copyright © 2019 Alexander Parshakov. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    struct Identifiers {
        static let postCell = "PostCell"
        static let postLinkCell = "postLinkTableCell"
        static let showPost = "showPost"
    }
    
    struct Colors {
        private static func hexStringToUIColor (hex: String) -> UIColor {
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
                alpha: CGFloat(1.0)
            )
        }
        
        static let dictForeground = hexStringToUIColor(hex: "#dfe6ed")
        static let dictBackground = hexStringToUIColor(hex: "#4a76a8")
        static let lightBlue = hexStringToUIColor(hex: "#00baff")
        static let deepRed = hexStringToUIColor(hex: "#BB1517")
        static let mildRed = hexStringToUIColor(hex: "#FE4036")
        static let darkGrey = hexStringToUIColor(hex: "#2d3436")
        static let midGrey = hexStringToUIColor(hex: "#eff1f1")
        static let lightGrey = hexStringToUIColor(hex: "#f5f2f2")
        
        struct DarkModeSupport {
            static let inputFontColor = UIColor(named: "InputFontColor")
        }
        
        
        struct GradientSets {
            static let burningOrange = [hexStringToUIColor(hex: "#FF416C").cgColor, hexStringToUIColor(hex: "#FF4B2B").cgColor]
            static let celestial = [hexStringToUIColor(hex: "#C33764").cgColor, hexStringToUIColor(hex: "#1D2671").cgColor]
            static let deepSpace = [hexStringToUIColor(hex: "#000000").cgColor, hexStringToUIColor(hex: "#434343").cgColor]
            static let relaxingRed = [hexStringToUIColor(hex: "DEE4EA").cgColor, hexStringToUIColor(hex: "#F9FCFF").cgColor]
        }
    }
}
