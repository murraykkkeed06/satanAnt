//
//  HeartDrop.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/7.
//

import Foundation
import SpriteKit

class HeartDrop: SKSpriteNode {
    
    var heartSize = CGSize(width: 20, height: 20)
    
    init(){
        let texture = SKTexture(imageNamed: "heartDrop_1")
        super.init(texture: texture, color: .clear, size: heartSize)
        self.zPosition = 30
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: 10))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.pinned = true
        self.name = "heart"
        self.physicsBody?.contactTestBitMask = 1
        self.run(SKAction(named: "heartAction")!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
