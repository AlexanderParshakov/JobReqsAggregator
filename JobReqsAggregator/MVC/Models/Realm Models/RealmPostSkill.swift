//
//  RealmSkill.swift
//  JobReqsAggregator
//
//  Created by Aleksandr Parshakov on 2/10/20.
//  Copyright © 2020 Alexander Parshakov. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmPostSkill: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    
    convenience init(skill: Skill) {
        self.init()
        
        self.id = skill.id
        self.name = skill.name
    }
}
