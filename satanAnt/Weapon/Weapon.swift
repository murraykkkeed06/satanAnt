//
//  Weapon.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/3/27.
//

import Foundation
import SpriteKit
import AVFoundation

enum WeaponType: Int {
    case staff
    case candyBar
    
    static func random() -> WeaponType{
        return WeaponType(rawValue: 0)!
    }
}


class Weapon: SKSpriteNode {
    
    var attackPoint: CGFloat!
    var attackSpeed: TimeInterval!
    var weaponType: WeaponType!
    var tempTime: TimeInterval!
    
    
    
    func rAttack(direction: CGPoint, homeScene: GameScene){
        
    }
    
    
    func attack(direction: CGPoint, homeScene: GameScene){
 
    }
    
    func reset(){}
    
    
    
    func attack(degree: CGFloat, homeScene: GameScene){
        
        
    }
    
}

func fromType(type: WeaponType) -> Weapon {
    
    var weapon: Weapon!
    
    switch type {
    case .staff:
        weapon = Staff()
    case .candyBar:
        weapon = CandyBar()
    }
    
    return weapon
}

func fromTypeTexture(type: WeaponType) -> SKNode{
    
    var result: SKNode!
    
    switch type {
    case .staff:
        let texture = SKTexture(imageNamed: "staff")
        result = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 40, height: 24))
    case .candyBar:
        let texture = SKTexture(imageNamed: "candyBar")
        result = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 40, height: 24))
        
    }
    
    result.zPosition = 10
    return result
}


