//
//  RealmPost.swift
//  JobReqsAggregator
//
//  Created by Aleksandr Parshakov on 2/10/20.
//  Copyright © 2020 Alexander Parshakov. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmPost: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var position: RealmPostPosition?
    @objc dynamic var supportNumber: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var timePosted: String = ""
    @objc dynamic var isFavorite: Bool = false
    @objc dynamic var isReadLater: Bool = false
    
    convenience init(post: Post) {
        self.init()
        
        self.id = post.id
        self.position = RealmPostPosition(position: post.position)
        self.supportNumber = post.supportNumber
        self.title = post.title
        self.content = post.content
        self.timePosted = post.timePosted
        self.isFavorite = post.isFavorite
        self.isReadLater = post.isReadLater
    }
}
