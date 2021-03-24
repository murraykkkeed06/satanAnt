//
//  Door.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/3/24.
//

import Foundation
import SpriteKit

class Door: SKSpriteNode {
    
    init(position: CGPoint, name: String){
        let texture = SKTexture(imageNamed: "door")
        super.init(texture: texture, color: .clear, size: CGSize(width: 50, height: 50  ))
        self.position = position
        self.name = name
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.pinned = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.categoryBitMask = 0
        self.physicsBody?.contactTestBitMask = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
