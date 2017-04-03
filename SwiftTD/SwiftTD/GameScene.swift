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
    let screenSize = UIScreen.main.bounds
    
    //no idea what this needs to be twice as large
    //posisbly use self.frame.size.width
    var screenWidth: CGFloat?
    var screenHeight: CGFloat?
    
    static let defaultScale: CGFloat = 0.0625
    
    var monsterTimer: Timer?
    var spawnedMonsterCount: Int = 0
    var rockButton: SKSpriteNode!
    var background: SKSpriteNode!
    var movableNode : SKNode?
    var grid: Grid?
    
    override func didMove(to: SKView) {
        game.setup()
        
        setupUI()
        
        drawGrid()
        
        //should move to action event of begin round
        let solver = MazeSolverController(grid: grid!)
        
        grid!.solution = solver.solveMaze()
    }
    
    func setupUI(){
        screenWidth = screenSize.width * 2
        screenHeight = screenSize.height * 2
        
        rockButton = SKSpriteNode(imageNamed: "Rock")
        rockButton.position = CGPoint(x: 150, y: 150)
        rockButton.zPosition = 100
        rockButton.zPosition = 3
        self.addChild(rockButton)
        
        background = SKSpriteNode(imageNamed: "Background")
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        background.zPosition = 1
        self.addChild(background)
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        for (index, monst) in game.monsters.enumerated(){
            if (monst.isDead || monst.reachedEnd) {
                monst.removeFromParent()
                game.monsters.remove(at: index)
            }
        }
        
        if(game.monsters.count == 0){
            spawnedMonsterCount = 0
        }
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
            
            //check here if within grid.
            let touchX = touch.location(in: self).x
            let touchY = touch.location(in: self).y
            let xInBounds = touchX < screenWidth! && touchX > 0
            let yInBounds = touchY < screenHeight! && touchY > grid!.baseOffset
            
            //if not in bounds, bail
            if(!xInBounds || !yInBounds){
                movableNode?.removeFromParent()
                movableNode = nil
                return;
            }
            
            let closest = grid?.closestCell(x: touchX, y: touchY)
            
            //if tower already on space, bail
            if(closest!.isBlocked){
                movableNode?.removeFromParent()
                movableNode = nil
                return;
            }
            
            //if in grid. set position to grid col/row
            
            //use these to center tower in cell
            let TowerHeight = SKSpriteNode(imageNamed: "Rock").size.height
            let TowerWidth = SKSpriteNode(imageNamed: "Rock").size.width

            movableNode!.position = CGPoint(x: closest!.xPos + TowerWidth, y: closest!.yPos + TowerHeight )
            movableNode = nil
            
            closest?.isBlocked = true
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
        monster.zPosition = 5
        monster.position = CGPoint(x: screenWidth! / 2, y: screenHeight!)
        self.addChild(monster)
        
        
        //need to move to positions in grid.solution
        
        
        let moveTime = TimeInterval(2.0)
        monster.moveToCustom(x: screenWidth! / 2, y: 0.0, timeToMove: moveTime);
        
        spawnedMonsterCount += 1
    }
    
    func drawGrid(){
        let gridRows = 10
        let gridCols = 10
        let blockSize = screenWidth! / CGFloat(gridRows)
        
        grid = Grid(blockSize: blockSize, rows:gridRows, cols:gridCols, baseOffset: 250)
        grid!.position = CGPoint (x:frame.midX, y:grid!.baseOffset + grid!.texture!.size().height / 2)
        grid?.zPosition = 2
        
        addChild(grid!)
        
        let gamePiece = SKSpriteNode(imageNamed: "Spaceship")
        gamePiece.setScale(GameScene.defaultScale)
        gamePiece.position = grid!.gridPosition(row: 1, col: 0)
        grid!.addChild(gamePiece)
        
    }
}
