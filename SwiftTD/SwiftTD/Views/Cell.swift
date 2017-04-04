//
//  Cell.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 3/31/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import UIKit
import SpriteKit

class Cell: SKSpriteNode {
    var xPos: CGFloat!
    var yPos: CGFloat!
    var cSize: CGFloat!
    var rowNum: Int!
    var colNum: Int!
    
    var isBlocked: Bool = false
    
    convenience init(x: CGFloat, y: CGFloat){
        self.init()
        self.xPos = x
        self.yPos = y
    }
    
    convenience init(x: CGFloat, y: CGFloat, size: CGFloat, row: Int, col: Int){
        self.init()
        
        self.cSize = size
        self.xPos = x
        self.yPos = y
        self.rowNum = row
        self.colNum = col
    }
}
