//
//  RCNetworkOperation.swift
//  ringCodingChallenge
//
//  Created by Praneet Tata on 10/24/18.
//  Copyright © 2018 Praneet Tata. All rights reserved.
//

import Foundation

public class RCNetworkOperation<ResultType:Codable>: RCOperation {
    
    public typealias SuccessBlock = (ResultType) throws -> Void
    public typealias ErrorBlock = (Error)->Void
    
    private var request: URLRequest!
    private var successBlock: SuccessBlock!
    private var errorBlock: ErrorBlock!
    private var decoder: JSONDecoder?
    private var dataTask: URLSessionDataTask?
    
    
    @discardableResult init(request: URLRequest, successBlock: @escaping SuccessBlock, errorBlock: @escaping ErrorBlock,
                            dateFormat: String?, decoder: JSONDecoder? = nil) {
        super.init()
        self.request = request
        self.successBlock = successBlock
        self.errorBlock = errorBlock
        self.decoder = decoder ?? JSONDecoder()
        
    }
    
    public override func execute() {
        
        dataTask = URLSession(configuration: .default).dataTask(with: request, completionHandler: completionBlock)
        dataTask?.resume()
    }
    
    public func completionBlock(data: Data?, response: URLResponse?, error: Error?) {
        
        let httpResponse = response as? HTTPURLResponse
        
        DispatchQueue.main.async {
            guard error == nil else {
                self.errorBlock(error!)
                return
            }
            
            guard httpResponse!.statusCode > 199, httpResponse!.statusCode < 300 else {
                return
            }
            
            do {
                let decodableData = try self.decoder?.decode(ResultType.self, from: data!)
                try self.handleSuccess(decodableData!)
            } catch {
                self.errorBlock(error)
            }
        }
    }
    
    
    public func handleSuccess(_ data: ResultType) throws {
        try successBlock(data)
    }
    
    public func handleError(_ error: Error) {
        errorBlock(error)
    }
    
    
}
