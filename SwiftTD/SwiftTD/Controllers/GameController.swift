//
//  GameController.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 3/27/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import Foundation
import SpriteKit

class GameController {
    var level: Int = 1
    var lives: Int = 100
    var gold: Int = 0
    var score: Int = 0
    var numMonsters: Int = 10
    var round: Int = 1
    var monsters: [BaseMonster] = []
    var towers: [BaseTower] = []
    
    
    var time: Date = Date()
    //var difficulty
    //var mode
    func setup(){
        self.populateMinions()
    }
    
    func populateMinions(){
        //going to ahve to send monsters their stats dynamically eventually.
        for _ in 1...self.numMonsters {
            let m = BaseMonster(damage: 2, hitPoints: 2, texture: SKTexture(imageNamed: "Monster"), color: UIColor.blue)
            self.monsters.append(m)
        }
    }
}
