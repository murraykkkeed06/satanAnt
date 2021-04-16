//
//  Cave.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/5.
//

import Foundation
import SpriteKit

class Cave: SKSpriteNode {
    
    var caveSize = CGSize(width: 200, height: 100)
    
    init(){
        let texture = SKTexture(imageNamed: "cave")
        super.init(texture: texture, color: .clear, size: caveSize)
        self.zPosition = 1
        self.physicsBody = SKPhysicsBody(rectangleOf: caveSize)
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.pinned = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = 2
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
