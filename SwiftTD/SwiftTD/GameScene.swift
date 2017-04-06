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
    
    var rockButton: SKSpriteNode!
    var background: SKSpriteNode!
    var movableNode : SKNode?
    var grid: Grid?
    
    override func didMove(to: SKView) {
        setupUI()
        
        drawGrid()
    }
    
    func setupUI(){
        screenWidth = screenSize.width * 2
        screenHeight = screenSize.height * 2
        
        rockButton = SKSpriteNode(imageNamed: "Rock")
        rockButton.position = CGPoint(x: 150, y: 200)
        rockButton.zPosition = 100
        rockButton.zPosition = 3
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
        //rock.position = CGPoint(x: 300, y: 300)
        rock.zPosition = 100
        self.addChild(rock)
        
        return rock
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
