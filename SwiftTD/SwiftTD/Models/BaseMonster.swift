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
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        
        let centerHoriz = screenWidth / 2
        
        
        let bottom = CGPoint(x: 0.0, y: 0.0)
        
        
        self.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.texture = texture
        self.damage = damage
        self.hitPoints = hitPoints
        self.moveToCustom(point: bottom);
    }
    
    func moveToCustom(point: CGPoint){
        let move = SKAction.move(to: point, duration:2.0)
        self.run(move)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
