//
//  Job.swift
//  JobReqsAggregator
//
//  Created by Alexander Parshakov on 12/11/19.
//  Copyright © 2019 Alexander Parshakov. All rights reserved.
//

import Foundation

struct Position {
    var id: Int
    var title: String
    var description: String
    var avgSalary: Int
    var openVacancies: Int
    var skillsRequired: [Skill]?
    var relatedCourses: [Course]?
    var relatedMaterials: [Material]?
}
