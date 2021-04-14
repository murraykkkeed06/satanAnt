//
//  Soilder.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/5.
//

import Foundation
import SpriteKit

class Scientist: SKSpriteNode {
    
    var scientistSize = CGSize(width: 28, height: 36)
    
    init(){
        let texture = SKTexture(imageNamed: "scientist")
        super.init(texture: texture, color: .clear, size: scientistSize)
        self.zPosition = 2
        self.run(SKAction(named: "idle")!)
        self.physicsBody = SKPhysicsBody(rectangleOf: scientistSize)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.pinned = true
        self.physicsBody?.allowsRotation = false
        self.name = "scientist"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
