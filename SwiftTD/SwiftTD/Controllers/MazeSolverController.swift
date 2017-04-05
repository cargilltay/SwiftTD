//
//  MazeSolverController.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 2/28/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import Foundation

class MazeSolverController{
    var maze: [[Int]]!
    var grid: Grid
    var wasHere: [[Bool]]!
    var correctPath: [[Bool]]!
    var startX: Int = 9
    var startY: Int = 5
    var endX: Int = 0
    var endY: Int = 5
    var width: Int!
    var height: Int!
    
    init(grid: Grid){
        self.grid = grid
        self.width = grid.rows
        self.height = grid.cols
        
        self.wasHere = Array(repeating: Array(repeating: false, count: grid.cols), count: grid.rows)
        self.correctPath = Array(repeating: Array(repeating: false, count: grid.cols), count: grid.rows)
        
    }
    
    func generateMaze() -> [[Int]]{
        var m:[[Int]] = Array(repeating: Array(repeating: 0, count: grid.cols), count: grid.rows)
        for (index, _) in grid.cells.enumerated(){
            for col in grid.cells[index]{
                m[col.rowNum][col.colNum] = 1
                if (col.isBlocked){
                    m[col.rowNum][col.colNum] = 2
                }
            }
        }
        return m
        
    }
    
    func solveMaze() -> [Cell]{
        maze = generateMaze(); // Create Maze (1 = path, 2 = wall)
        for row in 0...maze.count - 1{
            // Sets boolean Arrays to default values
            for col in 0...maze[row].count - 1{
                wasHere[row][col] = false;
                correctPath[row][col] = false;
            }
        }
        let b = recursiveSolve(x: startX, y: startY);
        print("MAZE")
        print(maze)
        print("----------------")
        print("wasHere")
        print(wasHere)
        print("----------------")
        print("correctPath")
        print(correctPath)
        print("----------------")
        print("b")
        print(b)
        // Will leave you with a boolean array (correctPath)
        // with the path indicated by true values.
        // If b is false, there is no solution to the maze
        
        
        var path: [Cell] = []
        
        
        //this is nasty but it works for now
        for row in 0...correctPath.count - 1 {
            for col in 0...correctPath[row].count - 1{
                if(correctPath[row][col] == true){
                    for (index, _) in grid.cells.enumerated(){
                        for c in grid.cells[index]{
                            if(c.rowNum == row && c.colNum == col){
                                path.append(c)
                            }
                        }
                    }
                }
            }
        }
        
        path.reverse()
        return path
    }
    
    func recursiveSolve(x: Int, y: Int) -> Bool{
        print(x)
        if (x == endX && y == endY) {
            return true; // If you reached the end
        }
        
        if (maze[x][y] == 2 || wasHere[x][y]){
            return false;
        }
        // If you are on a wall or already were here
        wasHere[x][y] = true;
        if (x != 0) {// Checks if not on left edge
            if (recursiveSolve(x: x-1, y: y)) { // Recalls method one to the left
                correctPath[x][y] = true; // Sets that path value to true;
                return true;
            }
        }
        if (x != width){ // Checks if not on right edge
            if (recursiveSolve(x: x+1, y: y)) { // Recalls method one to the right
                correctPath[x][y] = true;
                return true;
            }
        }
        if (y != 0){ // Checks if not on top edge
            if (recursiveSolve(x: x, y: y-1)) { // Recalls method one up
                correctPath[x][y] = true;
                return true;
            }
        }
        if (y != height){ // Checks if not on bottom edge
            if (recursiveSolve(x: x, y: y+1)) { // Recalls method one down
                correctPath[x][y] = true;
                return true;
            }
        }
        return false;
    }
    
}
