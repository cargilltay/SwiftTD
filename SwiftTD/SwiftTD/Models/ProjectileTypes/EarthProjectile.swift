//
//  EarthProjectile.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 4/12/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import Foundation

import SpriteKit

class EarthProjectile: BaseProjectile {
    var effectTimer: Timer!
    var rockCircle:SKShapeNode!
    var rockRadius: CGFloat!
    
    init(damage: Int, position: CGPoint, target: BaseMonster) {
        let projTexture = SKTexture(imageNamed:"BasicArrow")
        let damage = damage
        let speed:CGFloat = 10
        rockRadius = 100
        super.init(damage: damage, speed: speed, target: target, position: position, texture: projTexture, color: UIColor.black)
    }
    
    override func projectileEffect() {
        //if(!target.hasEffect){
            //target.hasEffect = true;
            //add earth logic here
        //}
        
        
        rockCircle = SKShapeNode(circleOfRadius: CGFloat(100) ) // Size of Circle, modify to tower radius
        rockCircle.position = CGPoint(x: 500, y: 500)
        rockCircle.strokeColor = SKColor.brown
        rockCircle.zPosition = 200
        
        if effectTimer == nil {
            effectTimer =  Timer.scheduledTimer(
                timeInterval: TimeInterval(0.1), //set this based on fireRate
                target      : self,
                selector    : #selector(rockWave),
                userInfo    : nil,
                repeats     : true)
        }
    }
    
    @objc func rockWave(){
        if(rockCircle != nil){
            rockCircle.removeFromParent()
            rockCircle = nil
        }
        
        rockRadius = rockRadius + CGFloat(10)
        rockCircle = SKShapeNode(circleOfRadius: CGFloat(rockRadius))
        rockCircle.position = CGPoint(x: 500, y: 500)
        rockCircle.strokeColor = SKColor.brown
        rockCircle.zPosition = 200
        
        self.parent?.addChild(rockCircle)
        
        if(rockRadius == 300){
            stopTimer()
            rockRadius = 100
        }
    }
    
    func stopTimer() {
        if effectTimer != nil {
            effectTimer?.invalidate()
            effectTimer = nil
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
