//
//  Egg.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/12.
//

import Foundation
import SpriteKit

class PlantDog: Hat {
    
    var plantSize = CGSize(width: 30, height: 36)
    var homeScene: GameScene!
    init(){
        let texture = SKTexture(imageNamed: "plantDog_1")
        super.init(texture: texture, color: .clear, size: plantSize)
        self.zPosition = 20
        self.name = "hat"
        self.run(SKAction(named: "plantDog")!)
//        
//        self.physicsBody = SKPhysicsBody(rectangleOf: plantSize)
//        self.physicsBody?.pinned = true
//        self.physicsBody?.affectedByGravity = false
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
   
    
}
