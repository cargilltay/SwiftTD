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
        //print("count: \(count)")
        if(tempSolution[row][col] == 2){
            cells.append(grid.cells[tempSolution.count - 1][0])
            count -= 1
        
        while (count != 0) {
                tempSolution[row][col] = 0
                //North
                if(row != 0 && tempSolution[row-1][col] != 0){
                    row -= 1
                }//South
                else if(row+1 != tempSolution.count && tempSolution[row+1][col] != 0){
                    row += 1
                }//West
                else if(col != 0 && tempSolution[row][col-1] != 0){
                col -= 1
                }//East
                else if(col+1 != tempSolution[row].count && tempSolution[row][col+1] != 0){
                    col += 1
                }
                cells.append(grid.cells[tempSolution.count - 1 - row][col])
                count -= 1
            }
        }
        /*
                    if(solution[row][col] != 0){
                        print("\(solution.count - row - 1) and \(col)")
                        
                        cells.append(grid.cells[solution.count - row - 1][col])
                    }*/
        
        self.solution = cells
    }
    
    func setMinionStartAndEndLocation(start: CGPoint, end: CGPoint){
        minionStartPosition = start
        minionEndLocation = end
    }
    
    func populateMinions(){
        //going to have to send monsters their stats dynamically eventually.
        
        
        //func convertDestination(destinations: [[Int]]) -> [Cell]{
        
            
            //return cells
        //}
        
        for _ in 1...self.numMonsters {
            let m = BaseMonster(startLocation: self.minionStartPosition, endLocation: self.minionEndLocation, pathSolution: solution, damage: 2, hitPoints: 2, gold: 10, texture: SKTexture(imageNamed: "Monster"), color: UIColor.blue)
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
