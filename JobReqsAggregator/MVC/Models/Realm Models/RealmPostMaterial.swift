//
//  RealmMaterial.swift
//  JobReqsAggregator
//
//  Created by Aleksandr Parshakov on 2/10/20.
//  Copyright © 2020 Alexander Parshakov. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmPostMaterial: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var url: String = ""
    
    convenience init(material: Material) {
        self.init()
        
        self.id = material.id
        self.name = material.name
        self.url = material.url
    }
}
