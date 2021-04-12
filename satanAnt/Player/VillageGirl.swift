//
//  Soilder.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/5.
//

import Foundation
import SpriteKit

class VillageGirl: SKSpriteNode {
    
    var villageGirlSize = CGSize(width: 28, height: 36)
    
    init(){
        let texture = SKTexture(imageNamed: "villageGirl")
        super.init(texture: texture, color: .clear, size: villageGirlSize)
        self.zPosition = 2
        self.run(SKAction(named: "idle")!)
        self.physicsBody = SKPhysicsBody(rectangleOf: villageGirlSize)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.pinned = true
        self.physicsBody?.allowsRotation = false
        self.name = "villageGirl"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
