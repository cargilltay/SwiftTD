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
    var monsterTimer: Timer?
    var spawnedMonsterCount: Int = 0
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
            //https://www.raywenderlich.com/123393/how-to-create-a-breakout-game-with-sprite-kit-and-swift
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
        //prevent timer being called twice
        guard monsterTimer == nil else { return }
        monsterTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(drawMonster), userInfo: nil, repeats: true)
            
        //}
    }
    
    @objc func drawMonster(){
        if(spawnedMonsterCount == game.monsters.count){
            guard monsterTimer != nil else { return }
            monsterTimer?.invalidate()
            monsterTimer = nil
            return;
        }
        let monster = game.monsters[spawnedMonsterCount]
        monster.setScale(GameScene.defaultScale)
        
        let screenSize = UIScreen.main.bounds
        //no idea what this needs to be twice as large
        let screenWidth = screenSize.width * 2
        let screenHeight = screenSize.height * 2
        
        
        monster.position = CGPoint(x: screenWidth / 2, y: screenHeight)
        self.addChild(monster)
        
        let moveTime = TimeInterval(2.0)
        
        monster.moveToCustom(x: screenWidth / 2, y: 0.0, timeToMove: moveTime);
        spawnedMonsterCount += 1
        
    
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
