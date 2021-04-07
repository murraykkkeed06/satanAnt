//
//  CoinDrop.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/7.
//

import Foundation
import SpriteKit

class CoinDrop: SKSpriteNode {
    
    var coinSize = CGSize(width: 20, height: 20)
    
    init(){
        let texture = SKTexture(imageNamed: "coinDrop_1")
        super.init(texture: texture, color: .clear, size: coinSize)
        self.zPosition = 2
        self.physicsBody = SKPhysicsBody(rectangleOf: coinSize)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.pinned = true
        self.physicsBody?.contactTestBitMask = 1
        self.run(SKAction(named: "coinAction")!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
