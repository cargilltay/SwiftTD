//
//  WaterProjectile.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 4/12/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import Foundation

import SpriteKit

class WaterProjectile: BaseProjectile {
    
    init(damage: Int, position: CGPoint, target: BaseMonster) {
        let projTexture = SKTexture(imageNamed:"WaterArrow")
        let damage = damage
        let speed:CGFloat = 15
        super.init(damage: damage, speed: speed, target: target, position: position, texture: projTexture, color: UIColor.black)
    }
    
    override func projectileEffect() {
        if(!target.hasWaterEffect){
            target.hasWaterEffect = true;
            target.texture = SKTexture(imageNamed:"WaterEffectMonster")
            target.speed = target.speed / 1.5
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
