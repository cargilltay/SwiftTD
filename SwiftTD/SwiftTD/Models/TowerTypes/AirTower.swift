//
//  AirTower.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 4/12/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import Foundation

import SpriteKit

class AirTower: BaseTower {
    init() {
        let towerType = TowerType.Air
        let towerTexture = SKTexture(imageNamed: "Tower")
        let radius: Int = 100
        let cost: Int = 30
        let damage: Int = 30
        let fireRate: CGFloat = 0.5
        let effectText:String = "Used For walling"
        
        super.init(type: towerType,  damage: damage, cost: cost, radius: radius, texture: towerTexture, fireRate: fireRate)
        super.setEffect(text: effectText)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
