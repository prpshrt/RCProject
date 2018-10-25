//
//  RedditService.swift
//  RingCodingChallege
//
//  Created by Praneet Tata on 10/24/18.
//  Copyright © 2018 Praneet Tata. All rights reserved.
//

import Foundation

public struct RedditWrapper: Codable {
    var kind: String
    var data: RedditWrapperData
}

public struct RedditWrapperData: Codable {
    var children: [RedditPost]
    var after: String?
}

public struct RedditPost: Codable {
    var kind: String
    var data: PostData
}

public struct PostData: Codable {
    var title: String
    var author: String
    var entryDate: Double
    var urlString: String
    var commentsCount: Int
    var thumbnailString: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case author 
        case entryDate = "created_utc"
        case urlString = "url"
        case thumbnailString = "thumbnail"
        case commentsCount = "num_comments"
    }
}



public class RedditService {
    
    public static var after: String?
    
    public static func getPosts(onSuccess: @escaping(RedditWrapper) -> Void, onError: @escaping(Error) -> Void) {
        
        var urlString = "https://reddit.com/top.json?limit=10"
        
        if after != nil {
            urlString += "&after=\(after!)"
        }
        
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        
        RCNetworkOperation(request: request, successBlock: onSuccess, errorBlock: onError, dateFormat: nil).enqueue()
    }
    
    
    
}
