//
//  EarthTower.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 4/12/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import Foundation

import SpriteKit

class EarthTower: BaseTower {
    init() {
        let towerType = TowerType.Earth
        let towerTexture = SKTexture(imageNamed: "Tower")
        let radius: Int = 100
        let cost: Int = 40
        let damage: Int = 50
        let fireRate: CGFloat = 0.5
        super.init(type: towerType,  damage: damage, cost: cost, radius: radius, texture: towerTexture, fireRate: fireRate)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}