//
//  ResultData.swift
//  Earn
//
//  Created by Will Wang on 10/21/18.
//  Copyright © 2018 Will Wang. All rights reserved.
//

import Foundation

public struct Earn {
    var name: String
    var earn: Double
    var items: String
    
    init(name: String, earn: Double, items: String) {
        self.name = name
        self.earn = earn
        self.items = items
    }
}

public var finalEarnData: [Earn] = []
