//
//  HomeViewController.swift
//  JobReqsAggregator
//
//  Created by Alexander Parshakov on 12/12/19.
//  Copyright © 2019 Alexander Parshakov. All rights reserved.
//

import UIKit
import Hero

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var postsTableView: UITableView!
    
    
    
    // MARK: - Actions
    
    
    
    // MARK: - Variables
    var posts: [Post] = [Post]()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Skilltree"
        
        conformToTableProtocols()
        
        posts = Repository.Posts.getAll()
        postsTableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Identifiers.showPost {
            if let indexPath = postsTableView.indexPathForSelectedRow {
                let post = (posts[indexPath.row])
                let postVC = segue.destination as! PostViewController
                postVC.post = post
            }
        }
    }
}


// MARK: - UITableView Delegates
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func conformToTableProtocols() {
        postsTableView.dataSource = self
        postsTableView.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentPost: Post
        currentPost = posts[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.postCell) as! PostViewCell
        cell.setPost(post: currentPost)
        setupHeroIDs(cell: cell, currentPost: currentPost)
        
        return cell
    }
}


// MARK: - Hero
extension HomeViewController {
    private func setupHeroIDs(cell: PostViewCell, currentPost: Post) {
        cell.postTitleLabel.hero.id = Constants.HeroIDs.postTitle + String(currentPost.id)
        cell.postContentLabel.hero.id = Constants.HeroIDs.postTitle + String(currentPost.id)
        cell.timePostedLabel.hero.id = Constants.HeroIDs.timedPosted + String(currentPost.id)
        cell.positionNameLabel.hero.id = Constants.HeroIDs.positionName + String(currentPost.id)
        cell.supportNumberLabel.hero.id = Constants.HeroIDs.supportNumber + String(currentPost.id)
        
        cell.addSupportButton.hero.id = Constants.HeroIDs.addSupportButton + String(currentPost.id)
        cell.subtractSupportButton.hero.id = Constants.HeroIDs.subtractSupportButton + String(currentPost.id)
        
        cell.wrappingView.hero.id = Constants.HeroIDs.wrappingView + String(currentPost.id)
    }
}
