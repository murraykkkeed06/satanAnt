//
//  Candy.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/10.
//

import Foundation
import SpriteKit




class Candy: Ammo {
    
    var bulletRange: CGFloat!
    var bulletSpeed: TimeInterval!
    var homeScene: GameScene!
    var force: CGFloat!
      
    init(position: CGPoint, homeScene: GameScene, force: CGFloat, bulletSize: CGSize){
        var texture: SKTexture!
        
        switch Int.random(in: 0..<6) {
        case 0:
            texture = SKTexture(imageNamed: "candy_1")
        case 1:
            texture = SKTexture(imageNamed: "candy_2")
        case 2:
            texture = SKTexture(imageNamed: "candy_3")
        case 3:
            texture = SKTexture(imageNamed: "candy_4")
        case 4:
            texture = SKTexture(imageNamed: "candy_5")
        case 5:
            texture = SKTexture(imageNamed: "candy_6")
        default:
            texture = SKTexture(imageNamed: "candy_1")
        }
        
 
        super.init(texture: texture, color: .clear, size: bulletSize)
        self.name = "candy"
        self.zPosition = 6
    
        self.homeScene = homeScene
        self.force = force + CGFloat(homeScene.player.baseBulletSpeedPoint) * 20
        self.position = position
        
        self.physicsBody = SKPhysicsBody(rectangleOf: bulletSize)
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.mass = 0.5
        self.physicsBody?.contactTestBitMask = 4 + 2 + 64 
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.categoryBitMask = 16
        
        
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func flyTo(direction: CGPoint)  {
        
//        if homeScene.player.facing.y > 0 {
//            homeScene.physicsWorld.gravity = CGVector(dx: 0, dy: -3);
//        }else{
//            homeScene.physicsWorld.gravity = CGVector(dx: 0, dy: 0);
//        }
        homeScene.physicsWorld.gravity = CGVector(dx: 0, dy: 0);
        let wait = SKAction.wait(forDuration: 0.5)
        let up = SKAction.run({

            // Apply an impulse at the vector.
            let v = CGVector(dx: direction.x * self.force, dy: direction.y * self.force)
            
            self.physicsBody?.applyImpulse(v)
            self.physicsBody?.applyTorque(1)
            
        })
        
        self.run(SKAction.sequence([up,wait,SKAction.removeFromParent()]))
        
        
        
    }
    
    
    
}
