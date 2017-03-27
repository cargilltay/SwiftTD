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
    let game: GameController = GameController()
    let TowerButtonName = "Rock"
    static let defaultScale: CGFloat = 0.0625
    var isFingerOnTower = false
    
    override func didMove(to: SKView) {
        game.setup()
        
        drawGrid()
        
        drawMonsters()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        
        if let body = physicsWorld.body(at: touchLocation) {
            //start here: Not detecting for some reason
            print(body.node!.name ?? "none")
            if body.node!.name == TowerButtonName {
                print("Began touch on paddle")
                isFingerOnTower = true
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isFingerOnTower {
            let touch = touches.first
            let touchLocation = touch!.location(in: self)
            let previousLocation = touch!.previousLocation(in: self)
            
            let tower = childNode(withName: TowerButtonName) as! SKSpriteNode
            
            //create towerX
            var towerX = tower.position.x + (touchLocation.x - previousLocation.x)
            
            //assign towerX
            towerX = max(towerX, tower.size.width/2)
            towerX = min(towerX, size.width - tower.size.width/2)
            
            //set position during drag
            tower.position = CGPoint(x: towerX, y: tower.position.y)
        }
    }
    
    func drawMonsters(){
        //temporary
        let tMonster = BaseMonster(damage: 2, hitPoints: 2, texture: SKTexture(imageNamed: "Spaceship"), color: UIColor.blue)
        
        tMonster.setScale(GameScene.defaultScale)
        tMonster.position = CGPoint(x: 0.0 / 2, y: UIScreen.main.bounds.height)
        self.addChild(tMonster)
        
        let moveTime = TimeInterval(2.0)
        
        tMonster.moveToCustom(x: 0.0, y: 0.0, timeToMove: moveTime);
    }
    
    func drawGrid(){
        if let grid = Grid(blockSize: 40.0, rows:10, cols:10) {
            grid.position = CGPoint (x:frame.midX, y:frame.midY)
            addChild(grid)
            
            let gamePiece = SKSpriteNode(imageNamed: "Spaceship")
            gamePiece.setScale(GameScene.defaultScale)
            gamePiece.position = grid.gridPosition(row: 1, col: 0)
            grid.addChild(gamePiece)
            
        }
    }
}
