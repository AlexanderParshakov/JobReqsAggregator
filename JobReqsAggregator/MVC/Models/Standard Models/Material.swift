//
//  Material.swift
//  JobReqsAggregator
//
//  Created by Alexander Parshakov on 12/12/19.
//  Copyright © 2019 Alexander Parshakov. All rights reserved.
//

import Foundation

final class Material {
    var id: Int = 0
    var name: String = ""
    var url: String = ""
    var positions: [Position]?
    
    init() {
        
    }
    
    init(id: Int, name: String, url: String, positions: [Position]?) {
        self.id = id
        self.name = name
        self.url = url
        self.positions = positions
    }
    
    convenience init(realmMaterial: RealmPostMaterial) {
        self.init()
        
        self.id = realmMaterial.id
        self.name = realmMaterial.name
        self.url = realmMaterial.url
    }
}
