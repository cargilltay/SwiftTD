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
    static let defaultScale: CGFloat = 0.0625
    
    var monsterTimer: Timer?
    var spawnedMonsterCount: Int = 0
    var rockButton: SKSpriteNode!
    var background: SKSpriteNode!
    var movableNode : SKNode?
    
    override func didMove(to: SKView) {
        game.setup()
        
        setupUI()
        
        drawGrid()
        
        drawMonsters()
        
    }
    
    func setupUI(){
        rockButton = SKSpriteNode(imageNamed: "Rock")
        rockButton.position = CGPoint(x: 150, y: 150)
        rockButton.zPosition = 100
        self.addChild(rockButton)
        
        background = SKSpriteNode(imageNamed: "Background")
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        self.addChild(background)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            if rockButton.contains(location) {
                movableNode = createRock()
                movableNode!.position = location
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, movableNode != nil {
            movableNode!.position = touch.location(in: self)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, movableNode != nil {
            movableNode!.position = touch.location(in: self)
            movableNode = nil
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            movableNode = nil
        }
    }
    
    func createRock() -> SKSpriteNode{
        let rock: SKSpriteNode!
        rock = SKSpriteNode(imageNamed: "Rock")
        rock.position = CGPoint(x: 150, y: 150)
        rock.zPosition = 100
        self.addChild(rock)
        
        return rock
    }
    
    func drawMonsters(){
        //prevent timer being called twice
        guard monsterTimer == nil else { return }
        monsterTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(drawMonster), userInfo: nil, repeats: true)
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
        //posisbly use self.frame.size.width
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
