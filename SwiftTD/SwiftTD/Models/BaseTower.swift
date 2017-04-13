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
    var tempTarget: BaseMonster!
    var damage: Int!
    var cost: Int!
    var hasTarget = false
    var type: TowerType!
    var fireTimer : Timer?
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
        
        let xOffsetLeft = self.position.x - (halfRadius)
        let xOffsetRight = self.position.x + (halfTextureSize + halfRadius)
        let yOffsetDown = self.position.y - (halfRadius)
        let yOffsetUp = self.position.y + (halfTextureSize + halfRadius)
        
        
        for target in self.targets{
            let inXLeft = (target.position.x >= xOffsetLeft) //40
            let inXRight = (target.position.x <= xOffsetRight) //60
            let inYDown = (target.position.y >= yOffsetDown) //40
            let inYUp = (target.position.y <= yOffsetUp) //60
            
            if(inXLeft && inXRight && inYDown && inYUp){
                tempTarget = target
                    if fireTimer == nil {
                        fireTimer =  Timer.scheduledTimer(
                            timeInterval: TimeInterval(0.5),
                            target      : self,
                            selector    : #selector(addProjectile),
                            userInfo    : nil,
                            repeats     : true)
                    }
                //use factory here to generate projecile based on tower type
                
            }
        }
    }
    
    @objc func addProjectile(){
        let proj = projectileFactory.createProjectile(tower: self, target: tempTarget!)
        self.projectiles.append(proj);
        
        //proj.show();
        self.hasTarget = true;
    }
    
    func stopTimer() {
        if fireTimer != nil {
            fireTimer?.invalidate()
            fireTimer = nil
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
                stopTimer()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
