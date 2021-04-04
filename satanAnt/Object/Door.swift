//
//  Door.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/3/24.
//

import Foundation
import SpriteKit

class Door: SKSpriteNode {
    
    
    var doorSize = CGSize(width: 20, height: 15)
    
    init(position: CGPoint, name: String){
        let texture = SKTexture(imageNamed: "fire_1")
        super.init(texture: texture, color: .clear, size: doorSize)
        self.run(SKAction(named: "firePortal")!)
        self.position = position
        self.name = name
        self.zPosition = 2
        self.physicsBody = SKPhysicsBody(rectangleOf: doorSize)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.pinned = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.categoryBitMask = 3
        self.physicsBody?.contactTestBitMask = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
