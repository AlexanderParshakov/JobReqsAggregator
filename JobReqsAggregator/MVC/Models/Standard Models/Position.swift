//
//  Job.swift
//  JobReqsAggregator
//
//  Created by Alexander Parshakov on 12/11/19.
//  Copyright © 2019 Alexander Parshakov. All rights reserved.
//

import Foundation

final class Position {
    var id: Int = 0
    var title: String = ""
    var description: String = ""
    var avgSalary: Int = 0
    var openVacancies: Int = 0
    var skillsRequired: [Skill]?
    var relatedCourses: [Course]?
    var relatedMaterials: [Material]?
    
    init() {
        
    }
    
    convenience init(id: Int, title: String, description: String, avgSalary: Int, openVacancies: Int, skillsRequired: [Skill]?, relatedCourses: [Course]?, relatedMaterials: [Material]?) {
        self.init()
        self.id = id
        self.title = title
        self.description = description
        self.avgSalary = avgSalary
        self.openVacancies = openVacancies
        self.skillsRequired = skillsRequired
        self.relatedCourses = relatedCourses
        self.relatedMaterials = relatedMaterials
    }
    convenience init(realmPosition: RealmPostPosition) {
        self.init()
        
        self.id = realmPosition.id
        self.title = realmPosition.title
        self.description = realmPosition.positionDescription
        self.avgSalary = realmPosition.avgSalary
        self.openVacancies = realmPosition.openVacancies
        
        realmPosition.relatedMaterials.forEach({ (realmMaterial) in
            self.relatedMaterials?.append(Material(realmMaterial: realmMaterial))
        })
    }
}
