//
//  GameTopPanelController.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 4/14/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import UIKit

class GameTopPanelController: UIViewController {
    @IBOutlet weak var goldLabel: SwiftTDLabel!

    @IBOutlet weak var livesLabel: SwiftTDLabel!

    @IBOutlet weak var levelLabel: SwiftTDLabel!
    @IBOutlet weak var typeLabel: SwiftTDLabel!

    @IBOutlet weak var scoreLabel: SwiftTDLabel!
    @IBOutlet weak var damageLabel: SwiftTDLabel!
    @IBOutlet weak var killsLabel: SwiftTDLabel!
    @IBOutlet weak var effectLabel: SwiftTDLabel!
    @IBOutlet weak var deleteButton: SwiftTDButton!
    @IBOutlet weak var deleteTower: SwiftTDButton!
    
    var towerToDelete: BaseTower!
    var towerIndex: Int!
    var gameController: GameController!
    var viewController: GameViewController!
    
    func setDeleteTower(tower: BaseTower, gameController: GameController, viewController: GameViewController){
        self.towerToDelete = tower
        self.gameController = gameController
        self.viewController = viewController
    }
    @IBAction func deleteTower(_ sender: Any) {
        
        let closest = viewController.scene.grid!.closestCell(x: towerToDelete.position.x, y: towerToDelete.position.y)
        
        closest.isBlocked = false
        closest.hasTower = false
        
        for (index,tower) in viewController.scene.game.towers.enumerated().reversed(){
            let tClosest = viewController.scene.grid!.closestCell(x: tower.position.x, y: tower.position.y)
            if(tClosest.xPos == closest.xPos && tClosest.yPos == closest.yPos){
                viewController.scene.game.towers.remove(at: index)
            }
        }
        
        viewController.hidePanel()
        
        viewController.scene.towerCircle.removeFromParent()
        viewController.scene.towerCircle = nil
        towerToDelete.removeFromParent()
        towerToDelete = nil
    }
}
