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
    
    func beingHit(homeScene: GameScene)  {
        
        let red = SKAction.colorize(with: .red, colorBlendFactor: 1, duration: 0.1)
        let clear = SKAction.colorize(with: .red, colorBlendFactor: 0, duration: 0.1)
        let back = SKAction.moveBy(x: homeScene.player.facing.x*10, y: homeScene.player.facing.y*10, duration: 0.1)
        self.run(back)
        self.run(SKAction.sequence([red,clear]))
        
        self.health -= (homeScene.player.weapon.attackPoint + homeScene.player.baseAttackPoint)

        let sound = SKAction.playSoundFileNamed("logHurt.mp3", waitForCompletion: false)
        homeScene.run(sound)
    }
    
    func beingHit(homeScene: GameScene, damage: CGFloat)  {
        let red = SKAction.colorize(with: .red, colorBlendFactor: 1, duration: 0.1)
        let clear = SKAction.colorize(with: .red, colorBlendFactor: 0, duration: 0.1)
        let back = SKAction.moveBy(x: homeScene.player.facing.x*10, y: homeScene.player.facing.y*10, duration: 0.1)
        self.run(back)
        self.run(SKAction.sequence([red,clear]))
        
        self.health -= damage

        let sound = SKAction.playSoundFileNamed("logHurt.mp3", waitForCompletion: false)
        homeScene.run(sound)
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
