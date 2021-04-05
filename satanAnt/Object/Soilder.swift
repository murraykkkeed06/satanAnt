//
//  Soilder.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/5.
//

import Foundation
import SpriteKit

class Soilder: SKSpriteNode {
    
    var soilderSize = CGSize(width: 28, height: 36)
    
    init(){
        let texture = SKTexture(imageNamed: "soilder_1")
        super.init(texture: texture, color: .clear, size: soilderSize)
        self.zPosition = 2
        self.run(SKAction(named: "soilderIdle")!)
        self.physicsBody = SKPhysicsBody(rectangleOf: soilderSize)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.pinned = true
        self.physicsBody?.allowsRotation = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
