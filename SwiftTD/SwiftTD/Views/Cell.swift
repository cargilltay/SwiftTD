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
    var xPosWithOffset: CGFloat!
    var yPosWithOffset: CGFloat!
    var cSize: CGFloat!
    
    var isBlocked: Bool = false
    
    
    
    convenience init(x: CGFloat, y: CGFloat, size: CGFloat){
        self.init()
        
        self.cSize = size
        
        self.xPos = x
        self.yPos = y
        self.xPosWithOffset = x + size
        self.yPosWithOffset = y + size
    }
    
    
}
