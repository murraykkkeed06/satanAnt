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
        super.init(texture: texture, color: .clear, size: CGSize(width: 30, height: 30))
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
        
        if self.name == "staff"{
            if let bornPoint = homeScene.weaponOnHand.childNode(withName: "bornPoint"){
                let position = homeScene.weaponOnHand.convert(bornPoint.position, to: homeScene)
                let bullet = Bullet(position: position, name: "staffBullet")
                homeScene.addChild(bullet)
                bullet.flyTo(direction: direction)
            }
            
        }
        
        
    }
    
}
