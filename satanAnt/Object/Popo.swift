//
//  Popo.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/3/24.
//

import Foundation
import SpriteKit

class Popo: SKSpriteNode {
    
    var popoSize = CGSize(width: 30, height: 30)
    var homeScene: GameScene!
    var isFlying = false
    
    init(position: CGPoint, scene: GameScene){
        
        let texture = SKTexture(imageNamed: "popo")
        super.init(texture: texture, color: .clear, size: popoSize)
        self.position = position
        self.zPosition = 3
        self.physicsBody = SKPhysicsBody(rectangleOf: popoSize)
        //self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.mass = 0.5
        self.homeScene = scene
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func shoot() {
        
        if homeScene.player.facing.y > 0 {
            homeScene.physicsWorld.gravity = CGVector(dx: 0, dy: -3);
        }else{
            homeScene.physicsWorld.gravity = CGVector(dx: 0, dy: -0.5);
        }
        
        let wait1 = SKAction.wait(forDuration: 0.3)
        let wait2 = SKAction.wait(forDuration: 5)
        self.run(SKAction.sequence([SKAction.run(up),wait1,SKAction.run(down),wait2,SKAction.removeFromParent()]))
        
    }
    
    func up()  {
        let force: CGFloat = 100
        // Apply an impulse at the vector.
        let v = CGVector(dx: homeScene.player.facing.x * force, dy: homeScene.player.facing.y * force)
        
        self.physicsBody?.applyImpulse(v)
        isFlying = true
    }
    func down()  {
        isFlying = false
        self.physicsBody = nil
        let particle = SKEmitterNode(fileNamed: "popo")!
        addChild(particle)
        particle.position = CGPoint(x: 0, y: 10)
        let wait = SKAction.wait(forDuration: 5)
        let remove = SKAction.removeFromParent()
        let seq = SKAction.sequence([wait,remove])

        particle.run(seq)
        self.run(seq)
    }
    
   
    
}
