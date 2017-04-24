//
//  FireProjectile.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 4/12/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import Foundation

import SpriteKit

class FireProjectile: BaseProjectile {
    
    var onFireTimer: Timer!
    let burnRate:CGFloat = 0.5
    let burnDamage:Int = 10
    
    init(damage: Int, position: CGPoint, target: BaseMonster) {
        let projTexture = SKTexture(imageNamed:"FireArrow")
        let damage = damage
        let speed:CGFloat = 10
        super.init(damage: damage, speed: speed, target: target, position: position, texture: projTexture, color: UIColor.black)
    }
    
    
    
    override func projectileEffect() {
        if(!target.hasFireEffect){
            target.hasFireEffect = true;
            //blue is more pronounced than red. 
            if !(target.texture == SKTexture(imageNamed: "WaterEffectMonster")){
                target.texture = SKTexture(imageNamed:"FireEffectMonster")
            }
            //add burn effect here
            
            if onFireTimer == nil {
                onFireTimer =  Timer.scheduledTimer(
                    timeInterval: TimeInterval(self.burnRate), //set this based on fireRate
                    target      : self,
                    selector    : #selector(ignite),
                    userInfo    : nil,
                    repeats     : true)
            }
        }
    }
    
    @objc func ignite(){
        
        if (self.target.hitPoints <= 0) {
            print("dead")
            self.target.isDead = true;
            self.target.removeFromParent()
        }
        
        
        if(self.target == nil || self.target.isDead || self.target.reachedEnd){
            stopTimer()
            return
        }
        self.target.hitPoints -= self.burnDamage
        self.target.updateHealth()

    }
    
    
    
    func stopTimer() {
        if onFireTimer != nil {
            onFireTimer?.invalidate()
            onFireTimer = nil
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
