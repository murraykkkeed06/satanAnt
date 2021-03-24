//
//  Popo.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/3/24.
//

import Foundation
import SpriteKit

class Popo: SKSpriteNode {
    
    init(position: CGPoint){
        let texture = SKTexture(imageNamed: "popo")
        super.init(texture: texture, color: .clear, size: CGSize(width: 30, height: 30))
        self.position = position
        self.zPosition = 3
        
        let particle = SKEmitterNode(fileNamed: "popo")!
        addChild(particle)
        particle.position = CGPoint(x: 0, y: 10)
        let wait = SKAction.wait(forDuration: 5)
        let remove = SKAction.removeFromParent()
        let seq = SKAction.sequence([wait,remove])
        
        particle.run(seq)
        self.run(seq)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
