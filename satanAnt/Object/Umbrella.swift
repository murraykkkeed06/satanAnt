//
//  Umbrella.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/16.
//

import Foundation
import SpriteKit

class Umbrella: SKSpriteNode {
    
    init(){
        let texture = SKTexture(imageNamed: "umbrella")
        super.init(texture: texture, color: .clear, size: CGSize(width: 50, height: 30))
        self.zPosition = 10
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 30))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.contactTestBitMask = 16
        self.physicsBody?.isDynamic = false
        self.name = "umbrella"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
