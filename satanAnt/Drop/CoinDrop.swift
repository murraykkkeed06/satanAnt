//
//  CoinDrop.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/7.
//

import Foundation
import SpriteKit

class CoinDrop: Drop {
    
    var coinSize = CGSize(width: 20, height: 20)
    
    init(){
        let texture = SKTexture(imageNamed: "coinDrop_1")
        super.init(texture: texture, color: .clear, size: coinSize)
        self.zPosition = 30
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: 10))
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.pinned = true
        self.physicsBody?.contactTestBitMask = 1 + 256
        //self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.categoryBitMask = 256
        self.physicsBody?.mass = 0.5
        self.run(SKAction(named: "coinAction")!)
        self.name = "coin"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}


