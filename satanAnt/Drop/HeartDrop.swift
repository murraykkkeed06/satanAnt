//
//  HeartDrop.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/7.
//

import Foundation
import SpriteKit

class HeartDrop: Drop {
    
    var heartSize = CGSize(width: 20, height: 20)
    
    init(){
        let texture = SKTexture(imageNamed: "heartDrop_1")
        super.init(texture: texture, color: .clear, size: heartSize)
        self.zPosition = 30
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: 10))
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.pinned = true
        self.name = "heart"
        self.physicsBody?.contactTestBitMask = 1 + 4
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.categoryBitMask = 256
        self.physicsBody?.mass = 0.5
        self.run(SKAction(named: "heartAction")!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func pickUpEffect(homeScene: GameScene) {
        homeScene.player.health += 0.25
        homeScene.player.healthChanged = true
        
        let sound = SKAction.playSoundFileNamed("heal.mp3", waitForCompletion: true)
        homeScene.run(sound)
        if let healEffect = SKEmitterNode(fileNamed: "healParticle") {
            healEffect.name = "heal"
            healEffect.position = homeScene.player.position
            homeScene.addChild(healEffect)
            healEffect.run(SKAction.sequence([SKAction.wait(forDuration: 3),SKAction.removeFromParent()]))
        }
    }
    
    
}
