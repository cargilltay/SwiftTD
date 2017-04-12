//
//  ProjectileFactory.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 4/12/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import Foundation

class ProjectileFactory {
    
    func createProjectile(tower: BaseTower, target:BaseMonster) -> BaseProjectile {
        switch(tower.type!){
        case .Rock:
            return RockProjectile(damage: tower.damage, position: tower.position, target: target)
        case .Basic:
            return BasicProjectile(damage: tower.damage, position: tower.position, target: target)
        case .Fire:
            return FireProjectile(damage: tower.damage, position: tower.position, target: target)
        case .Water:
            return WaterProjectile(damage: tower.damage, position: tower.position, target: target)
        case .Earth:
            return EarthProjectile(damage: tower.damage, position: tower.position, target: target)
        case .Air:
            return AirProjectile(damage: tower.damage, position: tower.position, target: target)
        default:
            return BasicProjectile(damage: tower.damage, position: tower.position, target: target)
        }
    }
}
