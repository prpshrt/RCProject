//
//  RCOperation.swift
//  ringCodingChallenge
//
//  Created by Praneet Tata on 10/24/18.
//  Copyright © 2018 Praneet Tata. All rights reserved.
//

import Foundation


public class RCOperation: Operation {
    
    public static var defaultQueue =  OperationQueue()
    
    @discardableResult public func enqueue<OperationType: RCOperation>(inQueue queue: OperationQueue? = RCOperation.defaultQueue) -> OperationType {
        queue?.addOperation(self)
        return self as! OperationType
    }
    
    public override final func main() {
        self.execute()
    }
    
    public func execute() {}
    
    public override final func start() {
        main()        
    }
    
}
