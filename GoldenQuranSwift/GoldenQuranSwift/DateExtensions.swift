//
//  DateExtensions.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 3/6/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import Foundation

extension Date {
    var timeStamp: Double {
        return self.timeIntervalSince1970
    }
}
