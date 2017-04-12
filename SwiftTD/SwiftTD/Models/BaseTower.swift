//
//  Tower.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 2/26/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import UIKit
import SpriteKit

class BaseTower: SKSpriteNode {
    var projectiles: [BaseProjectile] = []
    var radius: Int = 100
    var targets: [BaseMonster] = []
    var damage: Int!
    var cost: Int!
    var hasTarget = false
    var type: TowerType!
    var projectileFactory: ProjectileFactory = ProjectileFactory()
    
    init(type: TowerType, damage: Int, cost: Int!, radius: Int, texture: SKTexture, color: UIColor) {
        super.init(texture: texture, color: color, size: texture.size())
        self.radius = radius
        self.damage = damage
        self.cost = cost
        self.type = type
        self.zPosition = 100
    }
    
    func scanForTarget(targets: [BaseMonster]){
        self.targets = targets
        
        let halfTextureSize = (self.texture?.size().width)! / 2
        let halfRadius:CGFloat = CGFloat(self.radius) / 2.0
        
        let xOffsetLeft = self.position.x - (halfTextureSize - halfRadius)
        let xOffsetRight = self.position.x + (halfTextureSize + halfRadius)
        let yOffsetDown = self.position.y - (halfTextureSize - halfRadius)
        let yOffsetUp = self.position.y + (halfTextureSize + halfRadius)
        
        
        for target in self.targets{
            let inXLeft = (target.position.x >= xOffsetLeft)
            let inXRight = (target.position.x <= xOffsetRight)
            let inYDown = (target.position.y >= yOffsetDown)
            let inYUp = (target.position.y <= yOffsetUp)
            
            if(inXLeft && inXRight && inYDown && inYUp){
                
                //use factory here to generate projecile based on tower type
                let proj = projectileFactory.createProjectile(tower: self, target: target)
                //let proj = BaseProjectile(damage: 10, speed: 10, target: target, position: self.position, texture: SKTexture(imageNamed: "BasicArrow"), color: UIColor.black);
                self.projectiles.append(proj);
                
                //proj.show();
                self.hasTarget = true;
            }
        }
    }
    
    func fireProjectiles(){
        for (index,proj) in self.projectiles.enumerated().reversed(){
            proj.updatePosition()
            
            if (proj.hitTarget || proj.target.isDead) {
                self.projectiles.remove(at: index)
                proj.removeFromParent()
                //self.target = nil
                self.hasTarget = false
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
