//
//  RealmService.swift
//  JobReqsAggregator
//
//  Created by Aleksandr Parshakov on 2/11/20.
//  Copyright © 2020 Alexander Parshakov. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmService {
    
    private static let schemaVersion: UInt64 = 1
    
    private init() {}
    
    static func printPath() {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    static func removeAllObjects(ofType type: Object.Type) {
        let config = Realm.Configuration(
            schemaVersion: schemaVersion,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < schemaVersion) {
                }
            })
        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm()
        try! realm.write {
            realm.delete(realm.objects(type))
        }
    }
    
    struct Posts { } // extended
}

extension RealmService.Posts {
    static func persist(fromArray posts: [Post]) {
        let realmPosts = mutatePosts(posts: posts)
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                try! realm.write {
                    realm.delete(realm.objects(RealmPost.self))
                    realm.delete(realm.objects(RealmPostPosition.self))
                    realm.delete(realm.objects(RealmPostMaterial.self))
                    realm.add(realmPosts)
                }
            }
        }
    }
    static func updatePost(post: Post) {
        let realm = try! Realm()
        let postsById = realm.objects(RealmPost.self).filter("id == %@", post.id) // always one result
        if let updatablePost = postsById.first {
            try! realm.write {
                updatablePost.isFavorite = post.isFavorite
                updatablePost.isReadLater = post.isReadLater
            }
        }
    }
    static func retrieve() -> [Post] {
        let realm = try! Realm()
        let realmPosts = realm.objects(RealmPost.self)
        return mutateRealmPosts(realmPosts: realmPosts).sorted(by: { $0.timePosted > $1.timePosted })
    }
    static func retrieveFavorites() -> [Post] {
        let realm = try! Realm()
        let realmPosts = realm.objects(RealmPost.self).filter("isFavorite == true")
        return mutateRealmPosts(realmPosts: realmPosts).sorted(by: { $0.timePosted > $1.timePosted })
    }
    static func retrieveReadLater() -> [Post] {
        let realm = try! Realm()
        let realmPosts = realm.objects(RealmPost.self).filter("isReadLater == true")
        return mutateRealmPosts(realmPosts: realmPosts).sorted(by: { $0.timePosted > $1.timePosted })
    }
    
    private static func mutatePosts(posts: [Post]) -> [RealmPost] {
        var realmPosts = [RealmPost]()
        posts.forEach { (post) in
            let realmPost = RealmPost(post: post)
            realmPosts.append(realmPost)
        }
        return realmPosts
    }
    private static func mutateRealmPosts(realmPosts: Results<RealmPost>) -> [Post] {
        var posts = [Post]()
        realmPosts.forEach { (realmPost) in
            let post = Post(realmPost: realmPost)
            posts.append(post)
        }
        return posts
    }
}
