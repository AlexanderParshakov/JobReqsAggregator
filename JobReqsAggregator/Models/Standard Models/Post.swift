//
//  Post.swift
//  JobReqsAggregator
//
//  Created by Alexander Parshakov on 12/12/19.
//  Copyright © 2019 Alexander Parshakov. All rights reserved.
//

import Foundation

final class Post {
    var id: Int = 0
    var position: Position = Position()
    var supportNumber: Int = 0
    var title: String = ""
    var content: String = ""
    var timePosted: String = ""
    var isFavorite: Bool = false
    var isReadLater: Bool = false
    
    init() {
        
    }
    
    convenience init(id: Int, position: Position, supportNumber: Int, title: String, content: String, timePosted: String, isFavorite: Bool = false, isReadLater: Bool = false) {
        self.init()
        
        self.id = id
        self.position = position
        self.supportNumber = supportNumber
        self.title = title
        self.content = content
        self.timePosted = timePosted
        self.isFavorite = isFavorite
        self.isReadLater = isReadLater
    }
    
    convenience init(realmPost: RealmPost) {
        self.init()
        
        self.id = realmPost.id
        self.position = Position(realmPosition: realmPost.position ?? RealmPostPosition())
        self.supportNumber = realmPost.supportNumber
        self.title = realmPost.title
        self.content = realmPost.content
        self.timePosted = realmPost.timePosted
        self.isFavorite = realmPost.isFavorite
        self.isReadLater = realmPost.isReadLater
    }
}
