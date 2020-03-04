//
//  UIView + Ext.swift
//  JobReqsAggregator
//
//  Created by Aleksandr Parshakov on 3/4/20.
//  Copyright © 2020 Alexander Parshakov. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setupBasicViewWithShadow(cornerRadius: CGFloat = 7) {
        self.layer.cornerRadius = cornerRadius
//        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.3
    }
}
