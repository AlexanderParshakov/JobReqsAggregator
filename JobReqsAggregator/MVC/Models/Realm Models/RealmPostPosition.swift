//
//  RealmPosition.swift
//  JobReqsAggregator
//
//  Created by Aleksandr Parshakov on 2/10/20.
//  Copyright © 2020 Alexander Parshakov. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmPostPosition: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var positionDescription: String = ""
    @objc dynamic var avgSalary: Int = 0
    @objc dynamic var openVacancies: Int = 0
    var relatedMaterials: List<RealmPostMaterial> = List()
    
    convenience init(position: Position) {
        self.init()
        
        self.id = position.id
        self.title = position.title
        self.positionDescription = position.description
        self.avgSalary = position.avgSalary
        self.openVacancies = position.openVacancies
        
        position.relatedMaterials.forEach({ (material) in
            self.relatedMaterials.append(RealmPostMaterial(material: material))
        })
    }
}
