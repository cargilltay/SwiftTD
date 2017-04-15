//
//  GameViewController.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 2/24/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var topPanel: UIView!
    @IBOutlet weak var beginButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    var scene: GameScene!
    var gameDifficulty: GameDifficulty!
    var panelController: GameTopPanelController?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            scene = GameScene(fileNamed: "GameScene")
            scene.game.difficulty = self.gameDifficulty
            scene.viewController = self
            
            // Set the scale mode to scale to fit the window
            scene.scaleMode = SKSceneScaleMode.aspectFit
            scene.anchorPoint = CGPoint(x: 0.0,y: 0.0)
            
            // Present the scene
            view.presentScene(scene)
            
            
            view.ignoresSiblingOrder = true
            view.isUserInteractionEnabled = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            
            /*
            level.text = "Level: \(scene.game.round)"
            level.sizeToFit()
            gold.text = "Gold: \(scene.game.gold)"
            gold.sizeToFit()
            lives.text = "Lives: \(scene.game.lives)"
            lives.sizeToFit()
            */
        }
    }
    @IBAction func beginRoundClick(_ sender: Any) {
        
        //need to turn this button off while round in progress
        
        let solver = MazeSolverController(tempGrid: scene.grid!)
        let solution: Bool = solver.solve()
        print("Solved: \(solution)")
        print(solver.map)
        
        scene.game.setSolution(solution: solver.map, grid: scene.grid!)
        
        //test empty
        //scene.game.setSolution(solution: [])
        
        //this is not an ideal way to do this.
        let startLocation = CGPoint(x: scene.screenWidth! / 2, y: scene.screenHeight!)
        let endLocation = CGPoint(x: scene.screenWidth! / 2, y: 0)
        scene.game.setMinionStartAndEndLocation(start: startLocation, end: endLocation)
        scene.game.nextMode()
        
        
        panelController?.levelLabel.text = "Level: \(scene.game.round)"
        panelController?.levelLabel.sizeToFit()
        panelController?.goldLabel.text = "Gold: \(scene.game.gold)"
        panelController?.goldLabel.sizeToFit()
        panelController?.livesLabel.text = "Lives: \(scene.game.lives)"
        panelController?.livesLabel.sizeToFit()

    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TopPanelSegue" {
            panelController = segue.destination as? GameTopPanelController
            //panelController!.parent = self
        }
    }
    
    func showPanel(tower: BaseTower, yPos: CGFloat){
        panelController?.typeLabel.text = "Type: \(tower.type.rawValue)"
        panelController?.typeLabel.sizeToFit()
        panelController?.damageLabel.text = "Damage: \(tower.damage)"
        panelController?.damageLabel.sizeToFit()
        panelController?.killsLabel.text = "Kills:: \(tower.kills)"
        panelController?.killsLabel.sizeToFit()
        panelController?.effectLabel.text = "Effect: \(tower.effectText!)"
        panelController?.effectLabel.sizeToFit()
        
        UIView.animate(withDuration: 1.0) {
            self.topPanel.frame.origin.y = 40
            //self.topPanel.frame.origin.y = yPos
        }
    }
    
    func hidePanel(){
        UIView.animate(withDuration: 1.0) {
            self.topPanel.frame.origin.y = -150
            //self.topPanel.frame.origin.y = yPos
        }
    }
    
}

extension GameViewController: DifficultyDelegate {
    func updateDifficulty(difficulty:GameDifficulty) {
        self.gameDifficulty = difficulty
    }
    
}
