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
    
    
    
    init(damage: Int, speed: CGFloat, target: BaseMonster, texture: SKTexture, color: UIColor) {
        super.init(texture: texture, color: color, size: texture.size())
        
        self.damage = damage
        self.speed = speed
        self.target = target
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func checkHit () -> Bool {
        let tarX = self.target.position.x;
        let tarY = self.target.position.y;
        let checkWithinPixelOffset:CGFloat = 10.0;
        let isWithinOffsetOfX = (self.position.x >= tarX - checkWithinPixelOffset && self.position.x <= tarX + checkWithinPixelOffset) ? true : false;
        let isWithinOffsetOfY = (self.position.y >= tarY - checkWithinPixelOffset && self.position.y <= tarY + checkWithinPixelOffset) ? true : false;
        
        //check if within offset
        if (isWithinOffsetOfX && isWithinOffsetOfY) {
            self.target.hitPoints -= self.damage;
            self.hitTarget = true;
            if (self.target.hitPoints == 0) {
                    self.target.isDead = true;
            }
                return true;
            }
            return false;
        }
        
    func updatePosition () {
        //this.x += this.speed;
        //this.y += this.speed;
        
        //console.log(this.target.pos.x)
        //console.log(this.x)
        if (self.checkHit()) {
            return;
        }
        
        if (self.position.x < self.target.position.x) {
            self.position.x += self.speed;
        } else if (self.position.x > self.target.position.x) {
            self.position.x -= self.speed;
        }
        
        if (self.position.y < self.target.position.y) {
            self.position.y += self.speed;
        } else if (self.position.y > self.target.position.y) {
            self.position.y -= self.speed;
        }
        
    }
}
