//
//  BaseProjectile.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 2/28/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import UIKit
import SpriteKit

class BaseProjectile: SKSpriteNode {
    var damage: Int = 0
    var hitTarget: Bool = false
    var target: BaseMonster!
    
    
    
    init(damage: Int, speed: CGFloat, target: BaseMonster, position: CGPoint, texture: SKTexture, color: UIColor) {
        super.init(texture: texture, color: color, size: texture.size())
        self.position = position
        self.damage = damage
        self.speed = speed
        self.target = target
        
        self.zPosition = 101
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func checkHit () -> Bool {
        
        
        let tarX = self.target.position.x
        let tarY = self.target.position.y
        let checkWithinPixelOffset:CGFloat = 10.0
        let isWithinOffsetOfX = (self.position.x >= tarX - checkWithinPixelOffset && self.position.x <= tarX + checkWithinPixelOffset) ? true : false
        let isWithinOffsetOfY = (self.position.y >= tarY - checkWithinPixelOffset && self.position.y <= tarY + checkWithinPixelOffset) ? true : false
        
        //check if within offset
        //print(isWithinOffsetOfX)
        if (isWithinOffsetOfX && isWithinOffsetOfY) {
            self.projectileEffect()
            self.target.hitPoints -= self.damage
            self.target.updateHealth()
            self.hitTarget = true
            self.removeFromParent()
            if (self.target.hitPoints <= 0) {
                    print("dead")
                    self.target.isDead = true;
                    self.target.removeFromParent()
            }
            return true
        }
        return false
    }

    func projectileEffect(){
        return;
    }

    func updatePosition () {
        if (self.checkHit()) {
            return
        }
        
        if (self.position.x < self.target.position.x) {
            self.position.x += self.speed
        } else if (self.position.x > self.target.position.x) {
            self.position.x -= self.speed
        }
        
        if (self.position.y < self.target.position.y) {
            self.position.y += self.speed
        } else if (self.position.y > self.target.position.y) {
            self.position.y -= self.speed
        }
        
    }
}
