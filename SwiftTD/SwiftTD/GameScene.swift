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
    var viewController: GameViewController?
    
    
    //no idea what this needs to be twice as large
    //posisbly use self.frame.size.width
    var screenWidth: CGFloat?
    var screenHeight: CGFloat?
    
    static let defaultScale: CGFloat = 0.0625
    
    var rockButton: SKSpriteNode!
    var basicTowerButton: SKSpriteNode!
    var waterTowerButton: SKSpriteNode!
    var fireTowerButton: SKSpriteNode!
    var earthTowerButton: SKSpriteNode!
    var airTowerButton: SKSpriteNode!
    var nodeType: TowerType!
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
        
        
        rockButton = SKSpriteNode(imageNamed: "Rock")
        rockButton.position = CGPoint(x: 100, y: 200)
        rockButton.zPosition = 100
        self.addChild(rockButton)
        
        basicTowerButton = SKSpriteNode(imageNamed: "Tower")
        basicTowerButton.position = CGPoint(x: 200, y: 200)
        basicTowerButton.zPosition = 100
        self.addChild(basicTowerButton)
        
        waterTowerButton = SKSpriteNode(imageNamed: "Tower")
        waterTowerButton.position = CGPoint(x: 300, y: 200)
        waterTowerButton.zPosition = 100
        self.addChild(waterTowerButton)
        
        fireTowerButton = SKSpriteNode(imageNamed: "Tower")
        fireTowerButton.position = CGPoint(x: 400, y: 200)
        fireTowerButton.zPosition = 100
        self.addChild(fireTowerButton)
        
        earthTowerButton = SKSpriteNode(imageNamed: "Tower")
        earthTowerButton.position = CGPoint(x: 500, y: 200)
        earthTowerButton.zPosition = 100
        self.addChild(earthTowerButton)
        
        airTowerButton = SKSpriteNode(imageNamed: "Tower")
        airTowerButton.position = CGPoint(x: 600, y: 200)
        airTowerButton.zPosition = 100
        self.addChild(airTowerButton)
        
        
        //var imageView   = UIImageView(frame: self.view.bounds);
        background = SKSpriteNode(imageNamed: "Background")
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        background.zPosition = 1
        background.size = self.size
        self.addChild(background)
        
        
    }
    
    func moveMinions() {
        if (game.monsters.count == 0 && game.spawnTimer == nil) {
            game.nextMode();
        }
        
        for (index, m) in game.monsters.enumerated() {
            //seperate dead/reach end for possible logic in future
            if (m.isDead) {
                print("dead")
                m.removeFromParent()
                m.innerHealthBar.removeFromParent()
                m.outerHealthBar.removeFromParent()
                game.monsters.remove(at: index)
                game.gold += 10
                return;
            }
            else if (m.reachedEnd) {
                m.removeFromParent()
                if(m.innerHealthBar != nil && m.outerHealthBar != nil){
                    m.innerHealthBar.removeFromParent()
                    m.outerHealthBar.removeFromParent()
                }
                game.lives -= 1
                game.monsters.remove(at: index)
                return;
            }
            if(m.parent == nil){
                self.addChild(m)
            }
            m.updatePosition();
        }
    }
    
    func moveProjectiles(){
        for tower in game.towers{
            for proj in tower.projectiles{
                if(proj.parent == nil){
                    self.addChild(proj)
                }
            }
            tower.scanForTarget(targets: game.monsters)
            tower.fireProjectiles()
        }
    }

    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        
        if(game.mode == GameMode.Defend){
            moveMinions()
            moveProjectiles()
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissTowerPanel()
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if rockButton.contains(location) {
                if(game.gold < 10){
                    return
                }
                movableNode = createTower(type: TowerType.Rock)
                movableNode!.position = location
                nodeType = TowerType.Rock
            }
            
            if basicTowerButton.contains(location) {
                if(game.gold < 40){
                    return
                }
                towerDrag = true
                movableNode = createTower(type: TowerType.Basic)
                movableNode!.position = location
                nodeType = TowerType.Basic
            }
            
            if waterTowerButton.contains(location) {
                if(game.gold < 40){
                    return
                }
                towerDrag = true
                movableNode = createTower(type: TowerType.Water)
                movableNode!.position = location
                nodeType = TowerType.Water
            }
            
            if fireTowerButton.contains(location) {
                if(game.gold < 50){
                    return
                }
                towerDrag = true
                movableNode = createTower(type: TowerType.Fire)
                movableNode!.position = location
                nodeType = TowerType.Fire
            }
            
            if earthTowerButton.contains(location) {
                if(game.gold < 40){
                    return
                }
                towerDrag = true
                movableNode = createTower(type: TowerType.Earth)
                movableNode!.position = location
                nodeType = TowerType.Earth
            }
            
            if airTowerButton.contains(location) {
                if(game.gold < 30){
                    return
                }
                towerDrag = true
                movableNode = createTower(type: TowerType.Air)
                movableNode!.position = location
                nodeType = TowerType.Air
            }
            
            if grid!.contains(location){
                let closest = grid!.closestCell(x: location.x, y: location.y)
                if(closest.isBlocked && closest.hasTower){
                    towerCircle = SKShapeNode(circleOfRadius: CGFloat(closest.tower.radius) ) // Size of Circle, modify to tower radius
                    towerCircle.position = CGPoint(x: closest.xPos +  TowerWidth , y: closest.yPos +  TowerHeight)
                    towerCircle.strokeColor = SKColor.black
                    towerCircle.zPosition = 101
                    towerCircle.glowWidth = 1.0
                    self.addChild(towerCircle)
                    viewController!.showPanel(tower: closest.tower, yPos: frame.height - viewController!.topPanel.frame.height)
                }
            }
            
        }
    }
    
    func dismissTowerPanel(){
        if(towerCircle != nil){
            viewController!.hidePanel()
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
            let yInBounds = touchY < grid!.size.height + grid!.baseOffset && touchY > grid!.baseOffset
            
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
            let towerPosition = CGPoint(x: closest!.xPos + TowerWidth, y: closest!.yPos + TowerHeight )
            
            movableNode!.position = towerPosition
            closest?.tower = movableNode as! BaseTower
            if(nodeType == TowerType.Water){
                print("water")
                game.gold -= 40
            }
            if(nodeType == TowerType.Earth){
                print("earth")
                game.gold -= 40
            }
            if(nodeType == TowerType.Fire){
                print("fire")
                game.gold -= 50
            }
            if(nodeType == TowerType.Air){
                print("air")
                game.gold -= 30
            }
            if(nodeType == TowerType.Rock){
                print("rock")
                game.gold -= 10
            }
            if(nodeType == TowerType.Basic){
                print("basic")
                game.gold -= 40
            }
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
    
    func createTower(type: TowerType) -> BaseTower{
        let tower = towerFactory.createTower(type: type)
        self.addChild(tower)
        
        game.towers.append(tower)
        
        return tower
    }
    
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
