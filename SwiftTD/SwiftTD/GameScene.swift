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
    let towerFactory: TowerFactory = TowerFactory()
    let screenSize = UIScreen.main.bounds
    let TowerHeight = SKSpriteNode(imageNamed: "Rock").size.height
    let TowerWidth = SKSpriteNode(imageNamed: "Rock").size.width
    
    
    //no idea what this needs to be twice as large
    //posisbly use self.frame.size.width
    var screenWidth: CGFloat?
    var screenHeight: CGFloat?
    
    static let defaultScale: CGFloat = 0.0625
    
    var rockButton: SKSpriteNode!
    var towerButton: SKSpriteNode!
    var background: SKSpriteNode!
    var movableNode : SKNode?
    var towerCircle:SKShapeNode!
    var towerDrag = false
    var grid: Grid?
    
    override func didMove(to: SKView) {
        setupUI()
        
        drawGrid()
        
    }
    
    func setupUI(){
        screenWidth = screenSize.width * 2
        screenHeight = screenSize.height * 2
        self.isUserInteractionEnabled = true
        
        towerButton = SKSpriteNode(imageNamed: "Tower")
        towerButton.position = CGPoint(x: 300, y: 200)
        towerButton.zPosition = 100
        self.addChild(towerButton)
        
        rockButton = SKSpriteNode(imageNamed: "Rock")
        rockButton.position = CGPoint(x: 150, y: 200)
        rockButton.zPosition = 100
        self.addChild(rockButton)
        
        background = SKSpriteNode(imageNamed: "Background")
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        background.zPosition = 1
        self.addChild(background)
    }
    
    func moveMinions() {
        if (game.monsters.count == 0) {
            game.nextMode();
        }
        
        for (index, m) in game.monsters.enumerated() {
            //seperate dead/reach end for possible logic in future
            if (m.isDead) {
                print("dead")
                m.removeFromParent()
                game.monsters.remove(at: index)
                return;
            }
            else if (m.reachedEnd) {
                m.removeFromParent()
                game.monsters.remove(at: index)
                return;
            }
            if(m.parent == nil){
                self.addChild(m)
            }
            m.updatePosition();
        }
    }

    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        if(game.mode == GameMode.Defend){
            moveMinions()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissTowerPanel()
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if rockButton.contains(location) {
                movableNode = createTower(type: TowerType.Rock)
                movableNode!.position = location
            }
            
            if towerButton.contains(location) {
                towerDrag = true
                
                //somehow send tower type here
                movableNode = createTower(type: TowerType.Basic)
                movableNode!.position = location
            }
            
            if grid!.contains(location){
                let closest = grid!.closestCell(x: location.x, y: location.y)
                if(closest.isBlocked && closest.hasTower){
                    towerCircle = SKShapeNode(circleOfRadius: 100 ) // Size of Circle, modify to tower radius
                    towerCircle.position = CGPoint(x: closest.xPos +  TowerWidth , y: closest.yPos +  TowerHeight)
                    towerCircle.strokeColor = SKColor.black
                    towerCircle.zPosition = 101
                    towerCircle.glowWidth = 1.0
                    self.addChild(towerCircle)
                }
            }
            
        }
    }
    
    func dismissTowerPanel(){
        if(towerCircle != nil){
            towerCircle.removeFromParent()
            towerCircle = nil
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
            movableNode!.position = CGPoint(x: closest!.xPos + TowerWidth, y: closest!.yPos + TowerHeight )
            movableNode = nil
            
            closest?.isBlocked = true
            if(towerDrag){
                closest?.hasTower = true
                towerDrag = false
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            movableNode = nil
        }
    }
    
    
    //eventually pass type to this
    func createTower(type: TowerType) -> BaseTower{
        let tower = towerFactory.createTower(type: type)
        tower.zPosition = 100
        self.addChild(tower)
        
        return tower
    }

    /*
    func createRock() -> SKSpriteNode{
        let rock: SKSpriteNode!
        rock = SKSpriteNode(imageNamed: "Rock")
        rock.zPosition = 100
        self.addChild(rock)
        
        return rock
    }
    */
    
    func drawGrid(){
        let gridRows = 10
        let gridCols = 10
        let blockSize = screenWidth! / CGFloat(gridRows)
        
        grid = Grid(blockSize: blockSize, rows:gridRows, cols:gridCols, baseOffset: 250)
        grid!.position = CGPoint (x:frame.midX, y:grid!.baseOffset + grid!.texture!.size().height / 2)
        grid?.zPosition = 2
        
        addChild(grid!)
    }
}
