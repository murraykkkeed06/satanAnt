//
//  Collection.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/15.
//

import Foundation
import SpriteKit


enum PowerType: Int {
    case flyingBird
    case halfMonster
    case healthGainer
    static func random() -> PowerType{
        return PowerType(rawValue: Int.random(in: 0..<3))!
    }
}

class Power: SKSpriteNode {
    var type: PowerType!
    var sinceStart: TimeInterval!
    var homeScene: GameScene!
    var start: Bool!
    var useNumber: Int!
    
}

func fromType(type: PowerType) -> Power {
    
    var power: Power!
    switch type {
    case .flyingBird:
        power = FlyingBird()
    case .halfMonster:
        power = HalfMonster()
    case .healthGainer:
        power = HealthGainer()
    }
    
    return power
}

