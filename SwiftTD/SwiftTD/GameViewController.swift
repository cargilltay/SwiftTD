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
            //scene.scaleMode = .aspectFill
            scene.scaleMode = SKSceneScaleMode.aspectFit
            scene.anchorPoint = CGPoint(x: 0.0,y: 0.0)
            //scene.scaleMode = SKSceneScaleMode.resizeFill
            
            // Present the scene
            view.presentScene(scene)
            
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    @IBAction func beginRoundClick(_ sender: Any) {
        
        //need to turn this button off while round in progress
        scene.game.numMonsters = 10
        scene.game.populateMinions()
        scene.drawMonsters()
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
