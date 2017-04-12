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
        let towerTexture = SKTexture(imageNamed:"Rock")
        let radius: Int = 0
        let cost: Int = 10
        let damage: CGFloat = 0
        super.init(damage: damage, cost: cost, radius: radius, texture: towerTexture, color: UIColor.black)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
