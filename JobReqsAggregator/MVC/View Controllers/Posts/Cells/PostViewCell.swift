//
//  PostViewCell.swift
//  JobReqsAggregator
//
//  Created by Alexander Parshakov on 12/12/19.
//  Copyright © 2019 Alexander Parshakov. All rights reserved.
//

import UIKit

class PostViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var positionNameLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postContentLabel: UILabel!
    @IBOutlet weak var supportNumberLabel: UILabel!
    @IBOutlet weak var timePostedLabel: UILabel!
    @IBOutlet weak var wrappingView: UIView!
    @IBOutlet weak var addSupportButton: UIButton!
    @IBOutlet weak var subtractSupportButton: UIButton!
    

    
    // MARK: - Actions
    @IBAction func onMinusTapped(_ sender: Any) {
        
    }
    @IBAction func onPlusTapped(_ sender: Any) {
        
    }
    
    func setPost(post: Post) {
        positionNameLabel.text = post.position.title
        postTitleLabel.text = post.title
        postContentLabel.text = post.content
        supportNumberLabel.text = String(post.supportNumber)
        timePostedLabel.text = post.timePosted
        
        wrappingView.setupBasicViewWithShadow()
        
        selectionStyle = .none
    }
    
}
