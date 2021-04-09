//
//  Monster.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/9.
//

import Foundation
import SpriteKit

enum MonsterType: Int{
    case log
    case slime
    case ghost
    
    static func random() -> MonsterType{
        return MonsterType(rawValue: Int.random(in: 0..<3))!
    }
}

class Monster: SKSpriteNode {
    private var _sinceStart: TimeInterval!
    var sinceStart: TimeInterval!
    var isAlived = true
    
    func beingHit()  {
        
    }
    
}


func fromType(type: MonsterType, homeScene: GameScene) -> Monster {
    
    var monster: Monster!
    
    switch type {
    case .log:
        monster = Log(scene: homeScene)
    case .slime:
        monster = Slime(scene: homeScene)
    case .ghost:
        monster = Ghost(scene: homeScene)
        
    }
    
    return monster
}
