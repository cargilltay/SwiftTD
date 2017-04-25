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
    var kills: Int = 0
    var hasTarget = false
    var type: TowerType!
    var fireTimer : Timer?
    var fireRate: CGFloat!
    var projectileFactory: ProjectileFactory = ProjectileFactory()
    var effectText: String!
    
    init(type: TowerType, damage: Int, cost: Int!, radius: Int, texture: SKTexture, fireRate: CGFloat) {
        super.init(texture: texture, color: UIColor.black, size: texture.size())
        self.radius = radius
        self.damage = damage
        self.cost = cost
        self.type = type
        self.fireRate = fireRate
        self.zPosition = 100
        self.kills = 0
    }
    
    func scanForTarget(targets: [BaseMonster]){
        if(self.type == TowerType.Rock){
            return;
        }
        
        self.targets = targets
        
        let halfTextureSize = (self.texture?.size().width)! / 2
        
        let xOffsetLeft = self.position.x - CGFloat(self.radius)
        let xOffsetRight = self.position.x + (halfTextureSize + CGFloat(self.radius))
        let yOffsetDown = self.position.y - CGFloat(self.radius)
        let yOffsetUp = self.position.y + (halfTextureSize + CGFloat(self.radius))
        
        
        for target in self.targets{
            let inXLeft = (target.position.x >= xOffsetLeft)
            let inXRight = (target.position.x <= xOffsetRight)
            let inYDown = (target.position.y >= yOffsetDown)
            let inYUp = (target.position.y <= yOffsetUp)
            
            if(inXLeft && inXRight && inYDown && inYUp){
                tempTarget = target
                    if fireTimer == nil {
                        fireTimer =  Timer.scheduledTimer(
                            timeInterval: TimeInterval(self.fireRate), //set this based on fireRate
                            target      : self,
                            selector    : #selector(addProjectile),
                            userInfo    : nil,
                            repeats     : true)
                    }
                
            }
        }
    }
    
    @objc func addProjectile(){
        //use factory here to generate projecile based on tower type
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
        if(self.type == TowerType.Rock){
            return;
        }
        
        for (index,proj) in self.projectiles.enumerated().reversed(){
            proj.updatePosition()
            
            if (proj.hitTarget || proj.target.isDead) {
                self.projectiles.remove(at: index)
                proj.removeFromParent()
                //self.target = nil
                self.hasTarget = false
                self.kills += 1
                stopTimer()
            }
        }
    }
    
    //send funciton to this
    func setEffect(text: String){
        self.effectText = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
