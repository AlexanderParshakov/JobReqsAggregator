//
//  UserProfileViewController.swift
//  JobReqsAggregator
//
//  Created by Aleksandr Parshakov on 3/4/20.
//  Copyright © 2020 Alexander Parshakov. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var pictureSupportingView: UIView!
    @IBOutlet weak var myPostsButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        pictureSupportingView.setupBasicViewWithShadow(cornerRadius: 15)
        userPicture.layer.cornerRadius = userPicture.frame.height / 2
        myPostsButton.layer.cornerRadius = 25
    }

}
