//
//  MonsterStats.swift
//  SwiftTD
//
//  Created by Daniel Wynalda on 4/5/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import Foundation
import SpriteKit

class MonsterStats {
    var damage: Int!
    var speed: Double!
    var hitPoints: Int!
    var gold: Int!
    var image: SKTexture!
    
    init(damage: Int, speed: Double, hitPoints: Int, gold: Int, image: SKTexture) {
        self.damage=damage
        self.speed=speed
        self.hitPoints=hitPoints
        self.image=image
        self.gold = gold
    }
    
}
