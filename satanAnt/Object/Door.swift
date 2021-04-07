//
//  Door.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/3/24.
//

import Foundation
import SpriteKit

class Door: SKSpriteNode {
    
    
    var doorSize = CGSize(width: 30, height: 30)
    
    init(position: CGPoint, name: String){
        let texture = SKTexture(imageNamed: "caveDoor_1")
        super.init(texture: texture, color: .clear, size: doorSize)
        self.run(SKAction(named: "newPortalMove")!)
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
        //self.name = "door"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
