//
//  SecondViewController.swift
//  JobReqsAggregator
//
//  Created by Alexander Parshakov on 12/11/19.
//  Copyright © 2019 Alexander Parshakov. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var switchViewControl: UISegmentedControl!
    @IBOutlet weak var postsTableView: UITableView!
    
    @IBAction func switchViewController(_ sender: UISegmentedControl) {
        if switchViewControl.selectedSegmentIndex == 0 { // Favorites
            posts = Repository.Posts.getFavorites()
            reloadDataWithAnimation()
        }
        else { // read later
            posts = Repository.Posts.getReadLater()
            reloadDataWithAnimation()
        }
    }
    
    
    // MARK: - Variables
    var posts: [Post] = []
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConformance()
        setupGestureRecognizer()
        
        navigationItem.title = "Сохраненные посты"
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .selected)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let lastNumberOfRows = posts.count
        posts = switchViewControl.selectedSegmentIndex == 0 ? Repository.Posts.getFavorites() : Repository.Posts.getReadLater()
        
        guard lastNumberOfRows <= posts.count-1 else { self.postsTableView.reloadData(); return }
        var indexPaths: [IndexPath] = []
        for index in lastNumberOfRows...posts.count - 1 {
            indexPaths.append(IndexPath(item: index, section: 0))
        }
        Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (_) in
            self.postsTableView.insertRows(at: indexPaths, with: .fade)
        }
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
    
    private func setupConformance() {
        postsTableView.delegate = self
        postsTableView.dataSource = self
    }
    
}


// MARK: - Conforming to UITableView Protocols
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
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
    private func reloadDataWithAnimation() {
        let range = NSMakeRange(0, self.postsTableView.numberOfSections)
        let sections = NSIndexSet(indexesIn: range)
        self.postsTableView.reloadSections(sections as IndexSet, with: .fade)
    }
    
    private func setupGestureRecognizer() {
        let toLeftGestureRecognizer = UISwipeGestureRecognizer()
        toLeftGestureRecognizer.direction = .right
        toLeftGestureRecognizer.addTarget(self, action: #selector(self.handleSwipes))
        let toRightGestureRecognizer = UISwipeGestureRecognizer()
        toRightGestureRecognizer.direction = .left
        toRightGestureRecognizer.addTarget(self, action: #selector(self.handleSwipes))
        
        self.view.addGestureRecognizer(toLeftGestureRecognizer)
        self.view.addGestureRecognizer(toRightGestureRecognizer)
    }
    @objc private func handleSwipes(sender: UISwipeGestureRecognizer?) {
        guard sender != nil else { return }
        switch sender?.direction {
        case UISwipeGestureRecognizer.Direction.left:
            guard switchViewControl.selectedSegmentIndex != 1 else { return }
            switchViewControl.selectedSegmentIndex = 1
            switchViewControl.sendActions(for: UIControl.Event.valueChanged)
        case UISwipeGestureRecognizer.Direction.right:
            guard switchViewControl.selectedSegmentIndex != 0 else { return }
            switchViewControl.selectedSegmentIndex = 0
            switchViewControl.sendActions(for: UIControl.Event.valueChanged)
        default:
            return
        }
    }
}

// MARK: - Hero
extension FavoritesViewController {
    private func setupHeroIDs(cell: PostViewCell, currentPost: Post) {
//        cell.postTitleLabel.hero.id = Constants.HeroIDs.postTitle + String(currentPost.id)
//        cell.postContentLabel.hero.id = Constants.HeroIDs.postTitle + String(currentPost.id)
//        cell.timePostedLabel.hero.id = Constants.HeroIDs.timedPosted + String(currentPost.id)
//        cell.positionNameLabel.hero.id = Constants.HeroIDs.positionName + String(currentPost.id)
//        cell.supportNumberLabel.hero.id = Constants.HeroIDs.supportNumber + String(currentPost.id)
//        
//        cell.addSupportButton.hero.id = Constants.HeroIDs.addSupportButton + String(currentPost.id)
//        cell.subtractSupportButton.hero.id = Constants.HeroIDs.subtractSupportButton + String(currentPost.id)
//        
        cell.wrappingView.hero.id = Constants.HeroIDs.wrappingView + String(currentPost.id)
    }
}
