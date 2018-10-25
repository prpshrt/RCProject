//
//  RedditPostTableViewCell.swift
//  RingCodingChallege
//
//  Created by Praneet Tata on 10/25/18.
//  Copyright © 2018 Praneet Tata. All rights reserved.
//

import UIKit

class RedditPostTableViewCell: UITableViewCell {

    @IBOutlet var thumbNail: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var author: UILabel!
    @IBOutlet var commentsCount: UILabel!
    @IBOutlet var createdLabel: UILabel!
    
    public var redditPost: PostData? {
        didSet {
            setupUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupUI() {
        
        title.text = redditPost!.title
        author.text = redditPost!.author
        commentsCount.text = "\(redditPost!.commentsCount) comments"
        
        let createdDate = Date.dateFromMilliSeconds(milliseconds: Int(redditPost!.entryDate))
        let hours = Date().hoursFrom(from: createdDate)
        createdLabel.text = "\(hours) hours ago"
        
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openURL))
        thumbNail.isUserInteractionEnabled = true
        thumbNail.addGestureRecognizer(gestureRecognizer)
        
        guard redditPost!.thumbnailString != "default" else {
            self.thumbNail.image = UIImage(named: "postIcon")
            return
        }
        
        let url = URL(string: redditPost!.thumbnailString)
        
        ImageService.getImage(withURL: url!) { image in
            self.thumbNail.image = image
        }
    }
    
    @objc private func openURL() {
        let url = URL(string: redditPost!.urlString)
        UIApplication.shared.open(url!)
    }
    
}
