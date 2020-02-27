//
//  Repository.swift
//  JobReqsAggregator
//
//  Created by Aleksandr Parshakov on 2/11/20.
//  Copyright © 2020 Alexander Parshakov. All rights reserved.
//

import Foundation

struct Repository {
    private init() {}
    
    struct Posts {
        private init() {}
        
        static func getAll() -> [Post] {
            let cachedPosts = RealmService.Posts.retrieve()
            guard cachedPosts.count == 0 else { return cachedPosts }
            
            let fetchedData = MockDataService.fetchPosts()
            RealmService.Posts.persist(fromArray: fetchedData)
            return fetchedData
        }
        
        static func getFavorites() -> [Post] {
            return RealmService.Posts.retrieveFavorites()
        }
        static func getReadLater() -> [Post] {
            return RealmService.Posts.retrieveReadLater()
        }
    }
}
