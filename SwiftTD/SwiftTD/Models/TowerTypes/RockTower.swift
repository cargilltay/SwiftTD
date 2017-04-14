//
//  RockTower.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 4/11/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import Foundation
import SpriteKit

class RockTower: BaseTower {
    
    init() {
        let towerType: TowerType = TowerType.Rock
        let towerTexture = SKTexture(imageNamed:"Rock")
        let radius: Int = 0
        let cost: Int = 10
        let damage: Int = 0
        let fireRate: CGFloat = 0.5
        super.init(type: towerType,  damage: damage, cost: cost, radius: radius, texture: towerTexture, fireRate: fireRate)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
