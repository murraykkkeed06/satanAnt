//
//  Stone.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/14.
//

import Foundation
import SpriteKit


class Van: Break {
    
    var vanSize = CGSize(width: 20, height: 20)
    
    init(){
        let texture = SKTexture(imageNamed: "van")
        super.init(texture: texture, color: .clear, size: vanSize)
        self.zPosition = 1
        
        self.physicsBody = SKPhysicsBody(rectangleOf: vanSize)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.pinned = true
        self.physicsBody?.contactTestBitMask = 16
        self.physicsBody?.categoryBitMask = 2
        self.name = "van"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
