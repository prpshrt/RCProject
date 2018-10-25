//
//  Extension.swift
//  RingCodingChallege
//
//  Created by Praneet Tata on 10/25/18.
//  Copyright © 2018 Praneet Tata. All rights reserved.
//

import Foundation

extension Date {
    
    static func dateFromMilliSeconds(milliseconds: Int) -> Date {
        return Date(timeIntervalSince1970: TimeInterval(milliseconds))
    }
    
    func hoursFrom(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
}
