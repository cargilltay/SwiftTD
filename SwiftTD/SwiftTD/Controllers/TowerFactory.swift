//
//  TowerFactory.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 4/11/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import Foundation


enum TowerType:String {
    case Rock
    case Basic
    case Fire
    case Water
    case Earth
    case Air
}

let TowerPrice:[TowerType:Int] = [
    TowerType.Rock: 10,
    TowerType.Basic: 40,
    TowerType.Fire: 40,
    TowerType.Water: 50,
    TowerType.Earth: 40,
    TowerType.Air: 30
]

class TowerFactory {
    
    
    func createTower(type: TowerType) -> BaseTower {
        switch(type){
        case .Rock:
            return RockTower()
        case .Basic:
            return BasicTower()
        case .Fire:
            return FireTower()
        case .Water:
            return WaterTower()
        case .Earth:
            return EarthTower()
        case .Air:
            return AirTower()
        default:
            return BasicTower()
        }
    }
}
