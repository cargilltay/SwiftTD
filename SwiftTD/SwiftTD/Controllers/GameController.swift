//
//  GameController.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 3/27/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import Foundation
import SpriteKit


enum GameMode {
    case PlayerTurn
    case Defend
    case Boss
}

class GameController {
    var lives: Int = 100
    var gold: Int = 0
    var score: Int = 0
    var numMonsters: Int = 10
    var round: Int = 1
    var monsters: [BaseMonster] = []
    var towers: [BaseTower] = []
    var mode = GameMode.PlayerTurn
    var solution: [Cell]!
    var minionStartPosition: CGPoint!
    var minionEndLocation: CGPoint!
    var statController: MonsterStatController = MonsterStatController()
    
    var time: Date = Date()
    //var difficulty
    
    func setSolution(solution: [Cell]){
        self.solution = solution
    }
    
    func setMinionStartAndEndLocation(start: CGPoint, end: CGPoint){
        minionStartPosition = start
        minionEndLocation = end
    }
    
    func populateMinions(){
        //going to have to send monsters their stats dynamically eventually.
        for _ in 1...self.numMonsters {
            let m = BaseMonster(startLocation: self.minionStartPosition, endLocation: self.minionEndLocation, pathSolution: solution, damage: 2, hitPoints: 2, texture: SKTexture(imageNamed: "Monster"), color: UIColor.blue)
            self.monsters.append(m)
        }
    }
    
    func nextMode() {
        //is players turn
        if (self.mode != GameMode.PlayerTurn) {
            self.mode = GameMode.PlayerTurn
            
            //enable tower placement
            //$('#new-gem').removeAttr('disabled');
            
            //self.numTowerToPlace = 5;
        } else {
            self.mode = GameMode.Defend
            self.populateMinions();
            
            //disable tower placement
            //$('#new-gem').attr("disabled", "disabled");
        }
    }
    
    func nextRound(){
        self.round += 1
    }
}
