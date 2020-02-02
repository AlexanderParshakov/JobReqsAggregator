//
//  HomeViewController.swift
//  JobReqsAggregator
//
//  Created by Alexander Parshakov on 12/12/19.
//  Copyright © 2019 Alexander Parshakov. All rights reserved.
//

import UIKit

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
        
        posts = MockDataService.fetchPosts()
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentPost: Post
        currentPost = posts[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.postCell) as! PostViewCell
        cell.setPost(post: currentPost)
        
        return cell
    }
    func conformToTableProtocols() {
        postsTableView.dataSource = self
        postsTableView.delegate = self
    }
    
}
