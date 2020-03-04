//
//  PostViewController.swift
//  JobReqsAggregator
//
//  Created by Alexander Parshakov on 1/23/20.
//  Copyright © 2020 Alexander Parshakov. All rights reserved.
//

import Foundation
import UIKit
import JGProgressHUD

class PostViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var addToFavoritesButton: UIButton!
    @IBOutlet weak var readLaterButton: UIButton!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var positionNameLabel: UILabel!
    @IBOutlet weak var supportNumberLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var materialsHeaderView: UIView!
    @IBOutlet weak var linksTableView: UITableView!
    
    @IBOutlet weak var addSupportButton: UIButton!
    @IBOutlet weak var subtractSupportButton: UIButton!
    
    
    // MARK: - Constraints
    
    @IBOutlet weak var linksTableViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Actions
    @IBAction func subtractSupport(_ sender: Any) {
        subtractSupport()
        supportNumberLabel.text = String(post.supportNumber)
    }
    @IBAction func addSupport(_ sender: Any) {
        addSupport()
        supportNumberLabel.text = String(post.supportNumber)
    }
    @IBAction func addToFavorites(_ sender: Any) {
        if !post.isFavorite {
            showFavSelection()
            self.post.isFavorite = true
            RealmService.Posts.update(post: post)
            return
        }
        else {
            hideFavSelection()
            self.post.isFavorite = false
            RealmService.Posts.update(post: post)
        }
    }
    @IBAction func addToReadLater(_ sender: Any) {
        if !post.isReadLater {
            showReadLaterSelection()
            self.post.isReadLater = true
            RealmService.Posts.update(post: post)
            return
        }
        else {
            hideReadLaterSelection()
            self.post.isReadLater = false
            RealmService.Posts.update(post: post)
        }
    }
    
    // MARK: - Variables
    var post: Post = Post(id: 0, position: Position(id: 0, title: "", description: "", avgSalary: 0, openVacancies: 0, skillsRequired: nil, relatedCourses: nil, relatedMaterials: nil), supportNumber: 0, title: "", content: "", timePosted: "")
    var numberOfMaterials: Int {
        return post.position.relatedMaterials?.count ?? 0
    }
    var numberOfCourses: Int {
        return post.position.relatedCourses?.count ?? 0
    }
    var originalSupport: Int = 0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButton(button: addToFavoritesButton)
        setupButton(button: readLaterButton)
        setupGestureRecognizer()
        
        setupData()
        setupHeroIDs()
        
        setupMaterialsVisibility()
        linksTableView.reloadData()
        linksTableViewHeightConstraint.constant = linksTableView.contentSize.height
        
        scrollView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.post = RealmService.Posts.retrieve(byId: post.id)
        if post.isFavorite {
            highlightButtonSelection(button: addToFavoritesButton)
        } else { dehighlightButtonSelection(button: addToFavoritesButton) }
        if post.isReadLater {
            highlightButtonSelection(button: readLaterButton)
        } else { dehighlightButtonSelection(button: readLaterButton) }
    }
    
    func setupData() {
        postTitleLabel.text = post.title
        positionNameLabel.text = post.position.title
        supportNumberLabel.text = String(post.supportNumber)
        timeLabel.text = post.timePosted
        contentLabel.text = post.content
        
        originalSupport = post.supportNumber
    }
}

// MARK: - Configuring UI
extension PostViewController {
    
    func setupButton(button: UIButton) {
        button.layer.cornerRadius = 15
        button.backgroundColor = Constants.Colors.lightGrey
    }
    func setupMaterialsVisibility() {
        let hide = numberOfMaterials == 0 ? true : false
        materialsHeaderView.isHidden = hide
        linksTableViewHeightConstraint.constant = hide ? 0 : linksTableView.contentSize.height
    }
}

// MARK: - Support Post
extension PostViewController {
    func subtractSupport() {
        if post.supportNumber > originalSupport - 1 {
            post.supportNumber = originalSupport - 1
            switchSupportHighlight(button: subtractSupportButton, oppositeButton: addSupportButton)
        }
        else {
            post.supportNumber = originalSupport
            dehighlightSupport(button: subtractSupportButton)
        }
    }
    
    func addSupport() {
        if post.supportNumber < originalSupport + 1 {
            post.supportNumber = originalSupport + 1
            switchSupportHighlight(button: addSupportButton, oppositeButton: subtractSupportButton)
        }
        else {
            post.supportNumber = originalSupport
            dehighlightSupport(button: addSupportButton)
        }
    }
    
    func switchSupportHighlight(button: UIButton, oppositeButton: UIButton) {
        self.highlightSupport(button: button)
        self.dehighlightSupport(button: oppositeButton)
    }
    
    func dehighlightSupport(button: UIButton) {
        UIView.animate(withDuration: 0.8) {
            button.backgroundColor = .clear
            if button == self.addSupportButton {
                button.setTitleColor(.systemGreen, for: .normal)
            } else { button.setTitleColor(.systemRed, for: .normal)}
            button.layer.cornerRadius = 0
        }
    }
    
    func highlightSupport(button: UIButton) {
        UIView.animate(withDuration: 0.8) {
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 10
        }
    }
}

// MARK: - Add to Favorities/Read Later
extension PostViewController {
    private func showHUD(text: String) {
        let hud = JGProgressHUD(style: .extraLight)
        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        hud.textLabel.text = text
        hud.animation = JGProgressHUDFadeZoomAnimation()
        hud.cornerRadius = 30
        hud.parallaxMode = .alwaysOff
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 1.2)
    }
    func hideFavSelection() {
        showHUD(text: "Удалено из Избранного")
        dehighlightButtonSelection(button: addToFavoritesButton)
    }
    func showFavSelection() {
        showHUD(text: "В Избранном")
        highlightButtonSelection(button: addToFavoritesButton)
    }
    func hideReadLaterSelection() {
        showHUD(text: "Удалено из Прочитать позже")
        dehighlightButtonSelection(button: readLaterButton)
    }
    func showReadLaterSelection() {
        showHUD(text: "Прочитать позже")
        highlightButtonSelection(button: readLaterButton)
    }
    
    
    private func highlightButtonSelection(button: UIButton) {
        UIView.animate(withDuration: 0.5) {
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)
        }
    }
    private func dehighlightButtonSelection(button: UIButton) {
        UIView.animate(withDuration: 0.5) {
            button.backgroundColor = Constants.Colors.lightGrey
            button.setTitleColor(.darkText, for: .normal)
        }
    }
}

// MARK: Handling Swipes
extension PostViewController {
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
        case UISwipeGestureRecognizer.Direction.right:
            navigationController?.popViewController(animated: true)
        case UISwipeGestureRecognizer.Direction.left:
            navigationController?.popViewController(animated: true)
        default:
            return
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y < -40 {
            navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - Conforming to UITableView Protocols
extension PostViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfMaterials
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentLink = String(post.position.relatedMaterials?[indexPath.row].url ?? "")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.postLinkCell) as! PostLinkViewCell
        cell.delegate = self
        cell.indexPath = indexPath
        cell.setLink(link: currentLink)
        
        return cell
    }
}

extension PostViewController: PostLinkButtonDelegate {
    func openLink(atIndex: IndexPath) {
        guard let url = URL(string: post.position.relatedMaterials?[atIndex.row].url ?? "") else { return }
        UIApplication.shared.open(url)
    }
}

// MARK: - Hero
extension PostViewController {
    
    private func setupHeroIDs() {
        //        postTitleLabel.hero.id = Constants.HeroIDs.postTitle + String(post.id)
        //        contentLabel.hero.id = Constants.HeroIDs.postTitle + String(post.id)
        //        timeLabel.hero.id = Constants.HeroIDs.postTitle + String(post.id)
        //        positionNameLabel.hero.id = Constants.HeroIDs.postTitle + String(post.id)
        //        supportNumberLabel.hero.id = Constants.HeroIDs.postTitle + String(post.id)
        //
        //        addSupportButton.hero.id = Constants.HeroIDs.addSupportButton + String(post.id)
        //        subtractSupportButton.hero.id = Constants.HeroIDs.subtractSupportButton + String(post.id)
        
        view.hero.id = Constants.HeroIDs.wrappingView + String(post.id)
    }
}
