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
    
    init(name: String, earn: Double) {
        self.name = name
        self.earn = earn
    }
}

public var finalEarnData: [Earn] = []
