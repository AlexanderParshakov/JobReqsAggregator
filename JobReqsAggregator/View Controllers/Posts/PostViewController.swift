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
    @IBOutlet weak var addToFavoritesButton: UIButton!
    @IBOutlet weak var readLaterButton: UIButton!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var positionNameLabel: UILabel!
    @IBOutlet weak var supportNumberLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
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
        if !addedToFavorite {
            showFavSelection()
        }
        else {
            hideFavSelection()
        }
    }
    
    // MARK: - Variables
    var post: Post = Post(id: 0, position: Position(id: 0, title: "", description: "", avgSalary: 0, openVacancies: 0), supportNumber: 0, title: "", content: "", timePosted: "")
    var numberOfMaterials: Int {
        return post.position.relatedMaterials?.count ?? 0
    }
    var numberOfCourses: Int {
        return post.position.relatedCourses?.count ?? 0
    }
    var originalSupport: Int = 0
    var addedToFavorite: Bool = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButton(button: addToFavoritesButton)
        setupButton(button: readLaterButton)
        
        setupData()
        linksTableView.reloadData()
        linksTableViewHeightConstraint.constant = linksTableView.contentSize.height
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

extension PostViewController {
    func hideFavSelection() {
        let hud = JGProgressHUD(style: .extraLight)
        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        hud.textLabel.text = "Удалено из Избранного"
        hud.animation = JGProgressHUDFadeZoomAnimation()
        hud.cornerRadius = 30
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 1.2)
        
        UIView.animate(withDuration: 0.5) {
            self.addToFavoritesButton.backgroundColor = Constants.Colors.lightGrey
            self.addToFavoritesButton.setTitleColor(.darkText, for: .normal)
        }
        addedToFavorite = false
    }
    func showFavSelection() {
        let hud = JGProgressHUD(style: .extraLight)
        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        hud.textLabel.text = "В Избранном"
        hud.animation = JGProgressHUDFadeZoomAnimation()
        hud.cornerRadius = 30
        hud.parallaxMode = .alwaysOff
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 1.2)
        
        UIView.animate(withDuration: 0.5) {
            self.addToFavoritesButton.backgroundColor = .systemBlue
            self.addToFavoritesButton.setTitleColor(.white, for: .normal)
        }
        addedToFavorite = true
        return
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
