//
//  Egg.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/12.
//

import Foundation
import SpriteKit

class Egg: Ammo {
    
    var eggSize = CGSize(width: 15, height: 20)
    var homeScene: GameScene!
    init(scene: GameScene){
        let texture = SKTexture(imageNamed: "egg")
        super.init(texture: texture, color: .clear, size: eggSize)
        self.zPosition = 500
        
        self.physicsBody = SKPhysicsBody(rectangleOf: eggSize)
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.mass = 0.5
        self.physicsBody?.contactTestBitMask = 1 + 4 
        self.physicsBody?.categoryBitMask = 16
        self.physicsBody?.collisionBitMask = 0
        self.name = "egg"
        removeAfter()
        self.homeScene = scene
        self.homeScene.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    func removeAfter()  {
        let wait = SKAction.wait(forDuration: 5)
        self.run(SKAction.sequence([wait,SKAction.removeFromParent()]))
    }
    
}
