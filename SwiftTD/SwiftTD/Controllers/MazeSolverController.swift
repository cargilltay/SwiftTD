//
//  MazeSolverController.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 2/28/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import Foundation

class MazeSolverController{
    var map: [[Int]]!
    var TRIED:Int = 2;
    var PATH:Int = 3;
    
    var grid: [[Int]]!
    var startRow: Int = 10
    var startCol: Int = 10
    var width: Int!
    var height: Int!
    
    init(tempGrid: Grid){
        //self.grid = grid
        //self.width = grid.rows
        //self.height = grid.cols
        
        
       //self.maze = generateMaze()
        self.grid = generateMaze(grid: tempGrid)
        /*
        self.grid = [
        [ 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1 ],
            [ 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1 ],
            [ 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0 ],
            [ 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1 ],
            [ 1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1 ],
            [ 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1 ],
            [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ],
            [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ]
        ]
         */
        self.height = tempGrid.cols
        self.width = tempGrid.rows
        self.map = Array(repeating: Array(repeating: 0, count: width), count: height)
    }
    
    
    func generateMaze(grid:Grid) -> [[Int]]{
        var m:[[Int]] = Array(repeating: Array(repeating: 0, count: grid.cols), count: grid.rows)
        for (index, _) in grid.cells.enumerated(){
            for col in grid.cells[index]{
                m[col.rowNum][col.colNum] = 1
                if (col.isBlocked){
                    m[col.rowNum][col.colNum] = 0
                }
            }
        }
        return m
        
    }
 
    
    
    func solve() -> Bool{
        return traverse(i: 0,j: 0);
    }
    
    func traverse(i: Int, j: Int) -> Bool {
        if (!isValid(i: i,j: j)) {
            return false
        }
        
        if ( isEnd(i: i, j: j) ) {
            map[i][j] = PATH
            return true
        } else {
            map[i][j] = TRIED
        }
        
        // North
        if (traverse(i: i - 1, j: j)) {
            map[i-1][j] = PATH
            return true
        }
        // East
        if (traverse(i: i, j: j + 1)) {
            map[i][j + 1] = PATH
            return true
        }
        // South
        if (traverse(i: i + 1, j: j)) {
            map[i + 1][j] = PATH
            return true
        }
        // West
        if (traverse(i: i, j: j - 1)) {
            map[i][j - 1] = PATH
            return true
        }
        
        return false
    }
    
    func isEnd(i:Int, j:Int) -> Bool{
        return i == height - 1 && j == width - 1
    }
    
    func isValid(i:Int, j:Int) -> Bool{
        if (inRange(i: i, j: j) && isOpen(i: i, j: j) && !isTried(i: i, j: j)) {
            return true
        }
        return false
    }
    
    func isOpen(i: Int, j:Int) -> Bool{
        return grid[i][j] == 1
    }
    
    func isTried(i:Int, j:Int) -> Bool{
        return map[i][j] == TRIED
    }
    
    func inRange(i:Int, j:Int) -> Bool{
        return inHeight(i: i) && inWidth(j: j)
    }
    
    func inHeight(i:Int) -> Bool{
        return i >= 0 && i < height
    }
    
    func inWidth(j:Int) -> Bool{
        return j >= 0 && j < width
    }
    
}
