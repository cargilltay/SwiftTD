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
        let towerTexture = SKTexture(imageNamed: "Tower")
        let radius: Int = 100
        let cost: Int = 50
        let damage: CGFloat = 40
        super.init(damage: damage, cost: cost, radius: radius, texture: towerTexture, color: UIColor.black)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
