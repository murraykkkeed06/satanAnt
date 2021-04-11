//
//  CanonBall.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/11.
//

import Foundation
import SpriteKit


class CanonBall: Ammo {
    
    var cannonBallSize = CGSize(width: 20, height: 20)
    
    init(){
        let texture = SKTexture(imageNamed: "canonBall")
        super.init(texture: texture, color: .clear, size: cannonBallSize)
        self.zPosition = 2
        self.physicsBody = SKPhysicsBody(rectangleOf: cannonBallSize)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.contactTestBitMask = 1 + 4 + 2
        self.physicsBody?.categoryBitMask = 16
        self.physicsBody?.collisionBitMask = 0
        self.name = "canonBall"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
