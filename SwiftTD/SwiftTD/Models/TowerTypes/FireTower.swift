//
//  FireTower.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 4/12/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import Foundation

import SpriteKit

class FireTower: BaseTower {
    init() {
        let towerType = TowerType.Fire
        let towerTexture = SKTexture(imageNamed: "FireTower")
        let radius: Int = 200
        let cost: Int = 50
        let damage: Int = 40
        let fireRate: CGFloat = 0.5
        let effectText:String = "Ignites target, dealing 20\n damage a second."
        
        super.init(type: towerType,  damage: damage, cost: cost, radius: radius, texture: towerTexture, fireRate: fireRate)
        super.setEffect(text: effectText)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
