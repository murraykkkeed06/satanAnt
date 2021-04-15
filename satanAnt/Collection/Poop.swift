//
//  Poop.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/15.
//

import Foundation
import SpriteKit


class Poop: Collection {
    
    
    init(){
        let texture = SKTexture(imageNamed: "poop")
        super.init(texture: texture, color: .clear, size: CGSize(width: 20, height: 20))
        self.zPosition = 5
        self.type = .poop
        self.name = "poop"
        
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 20))
        self.physicsBody?.pinned = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.isDynamic = false
        
        self.physicsBody?.contactTestBitMask = 1
        self.physicsBody?.collisionBitMask = 2
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
