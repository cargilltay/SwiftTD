//
//  AirProjectile.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 4/12/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import Foundation

import SpriteKit

class AirProjectile: BaseProjectile {
    
    init(damage: Int, position: CGPoint, target: BaseMonster) {
        let projTexture = SKTexture(imageNamed:"BasicArrow")
        let damage = damage
        let speed:CGFloat = 10
        super.init(damage: damage, speed: speed, target: target, position: position, texture: projTexture, color: UIColor.black)
    }
    
    override func projectileEffect() {
        //if(!target.hasEffect){
        //    target.hasEffect = true;
            //add air logic here
       //}
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
