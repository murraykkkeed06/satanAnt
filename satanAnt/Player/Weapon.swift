//
//  Weapon.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/3/27.
//

import Foundation
import SpriteKit

class Weapon: SKSpriteNode {
    
    var attackPoint: CGFloat!
    var attackSpeed: TimeInterval!

    
    init(name: String){
        let texture = SKTexture(imageNamed: name)
        super.init(texture: texture, color: .clear, size: CGSize(width: 40, height: 24))
        self.name = name
        self.zPosition = 6
        
        switch name {
        case "staff":
            attackPoint = 0.25
            attackSpeed = 0.1
        default:
            attackPoint = 0.25
            attackSpeed = 0.5
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func attack(direction: CGPoint, homeScene: GameScene){
        
        var useSword = false
        
        //use sword in distance < 30
        let distance: CGFloat = 60
        for i in 0..<homeScene.logList.count{
            let diff = homeScene.logList[i].position.distanceTo(homeScene.player.position)
            var vec = homeScene.logList[i].position - homeScene.player.position
            if diff<distance && abs(vec.normalize().angle - homeScene.player.facing.angle)<30 && homeScene.logList[i].isAlived{
                let attackPoint = AttackPoint()
                let bornPoint = homeScene.player.position + (homeScene.logList[i].position - homeScene.player.position)/2
                attackPoint.position = bornPoint
                homeScene.addChild(attackPoint)
                attackPoint.startPoint()
                homeScene.logList[i].beingHit()
                useSword = true
                break
            }
        }
        //print("sword: \(useSword)")
        //use bullet
        if useSword {return}
        if self.name == "staff"{
            if let bornPoint = homeScene.weaponOnHand.childNode(withName: "bornPoint"){
                let position = homeScene.weaponOnHand.convert(bornPoint.position, to: homeScene)
                let bullet = Bullet(position: position, name: "staffBullet",homeScene: homeScene)
                homeScene.addChild(bullet)
                bullet.flyTo(direction: direction)
            }
        }
        
        
    }
    
    func attack(degree: CGFloat, homeScene: GameScene){
        
        if self.name == "staff"{
            if let bornPoint = homeScene.weaponOnHand.childNode(withName: "bornPoint"){
                let position = homeScene.weaponOnHand.convert(bornPoint.position, to: homeScene)
                let bullet = Bullet(position: position, name: "staffBullet",homeScene: homeScene)
                homeScene.addChild(bullet)
                bullet.flyTo(degree: degree)
            }
            
        }
        
        
    }
    
}
