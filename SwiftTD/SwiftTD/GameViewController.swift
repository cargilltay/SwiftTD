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
    
    @IBOutlet weak var beginButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    var scene: GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            scene = GameScene(fileNamed: "GameScene")
            
            // Set the scale mode to scale to fit the window
            scene.scaleMode = SKSceneScaleMode.aspectFit
            scene.anchorPoint = CGPoint(x: 0.0,y: 0.0)
            
            // Present the scene
            view.presentScene(scene)
            
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    @IBAction func beginRoundClick(_ sender: Any) {
        
        //need to turn this button off while round in progress
        
        //test grid blocking
        /*
         scene.grid?.cells[0].isBlocked = true
         scene.grid?.cells[1].isBlocked = true
         scene.grid?.cells[2].isBlocked = true
         scene.grid?.cells[3].isBlocked = true
         scene.grid?.cells[4].isBlocked = true
         scene.grid?.cells[5].isBlocked = true
         scene.grid?.cells[6].isBlocked = true
         scene.grid?.cells[7].isBlocked = true
         */
        
        let solver = MazeSolverController(grid: scene.grid!)
        scene.game.setSolution(solution: solver.solveMaze())
        //test empty
        //scene.game.setSolution(solution: [])
        
        //this is not an ideal way to do this.
        let startLocation = CGPoint(x: scene.screenWidth! / 2, y: scene.screenHeight!)
        let endLocation = CGPoint(x: scene.screenWidth! / 2, y: 0)
        scene.game.setMinionStartAndEndLocation(start: startLocation, end: endLocation)
        
        scene.game.nextMode()
        
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
    
    
}
