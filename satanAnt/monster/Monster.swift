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
    var sinceStart: TimeInterval!
    var isAlived = true
    var health: CGFloat!
    let hurtAction = SKAction.sequence([SKAction.colorize(with: .red, colorBlendFactor: 1, duration: 0.1),SKAction.colorize(with: .red, colorBlendFactor: 0, duration: 0.1)])
    
    func beingHit(homeScene: GameScene)  {
        
//        let red = SKAction.colorize(with: .red, colorBlendFactor: 1, duration: 0.1)
//        let clear = SKAction.colorize(with: .red, colorBlendFactor: 0, duration: 0.1)
        let vec = self.position - homeScene.player.position
        let back = SKAction.moveBy(x: vec.normalized().x*10, y: vec.normalized().y*10, duration: 0.1)
        self.run(back)
        self.run(hurtAction)
        
        self.health -= (homeScene.player.weapon.attackPoint + homeScene.player.baseAttackPoint)

      
        homeScene.run(homeScene.logHurtSound)
        
        
    }
    
    func beingHit(homeScene: GameScene, damage: CGFloat)  {
//        let red = SKAction.colorize(with: .red, colorBlendFactor: 1, duration: 0.1)
//        let clear = SKAction.colorize(with: .red, colorBlendFactor: 0, duration: 0.1)
        let vec = self.position - homeScene.player.position
        let back = SKAction.moveBy(x: vec.normalized().x*10, y: vec.normalized().y*10, duration: 0.1)
        self.run(back)
        self.run(hurtAction)
        
        self.health -= damage

       
        homeScene.run(homeScene.logHurtSound)
    }
    
}


func fromType(type: MonsterType, homeScene: GameScene) -> Monster {
    
    var monster: Monster!
    
    switch type {
    case .log:
        monster = Log(scene: homeScene)
    case .slime:
        monster = Slime(scene: homeScene, color: SlimeColor.green)
    case .ghost:
        monster = Ghost(scene: homeScene)
        
    }
    
    return monster
}
