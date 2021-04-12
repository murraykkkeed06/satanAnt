//
//  Staff.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/10.
//

//bullet speed must > 0.5

import Foundation
import SpriteKit

class Staff: Weapon {
    
    
    
    
    init(){
        
        
        let texture = SKTexture(imageNamed: "staff")
        super.init(texture: texture, color: .clear, size: CGSize(width: 40, height: 24))
        self.name = "staff"
        self.zPosition = 1
        
        self.attackPoint = 0.25
        self.attackSpeed = 0.5
        
        //staff attack speed must be > 0.5
        //attackspeed and bulletspeed are different
        //it diverse from different weapon
        
        self.weaponType = .staff
       
       
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func rAttack(direction: CGPoint, homeScene: GameScene){
       
        if let bornPoint = homeScene.weaponOnHand.childNode(withName: "bornPoint"){
            let position = homeScene.weaponOnHand.convert(bornPoint.position, to: homeScene)
            
            let wait = SKAction.wait(forDuration: 0.1)
            
            let fire = SKAction.run({
                let bullet1 = Bullet(position: position, name: "staffBullet",homeScene: homeScene,bulletRange: 150,bulletSpeed: 0.5,bulletSize: CGSize(width: 10, height: 10))
                let bullet2 = Bullet(position: position, name: "staffBullet",homeScene: homeScene,bulletRange: 150,bulletSpeed: 0.5,bulletSize: CGSize(width: 10, height: 10))
                let bullet3 = Bullet(position: position, name: "staffBullet",homeScene: homeScene,bulletRange: 150,bulletSpeed: 0.5,bulletSize: CGSize(width: 10, height: 10))
                homeScene.addChild(bullet1)
                homeScene.addChild(bullet2)
                homeScene.addChild(bullet3)
                bullet1.flyTo(degree: homeScene.player.facing.angle)
                bullet2.flyTo(degree: homeScene.player.facing.angle + 20)
                bullet3.flyTo(degree: homeScene.player.facing.angle - 20)
             
                homeScene.run(SKAction.playSoundFileNamed("shoot.mp3", waitForCompletion: false))
            })
            
            homeScene.run(SKAction.sequence([fire,wait,fire,wait,fire]))
            
            
        }
    }
    
    override func attack(direction: CGPoint, homeScene: GameScene){
        
        if homeScene.player.sinceFire < tempTime {return}
        
        switch tempTime {
        case 0.3:
            tempTime=0.2
        case 0.2:
            tempTime=0.1
        case 0.1:
            tempTime=0.3
        default:
            break
        }
        
        homeScene.player.sinceFire = 0
        
        var useSword = false
        
        //use sword in distance < 60
        let distance: CGFloat = 60
        for i in 0..<homeScene.monsterList.count{
            let diff = homeScene.monsterList[i].position.distanceTo(homeScene.player.position)
            var vec = homeScene.monsterList[i].position - homeScene.player.position
            if diff<distance && abs(vec.normalize().angle - homeScene.player.facing.angle)<30 && homeScene.monsterList[i].isAlived{
                let attackPoint = AttackPoint()
                let bornPoint = homeScene.player.position + (homeScene.monsterList[i].position - homeScene.player.position)/2
                attackPoint.position = bornPoint
                homeScene.addChild(attackPoint)
                attackPoint.startPoint()
                homeScene.monsterList[i].beingHit(homeScene: homeScene)
                useSword = true

                homeScene.run(SKAction.playSoundFileNamed("swordHit.wav", waitForCompletion: false))
                
                break
            }
        }
       
        //use bullet
        if useSword {return}
       
        if let bornPoint = homeScene.weaponOnHand.childNode(withName: "bornPoint"){
            let position = homeScene.weaponOnHand.convert(bornPoint.position, to: homeScene)
            let bullet = Bullet(position: position, name: "staffBullet",homeScene: homeScene,bulletRange: 150,bulletSpeed: self.attackSpeed ,bulletSize: CGSize(width: 10, height: 10))
            homeScene.addChild(bullet)
            bullet.flyTo(direction: direction)
            
            let sound = SKAction.playSoundFileNamed("shoot.mp3", waitForCompletion: false)
            homeScene.run(sound)
            
            
        }
        
        
        
    }
    
    override func attack(degree: CGFloat, homeScene: GameScene){
        
        
        if let bornPoint = homeScene.weaponOnHand.childNode(withName: "bornPoint"){
            let position = homeScene.weaponOnHand.convert(bornPoint.position, to: homeScene)
            let bullet = Bullet(position: position, name: "staffBullet",homeScene: homeScene,bulletRange: 150,bulletSpeed: 0.5,bulletSize: CGSize(width: 10, height: 10))
            homeScene.addChild(bullet)
            bullet.flyTo(degree: degree)
        }
        
        
        
        
    }
    
    override func reset() {
        self.tempTime = 0.3
    }
    
    
}
