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


    
    
}
