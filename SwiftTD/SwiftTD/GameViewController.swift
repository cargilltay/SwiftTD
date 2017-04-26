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


protocol GameScoreDelegate {
    func acceptGameScore(score: Int)
}


class GameViewController: UIViewController {
    
    @IBOutlet weak var BlockedPanel: UIView!
    @IBOutlet weak var topPanel: UIView!
    @IBOutlet weak var beginButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    var scene: GameScene!
    var gameDifficulty: GameDifficulty!
    var panelController: GameTopPanelController?
    var delegate:GameScoreDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            scene = GameScene(fileNamed: "GameScene")
            scene.game.difficulty = self.gameDifficulty
            if(gameDifficulty == GameDifficulty.Easy){
                scene.game.difficultyModifier = 1
            }
            else if(gameDifficulty == GameDifficulty.Medium){
                scene.game.difficultyModifier = 2
            }
            else{
                scene.game.difficultyModifier = 3
            }

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
            updateLabels()
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
        
        if(scene.game.mode == GameMode.Defend){
            return
        }
        
        let solver = MazeSolverController(tempGrid: scene.grid!)
        let solution: Bool = solver.solve()
        print("Solved: \(solution)")
        if(solution){
            hideBlockedPanel()
            print(solver.map)
        
            scene.game.setSolution(solution: solver.map, grid: scene.grid!)
        
            //test empty
            //scene.game.setSolution(solution: [])
        
            //this is not an ideal way to do this.
            let startLocation = CGPoint(x: 0, y: scene.screenHeight! * 0.75)
            let endLocation = CGPoint(x: scene.screenWidth! * 0.9, y: scene.screenHeight! * 0.185)
            scene.game.setMinionStartAndEndLocation(start: startLocation, end: endLocation)
            scene.game.nextMode()
            updateLabels()
        }
        else{
            showBlockedPanel()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? GameOverModal{
            self.delegate = dest
            self.delegate?.acceptGameScore(score: self.scene.game.score)
        }
        
        if segue.identifier == "TopPanelSegue" {
            panelController = segue.destination as? GameTopPanelController
            //panelController!.parent = self
        }
    }
    
    override var shouldAutorotate: Bool {
        return false
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
  
    
    func updateLabels(){
        panelController?.levelLabel.text = "Level: \(scene.game.round)"
        panelController?.levelLabel.sizeToFit()
        panelController?.goldLabel.text = "Gold: \(scene.game.gold)"
        panelController?.goldLabel.sizeToFit()
        panelController?.livesLabel.text = "Lives: \(scene.game.lives)"
        panelController?.livesLabel.sizeToFit()
        panelController?.scoreLabel.text = "Score: \(scene.game.score)"
        panelController?.scoreLabel.sizeToFit()

    }
    
    func showPanel(tower: BaseTower, yPos: CGFloat){
        panelController?.typeLabel.text = "Type: \(tower.type.rawValue)"
        panelController?.typeLabel.sizeToFit()
        panelController?.damageLabel.text = "Damage: \(tower.damage!)"
        panelController?.damageLabel.sizeToFit()
        panelController?.killsLabel.text = "Kills:: \(tower.kills)"
        panelController?.killsLabel.sizeToFit()
        panelController?.effectLabel.numberOfLines = 0
        panelController?.effectLabel.text = "Effect: \(tower.effectText!)"
        panelController?.effectLabel.sizeToFit()
        
        panelController?.setDeleteTower(tower: tower, gameController: scene.game, viewController: self)
        
        UIView.animate(withDuration: 1.0) {
            self.topPanel.frame.origin.y = 40
            //self.topPanel.frame.origin.y = yPos
        }
    }
    
    func showBlockedPanel(){
        UIView.animate(withDuration: 1.0) {
            self.BlockedPanel.frame.origin.y = 40
            //self.topPanel.frame.origin.y = yPos
        }

    }
    func hideBlockedPanel(){
        UIView.animate(withDuration: 1.0) {
            self.BlockedPanel.frame.origin.y = -250
            //self.topPanel.frame.origin.y = yPos
        }
    }

    
    func hidePanel(){
        UIView.animate(withDuration: 1.0) {
            self.topPanel.frame.origin.y = -120
            //self.topPanel.frame.origin.y = yPos
        }
    }
    
}

extension GameViewController: DifficultyDelegate {
    func updateDifficulty(difficulty:GameDifficulty) {
        self.gameDifficulty = difficulty
    }
    
}
