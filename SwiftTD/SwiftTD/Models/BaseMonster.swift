//
//  BaseMonster.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 2/28/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import UIKit
import SpriteKit

class BaseMonster: SKSpriteNode {
    var damage: Int = 0
    var hitPoints: Int = 0
    var isDead: Bool = false
    var clearedStage = false
    
    init(damage: Int, hitPoints: Int, texture: SKTexture, color: UIColor) {
        super.init(texture: texture, color: color, size: texture.size())
        self.texture = texture
        self.damage = damage
        self.hitPoints = hitPoints
    }
    
    func moveToCustom(x: CGFloat, y: CGFloat, timeToMove: TimeInterval){
        let actionX = SKAction.moveTo(x: x, duration: timeToMove)
        let actionY = SKAction.moveTo(y: y, duration: timeToMove)
        actionX.timingMode = .easeInEaseOut
        actionY.timingMode = .easeInEaseOut
        //let move = SKAction.move(to: point, duration:2.0)
        self.run(actionX)
        self.run(actionY)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
