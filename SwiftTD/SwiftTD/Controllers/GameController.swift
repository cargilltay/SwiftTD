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
    var lives: Int = 20
    var gold: Int = 200
    var score: Int = 0
    var numMonsters: Int = 4
    var numSpawnedMinions:Int = 0
    var monsterHealth: Int = 200
    var round: Int = 0
    var monsters: [BaseMonster] = []
    var towers: [BaseTower] = []
    var mode = GameMode.PlayerTurn
    var solution: [Cell]!
    var minionStartPosition: CGPoint!
    var minionEndLocation: CGPoint!
    var statController: MonsterStatController = MonsterStatController()
    var difficulty: GameDifficulty!
    var difficultyModifier: Int! = 1
    var spawnTimer : Timer?
    
    var time: Date = Date()
    
    func setSolution(solution: [[Int]], grid: Grid){
        var cells: [Cell] = []
        var tempSolution: [[Int]] = solution
        var count: Int = 0
        var row: Int = 0
        var col: Int = 0
        for row in 0...solution.count - 1{
            for col in 0...solution[row].count-1{
                if(solution[row][col] != 0){
                    count += 1
                    }
            }
        }
        if(tempSolution[row][col] == 2){
            cells.append(grid.cells[tempSolution.count - 1][0])
            count -= 1
        
        while (count != 0) {
                tempSolution[row][col] = 0
                //North
                if(row != 0 && tempSolution[row-1][col] == 3){
                    row -= 1
                }//South
                else if(row+1 != tempSolution.count && tempSolution[row+1][col] == 3){
                    row += 1
                }//West
                else if(col != 0 && tempSolution[row][col-1] == 3){
                col -= 1
                }//East
                else if(col+1 != tempSolution[row].count && tempSolution[row][col+1] == 3){
                    col += 1
                }
                cells.append(grid.cells[tempSolution.count - 1 - row][col])
                count -= 1
            }
        }
        
        self.solution = cells
    }
    
    func setMinionStartAndEndLocation(start: CGPoint, end: CGPoint){
        minionStartPosition = start
        minionEndLocation = end
    }
    
    func populateMinions(){
        //going to have to send monsters their stats dynamically eventually.

        for _ in 1...self.numMonsters {
            if spawnTimer == nil {
                spawnTimer =  Timer.scheduledTimer(
                    timeInterval: TimeInterval(0.5), //set this based on fireRate
                    target      : self,
                    selector    : #selector(addMonster),
                    userInfo    : nil,
                    repeats     : true)
            }
            
            
        }
    }
    
    @objc func addMonster(){
        let m = BaseMonster(startLocation: self.minionStartPosition, endLocation: self.minionEndLocation, pathSolution: solution, damage: 2, hitPoints: monsterHealth, gold: 10, texture: SKTexture(imageNamed: "Monster"), color: UIColor.blue)
        self.monsters.append(m)
        numSpawnedMinions += 1
        
        if(numSpawnedMinions == numMonsters){
            stopTimer()
            numSpawnedMinions = 0
        }
    }
    
    func stopTimer() {
        if spawnTimer != nil {
            spawnTimer?.invalidate()
            spawnTimer = nil
        }
    }
    
    func nextMode() {
        //is players turn
        if (self.mode != GameMode.PlayerTurn) {
            self.mode = GameMode.PlayerTurn
        } else {
            self.mode = GameMode.Defend
            self.nextRound()
            
            self.populateMinions();
        }
    }
    
    func nextRound(){
        self.numMonsters += 1
        self.round += 1
        self.monsterHealth += ((self.round / 3) * 40) * difficultyModifier
        print("MonsterHealth = \(self.monsterHealth)")
        
    }
}
