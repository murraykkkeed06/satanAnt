//
//  Sword.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/10.
//

import Foundation
import SpriteKit

class Sword: Weapon {
    
    var homeScene: GameScene!
    
    init(){
        
        
        let texture = SKTexture(imageNamed: "sword")
        super.init(texture: texture, color: .clear, size: CGSize(width: 40, height: 24))
        self.name = "sword"
        self.zPosition = 1
        self.attackPoint = 0.25
        self.attackSpeed = 0.3
        self.weaponType = .sword
        
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func rAttack(direction: CGPoint, homeScene: GameScene) {
        let last  = SKAction.move(to: CGPoint(x: 10, y: -8), duration: 0.01)
        
        var flyList = [SKAction]()
        
        for monster in homeScene.monsterList{
            if monster.isAlived{
                let position = homeScene.convert(monster.position, to: homeScene.player)
                let fly = SKAction.move(to:position, duration: 0.01)
                flyList.append(fly)
                monster.beingHit(homeScene: homeScene)
                homeScene.run(SKAction.playSoundFileNamed("wind.wav", waitForCompletion: false))
            }
        }
        
        flyList.append(last)
        
        self.run(SKAction.sequence(flyList))
        
        
    }
    
    
    
    override func attack(direction: CGPoint, homeScene: GameScene) {
        
       
        
        if homeScene.player.sinceFire < 0.3 {return}
        homeScene.player.sinceFire = 0
        
        let originPos = CGPoint(x: 10, y: -8)
        let range = 10 + homeScene.player.baseBulletRangePoint * 5
        let speed = homeScene.player.baseBulletSpeed + attackSpeed
        let goOut = SKAction.moveBy(x: homeScene.player.facing.x * range , y: homeScene.player.facing.y * range, duration: speed/2)
        goOut.timingMode = .easeIn
        let goIn = SKAction.move(to: originPos, duration: speed/2)
        goIn.timingMode = .easeOut
        self.run(SKAction.sequence([goOut,goIn]))
        homeScene.run(SKAction.playSoundFileNamed("swordHit.wav", waitForCompletion: false))
        
        if let bornPoint = homeScene.weaponOnHand.childNode(withName: "bornPoint"){
            let position = homeScene.weaponOnHand.convert(bornPoint.position, to: homeScene)
            
            for monster in homeScene.monsterList{
                if monster.position.distanceTo(position) < 35{
                    monster.beingHit(homeScene: homeScene)
                }
            }

        }
        
        
    }
    
    
}


