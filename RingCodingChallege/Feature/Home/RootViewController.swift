//
//  RootViewController.swift
//  RingCodingChallege
//
//  Created by Praneet Tata on 10/24/18.
//  Copyright © 2018 Praneet Tata. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private var redditPosts = [RedditPost]()
    private var totalPosts = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension;
        let cell = UINib(nibName: "RedditPostTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "RedditPostTableViewCell")
        loadData()
    }
    
    public func loadData() {
        RedditService.getPosts(onSuccess: gotRedditData, onError: onGetRedditDataError)
    }
    
    public func gotRedditData(_ redditData: RedditWrapper) {
        RedditService.after = redditData.data.after
        
        if redditPosts.count == 0 {
            redditPosts = redditData.data.children
        }
        else {
            redditPosts.append(contentsOf: redditData.data.children)
        }
        
        tableView.reloadData()
    }
    
    public func onGetRedditDataError(_ error: Error) {
        tableView.isHidden = true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return redditPosts.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RedditPostTableViewCell") as! RedditPostTableViewCell
        
        let redditPost = redditPosts[indexPath.row]
        cell.redditPost = redditPost.data
        
        return cell
    }
    
    

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == redditPosts.count - 1 {
            if redditPosts.count < totalPosts {
                loadData()
            }
        }
    }
}
