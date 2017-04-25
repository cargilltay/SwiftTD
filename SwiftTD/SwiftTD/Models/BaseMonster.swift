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
    var gold: Int = 0
    var hasFireEffect: Bool = false
    var hasWaterEffect: Bool = false
    
    var outerHealthBar: SKShapeNode!
    var innerHealthBar: SKShapeNode!
    
    init(startLocation: CGPoint, endLocation: CGPoint, pathSolution destinations: [Cell], damage: Int, hitPoints: Int, gold: Int, texture: SKTexture, color: UIColor) {
        super.init(texture: texture, color: color, size: texture.size())
        self.texture = texture
        self.damage = damage
        self.hitPoints = hitPoints
        self.destinations = destinations
        self.speed = 10
        
        //this prevents bouncing when attempting to reach a point because you're off by x pixels
        var modifiedStart = startLocation
        modifiedStart.y = modifiedStart.y - (modifiedStart.y).truncatingRemainder(dividingBy: self.speed)
        
        self.zPosition = 5
        self.position = modifiedStart
        
        self.startLocation = startLocation
        self.endLocation = endLocation
        
        
        
    }
    
    func refreshHealthBars(innerSize: CGSize){
        //SKShapeNodes persist if set twice. Need to nil each time we update shapes
        if(innerHealthBar != nil  && outerHealthBar != nil){
            innerHealthBar.removeFromParent()
            innerHealthBar = nil
            outerHealthBar.removeFromParent()
            outerHealthBar = nil
        }
        
        outerHealthBar = SKShapeNode(rectOf: CGSize(width: self.size.width, height: 10))
        outerHealthBar.strokeColor = SKColor.black
        outerHealthBar.fillColor = SKColor.red
        outerHealthBar.zPosition = 110
        outerHealthBar.glowWidth = 1.0
        
        innerHealthBar = SKShapeNode(rectOf: innerSize)
        innerHealthBar.strokeColor = SKColor.black
        innerHealthBar.fillColor = SKColor.green
        innerHealthBar.zPosition = 111
        innerHealthBar.glowWidth = 1.0
        
        //outerHealthBar.addChild(innerHealthBar)
        if(outerHealthBar.parent == nil && innerHealthBar.parent == nil){
            self.parent?.addChild(outerHealthBar)
            self.parent?.addChild(innerHealthBar)
        }
    }
    
    func updateHealth(){
        let newWidth = (CGFloat(self.hitPoints) / 100) * self.size.width
        let newHeight = CGFloat(10.0)
        
        refreshHealthBars(innerSize: CGSize(width: newWidth, height: newHeight))
    }
    
    func updatePosition(){
        
        updateHealthBarPositions()
        
        //hasReachEnd
        if(self.position.x == self.endLocation.x && self.position.y == self.endLocation.y){
            self.reachedEnd = true
            return
        }
        
        //no points left so lets get to exit
        let endCell = Cell(x: self.endLocation.x, y: self.endLocation.y)
        destinations.append(endCell)
    
        var curDest = destinations[self.destination]
        let xWithOffset = curDest.xPos + CGFloat(37.5)
        let yWithOffset = curDest.yPos + CGFloat(37.5)
        
        if (xWithOffset == self.position.x && yWithOffset == self.position.y) {
            self.destination += 1
            if(self.destination == self.destinations.count){
                return
            }
            
            curDest = destinations[self.destination]
        }
        //print(self.position.x)
        
        if (self.position.x < xWithOffset) {
            self.position.x += self.speed
        } else if (self.position.x > xWithOffset) {
            if(self.position.x - xWithOffset < self.speed){
                self.position.x -= self.position.x - xWithOffset
            }
            else{
                self.position.x -= self.speed
            }
        }
        
        if (self.position.y < yWithOffset) {
            self.position.y += self.speed
        } else if (self.position.y > yWithOffset) {
            if(self.position.y - yWithOffset < self.speed){
                self.position.y -= self.position.y - yWithOffset
            }
            else{
                self.position.y -= self.speed
            }
        }
        
    }
    
    
    func updateHealthBarPositions(){
        if(isDead || reachedEnd || outerHealthBar == nil || innerHealthBar == nil){
            return
        }
        outerHealthBar.position = CGPoint(x: self.position.x, y: self.position.y + self.size.height)
        innerHealthBar.position = CGPoint(x: self.position.x - (self.size.width / 2), y: self.position.y + self.size.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
