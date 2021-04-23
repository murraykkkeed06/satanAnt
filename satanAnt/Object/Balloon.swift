//
//  Balloon.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/23.
//

import Foundation
import SpriteKit

class Balloon: SKSpriteNode {
    
    var gift: Gift!
    
    init(){
        
        let texture = SKTexture(imageNamed: "balloon")
        super.init(texture: texture, color: .clear, size: CGSize(width: 40, height: 80))
        self.zPosition = 500
        self.run(SKAction(named: "balloonAction")!)
        self.name = "balloon"
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.75)
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 30))
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.pinned = false
        self.physicsBody?.categoryBitMask = 0
        self.physicsBody?.contactTestBitMask = 16
        self.physicsBody?.collisionBitMask = 0
        
        gift = Gift()
        gift.position = CGPoint(x: 0, y: -70)
        self.addChild(gift)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
