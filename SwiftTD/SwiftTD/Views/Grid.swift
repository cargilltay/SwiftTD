//
//  Grid.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 2/28/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import UIKit
import SpriteKit

class Grid:SKSpriteNode {
    var rows:Int!
    var cols:Int!
    var blockSize:CGFloat!
    var cells:[[Cell]]!
    var baseOffset:CGFloat!
    
    convenience init?(blockSize:CGFloat,rows:Int,cols:Int, baseOffset: CGFloat) {
        self.init()
        
        self.baseOffset = baseOffset
        
        self.cells = Array(repeating: Array(repeating: Cell(), count: cols), count: rows)
        let texture = gridTexture(blockSize: blockSize,rows: rows, cols:cols)
        self.texture = texture
        self.size = texture!.size()
        self.color = SKColor.clear
        self.blockSize = blockSize
        self.rows = rows
        self.cols = cols
        self.isUserInteractionEnabled = false
        
        
        
    }
    
    func gridTexture(blockSize:CGFloat,rows:Int,cols:Int) -> SKTexture? {
        // Add 1 to the height and width to ensure the borders are within the sprite
        let size = CGSize(width: CGFloat(cols)*blockSize+1.0, height: CGFloat(rows)*blockSize+1.0)
        UIGraphicsBeginImageContext(size)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        let bezierPath = UIBezierPath()
        let offset:CGFloat = 0.5
        
        var xPositions:[CGFloat] = []
        var yPositions:[CGFloat] = []
        
        // Draw vertical lines
        for i in 0...cols {
            let x = CGFloat(i)*blockSize + offset
            xPositions.append(x - offset)
            bezierPath.move(to: CGPoint(x: x, y: 0))
            bezierPath.addLine(to: CGPoint(x: x, y: size.height))
        }
        
        // Draw horizontal lines
        for i in 0...rows {
            let y = CGFloat(i)*blockSize + offset
            yPositions.append(y - offset + self.baseOffset)
            bezierPath.move(to: CGPoint(x: 0, y: y))
            bezierPath.addLine(to: CGPoint(x: size.width, y: y))
        }
        
        for i in 0...rows - 1{
            for j in 0...cols - 1{
                //swapped i and j to make grid like so:
                //row 2
                //row 1
                //row 0
                self.cells[i][j] = Cell(x: xPositions[j], y: yPositions[i], size: blockSize, row: i, col: j)
            }
        }
        
        SKColor.white.setStroke()
        bezierPath.lineWidth = 1.0
        bezierPath.stroke()
        context.addPath(bezierPath.cgPath)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return SKTexture(image: image!)
    }
    
    func closestCell(x: CGFloat, y:CGFloat) -> Cell{
        var cell: Cell!
        
        for (index, _) in self.cells.enumerated(){
            for c in self.cells[index]{
                let modx = x - (x.truncatingRemainder(dividingBy: c.cSize));
                
                let baseOffsetMod = baseOffset.truncatingRemainder(dividingBy: c.cSize)
                let mody = y - ((y - baseOffsetMod).truncatingRemainder(dividingBy: c.cSize));
                
                //print("x:\(c.xPos)" + "y:\(c.yPos)")
                if (c.xPos == modx && c.yPos == mody) {
                    cell = c;
                    
                    break
                }
            }
        }
        print("Daniel \(cell.xPos), \(cell.yPos)")
        return cell
    }
    
    func gridPosition(row:Int, col:Int) -> CGPoint {
        let offset = blockSize / 2.0 + 0.5
        let x = CGFloat(col) * blockSize - (blockSize * CGFloat(cols)) / 2.0 + offset
        let y = CGFloat(rows - row - 1) * blockSize - (blockSize * CGFloat(rows)) / 2.0 + offset
        return CGPoint(x:x, y:y)
    }
}
