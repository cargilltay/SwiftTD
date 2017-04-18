//
//  LeaderBoardEntry.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 4/17/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import Foundation

class LeaderBoardEntry{
    var userName: String!
    var score: Int!
    var date: Date!
    
    init(userName:String, score: Int){
        self.userName = userName
        self.score = score
        self.date = Date()
    }
}
