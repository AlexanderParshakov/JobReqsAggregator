//
//  PostLinkViewCell.swift
//  JobReqsAggregator
//
//  Created by Alexander Parshakov on 1/25/20.
//  Copyright © 2020 Alexander Parshakov. All rights reserved.
//

import UIKit

protocol PostLinkButtonDelegate {
    func openLink(atIndex: IndexPath)
}
class PostLinkViewCell: UITableViewCell {
    var delegate: PostLinkButtonDelegate!
    var indexPath: IndexPath!
    
    @IBOutlet weak var linkButton: UIButton!
    
    @IBAction func onLinkButtonTapped(_ sender: Any) {
        self.delegate.openLink(atIndex: indexPath)
    }
    
    func setLink(link: String) {
        linkButton.setTitle(link, for: .normal)
    }
}
