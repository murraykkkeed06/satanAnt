//
//  Slime.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/9.
//

import Foundation
import SpriteKit




class Scarecrow: Monster {
    
    var scarecrowSize = CGSize(width: 40, height: 70)
    var homeScene: GameScene!
    
   
    
    init(scene: GameScene){
        
        let texture = SKTexture(imageNamed: "scarecrow")
        super.init(texture: texture, color: .clear, size: scarecrowSize)

        self.physicsBody = SKPhysicsBody(rectangleOf: scarecrowSize)
        self.physicsBody?.pinned = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.contactTestBitMask = 1
        self.physicsBody?.categoryBitMask = 4
        self.physicsBody?.collisionBitMask = 1
        self.zPosition = 4
        self.anchorPoint = CGPoint(x: 0.5, y: 0)
        self.name = "scarecrow"
        self.health = 1000
        self.isAlived = true
        self.homeScene = scene
        self.sinceStart = 0
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func beingHit(homeScene: GameScene) {
        let red = SKAction.colorize(with: .red, colorBlendFactor: 1, duration: 0.1)
        let clear = SKAction.colorize(with: .red, colorBlendFactor: 0, duration: 0.1)
        let vec = self.position - homeScene.player.position
        let back = SKAction.moveBy(x: vec.normalized().x*10, y: vec.normalized().y*10, duration: 0.1)
        self.run(back)
        self.run(SKAction.sequence([red,clear]))
        
        
        let sound: SKAction!
        switch Int.random(in: 0..<5) {
        case 0:
            sound = SKAction.playSoundFileNamed("hit_1.wav", waitForCompletion: false)
        case 1:
            sound = SKAction.playSoundFileNamed("hit_2.wav", waitForCompletion: false)
        case 2:
            sound = SKAction.playSoundFileNamed("hit_3.wav", waitForCompletion: false)
        case 3:
            sound = SKAction.playSoundFileNamed("hit_4.wav", waitForCompletion: false)
        case 4:
            sound = SKAction.playSoundFileNamed("hit_5.wav", waitForCompletion: false)
        default:
            sound = SKAction.playSoundFileNamed("hit_1.wav", waitForCompletion: false)
        }
    
        homeScene.run(sound)
    }
    
    
}

