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
    var reachedEnd = false
    var destinations: [Cell]!
    var destination: Int = 0
    var startLocation: CGPoint!
    var endLocation: CGPoint!
    
    init(startLocation: CGPoint, endLocation: CGPoint, pathSolution destinations: [Cell], damage: Int, hitPoints: Int, texture: SKTexture, color: UIColor) {
        super.init(texture: texture, color: color, size: texture.size())
        self.texture = texture
        self.damage = damage
        self.hitPoints = hitPoints
        self.destinations = destinations
        self.speed = 10
        
        //this prevents bouncing when attempting to reach a point because you're off by x pixels
        var modifiedStart = startLocation
        modifiedStart.y = modifiedStart.y - (modifiedStart.y).truncatingRemainder(dividingBy: self.speed)
        
        //this speed thing might not be smooth. May need to set to physics body and apply force
        //self.physicsBody = SKPhysicsBody()
        self.zPosition = 5
        self.position = modifiedStart
        
        self.startLocation = startLocation
        self.endLocation = endLocation
    }
    
    func moveToCustom(x: CGFloat, y: CGFloat, timeToMove: TimeInterval){
        let action = SKAction.move(to: CGPoint(x: x, y: y), duration: timeToMove)
        action.timingMode = .easeInEaseOut
        
        self.run(action) {
            self.reachedEnd = true
        }
        
    }
    
    func updatePosition(){
        
        //hasReachEnd
        if(self.position.x == self.endLocation.x && self.position.y == self.endLocation.y){
            self.reachedEnd = true
            return
        }
        else if(self.destinations.count == 0){
            //no points left so lets get to exit
            let endCell = Cell(x: self.endLocation.x, y: self.endLocation.y)
            destinations.append(endCell)
        }
        
        var curDest = destinations[self.destination]
        
        if (curDest.xPos == self.position.x && curDest.yPos == self.position.y) {
            self.destination += 1
            if(self.destination == self.destinations.count){
                return
            }
            
            curDest = destinations[self.destination]
        }
        
        if (self.position.x < curDest.xPos) {
            self.position.x += self.speed
        } else if (self.position.x > curDest.xPos) {
            self.position.x -= self.speed
        }
        
        if (self.position.y < curDest.yPos) {
            self.position.y += self.speed
        } else if (self.position.y > curDest.yPos) {
            self.position.y -= self.speed
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
