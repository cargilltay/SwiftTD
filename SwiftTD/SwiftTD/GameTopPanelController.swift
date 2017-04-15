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
        
        //sommehow need to pop it from game.towers array too
        viewController.hidePanel()
        
        viewController.scene.towerCircle.removeFromParent()
        viewController.scene.towerCircle = nil
        towerToDelete.removeFromParent()
        towerToDelete = nil
    }
}
