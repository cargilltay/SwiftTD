//
//  GameScene.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 2/24/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    override func didMove(to: SKView) {
        
        
        var tMonster = BaseMonster(damage: 2, hitPoints: 2, texture: SKTexture(imageNamed: "Spaceship"), color: UIColor.blue)
        
        if let grid = Grid(blockSize: 40.0, rows:10, cols:10) {
            grid.position = CGPoint (x:frame.midX, y:frame.midY)
            addChild(grid)
            
            let gamePiece = SKSpriteNode(imageNamed: "Spaceship")
            gamePiece.setScale(0.0625)
            gamePiece.position = grid.gridPosition(row: 1, col: 0)
            grid.addChild(gamePiece)
            
            //add monsters
            
            tMonster.setScale(0.0625)
            self.addChild(tMonster)
        }
        
    }
    
    
}
