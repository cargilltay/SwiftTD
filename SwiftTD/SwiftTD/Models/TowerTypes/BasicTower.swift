//
//  BasicTower.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 4/11/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import Foundation
import SpriteKit

class BasicTower: BaseTower {
    init() {
        let towerType = TowerType.Basic
        let towerTexture = SKTexture(imageNamed: "Tower")
        let radius: Int = 250
        let cost: Int = 40
        let damage: Int = 40
        let fireRate: CGFloat = 0.5
        let effectText:String = "No special effect."
        
        super.init(type: towerType,  damage: damage, cost: cost, radius: radius, texture: towerTexture, fireRate: fireRate)
        super.setEffect(text: effectText)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
