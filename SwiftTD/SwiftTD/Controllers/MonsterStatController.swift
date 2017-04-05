//
//  MonsterStatController.swift
//  SwiftTD
//
//  Created by Daniel Wynalda on 4/5/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import Foundation

class MonsterStatController {
    var statMap: [Int:MonsterStats]!
    var level: Int = 0
    
    func addStat(stat: MonsterStats){
        statMap[level] = stat
        level+=1
    }
}
