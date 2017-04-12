//
//  TowerFactory.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 4/11/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import Foundation


enum TowerType {
    case Rock
    case Basic
    case Fire
    case Water
    case Earth
    case Air
}

class TowerFactory {
    
    
    func createTower(type: TowerType) -> BaseTower {
        switch(type){
        case .Rock:
            return RockTower()
        case .Basic:
            return BasicTower()
        default:
            return BasicTower()
        }
    }
}
