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
    let TowerHeight = SKSpriteNode(imageNamed: "Tower").size.height
    let TowerWidth = SKSpriteNode(imageNamed: "Tower").size.width
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
        
        //need to add gold coins
        let goldCoin1 = SKSpriteNode(imageNamed: "GoldCoin")
        goldCoin1.zPosition = 100
        goldCoin1.position = CGPoint(x: 60, y: 140)
        let goldCoin2 = SKSpriteNode(imageNamed: "GoldCoin")
        goldCoin2.zPosition = 100
        goldCoin2.position = CGPoint(x: 160, y: 140)
        let goldCoin3 = SKSpriteNode(imageNamed: "GoldCoin")
        goldCoin3.zPosition = 100
        goldCoin3.position = CGPoint(x: 260, y: 140)
        let goldCoin4 = SKSpriteNode(imageNamed: "GoldCoin")
        goldCoin4.zPosition = 100
        goldCoin4.position = CGPoint(x: 360, y: 140)
        let goldCoin5 = SKSpriteNode(imageNamed: "GoldCoin")
        goldCoin5.zPosition = 100
        goldCoin5.position = CGPoint(x: 460, y: 140)
        let goldCoin6 = SKSpriteNode(imageNamed: "GoldCoin")
        goldCoin6.zPosition = 100
        goldCoin6.position = CGPoint(x: 560, y: 140)
        self.addChild(goldCoin1)
        self.addChild(goldCoin2)
        self.addChild(goldCoin3)
        self.addChild(goldCoin4)
        self.addChild(goldCoin5)
        self.addChild(goldCoin6)
        
        
        rockButton = SKSpriteNode(imageNamed: "Rock")
        rockButton.position = CGPoint(x: 100, y: 200)
        rockButton.zPosition = 100
        let rockPrice = SKLabelNode(fontNamed: "Chalkduster")
        rockPrice.text = "\(String(describing: TowerPrice[TowerType.Rock]!))"
        rockPrice.color = UIColor.black
        rockPrice.position = CGPoint(x: 100, y: 125)
        rockPrice.zPosition = 100
        self.addChild(rockPrice)
        self.addChild(rockButton)
        
        basicTowerButton = SKSpriteNode(imageNamed: "Tower")
        basicTowerButton.position = CGPoint(x: 200, y: 200)
        basicTowerButton.zPosition = 100
        let basicPrice = SKLabelNode(fontNamed: "Chalkduster")
        basicPrice.text = "\(String(describing: TowerPrice[TowerType.Basic]!))"
        basicPrice.color = UIColor.black
        basicPrice.position = CGPoint(x: 200, y: 125)
        basicPrice.zPosition = 100
        self.addChild(basicPrice)
        self.addChild(basicTowerButton)
        
        waterTowerButton = SKSpriteNode(imageNamed: "Tower")
        waterTowerButton.position = CGPoint(x: 300, y: 200)
        waterTowerButton.zPosition = 100
        let waterPrice = SKLabelNode(fontNamed: "Chalkduster")
        waterPrice.text = "\(String(describing: TowerPrice[TowerType.Water]!))"
        waterPrice.color = UIColor.black
        waterPrice.position = CGPoint(x: 300, y: 125)
        waterPrice.zPosition = 100
        self.addChild(waterPrice)
        self.addChild(waterTowerButton)
        
        fireTowerButton = SKSpriteNode(imageNamed: "Tower")
        fireTowerButton.position = CGPoint(x: 400, y: 200)
        fireTowerButton.zPosition = 100
        let firePrice = SKLabelNode(fontNamed: "Chalkduster")
        firePrice.text = "\(String(describing: TowerPrice[TowerType.Fire]!))"
        firePrice.color = UIColor.black
        firePrice.position = CGPoint(x: 400, y: 125)
        firePrice.zPosition = 100
        self.addChild(firePrice)
        self.addChild(fireTowerButton)
        
        earthTowerButton = SKSpriteNode(imageNamed: "Tower")
        earthTowerButton.position = CGPoint(x: 500, y: 200)
        earthTowerButton.zPosition = 100
        let earthPrice = SKLabelNode(fontNamed: "Chalkduster")
        earthPrice.text = "\(String(describing: TowerPrice[TowerType.Earth]!))"
        earthPrice.color = UIColor.black
        earthPrice.position = CGPoint(x: 500, y: 125)
        earthPrice.zPosition = 100
        self.addChild(earthPrice)
        self.addChild(earthTowerButton)
        
        airTowerButton = SKSpriteNode(imageNamed: "Tower")
        airTowerButton.position = CGPoint(x: 600, y: 200)
        airTowerButton.zPosition = 100
        let airPrice = SKLabelNode(fontNamed: "Chalkduster")
        airPrice.text = "\(String(describing: TowerPrice[TowerType.Air]!))"
        airPrice.color = UIColor.black
        airPrice.position = CGPoint(x: 600, y: 125)
        airPrice.zPosition = 100
        self.addChild(airPrice)
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
                if(game.gold < TowerPrice[TowerType.Rock]!){
                    return
                }
                movableNode = createTower(type: TowerType.Rock)
                movableNode!.position = location
                nodeType = TowerType.Rock
            }
            
            if basicTowerButton.contains(location) {
                if(game.gold < TowerPrice[TowerType.Basic]!){
                    return
                }
                towerDrag = true
                movableNode = createTower(type: TowerType.Basic)
                movableNode!.position = location
                nodeType = TowerType.Basic
            }
            
            if waterTowerButton.contains(location) {
                if(game.gold < TowerPrice[TowerType.Water]!){
                    return
                }
                towerDrag = true
                movableNode = createTower(type: TowerType.Water)
                movableNode!.position = location
                nodeType = TowerType.Water
            }
            
            if fireTowerButton.contains(location) {
                if(game.gold < TowerPrice[TowerType.Fire]!){
                    return
                }
                towerDrag = true
                movableNode = createTower(type: TowerType.Fire)
                movableNode!.position = location
                nodeType = TowerType.Fire
            }
            
            if earthTowerButton.contains(location) {
                if(game.gold < TowerPrice[TowerType.Earth]!){
                    return
                }
                towerDrag = true
                movableNode = createTower(type: TowerType.Earth)
                movableNode!.position = location
                nodeType = TowerType.Earth
            }
            
            if airTowerButton.contains(location) {
                if(game.gold < TowerPrice[TowerType.Air]!){
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
                    towerCircle.position = CGPoint(x: closest.xPos +  (TowerWidth / 2) , y: closest.yPos +  (TowerHeight / 2))
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
            let towerPosition = CGPoint(x: closest!.xPos + (TowerWidth / 2), y: closest!.yPos + (TowerHeight / 2) )
            let snapSound = SKAction.playSoundFileNamed("snapSound.mp3", waitForCompletion: false)
            run(snapSound)
            
            movableNode!.position = towerPosition
            closest?.tower = movableNode as! BaseTower
            if(nodeType == TowerType.Water){
                print("water")
                game.gold -= TowerPrice[TowerType.Water]!
            }
            if(nodeType == TowerType.Earth){
                print("earth")
                game.gold -= TowerPrice[TowerType.Earth]!
            }
            if(nodeType == TowerType.Fire){
                print("fire")
                game.gold -= TowerPrice[TowerType.Fire]!
            }
            if(nodeType == TowerType.Air){
                print("air")
                game.gold -= TowerPrice[TowerType.Air]!
            }
            if(nodeType == TowerType.Rock){
                print("rock")
                game.gold -= TowerPrice[TowerType.Rock]!
            }
            if(nodeType == TowerType.Basic){
                print("basic")
                game.gold -= TowerPrice[TowerType.Basic]!
            }
            movableNode = nil
            viewController?.updateLabels()
            
            
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
