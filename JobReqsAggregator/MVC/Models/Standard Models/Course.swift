//
//  Course.swift
//  JobReqsAggregator
//
//  Created by Alexander Parshakov on 12/12/19.
//  Copyright © 2019 Alexander Parshakov. All rights reserved.
//

import Foundation

struct Course {
    var id: Int
    var name: String
    var url: URL
    var duration: Int
    var positions: [Position]
}
