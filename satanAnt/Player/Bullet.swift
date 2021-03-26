//
//  Bullet.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/3/24.
//

import Foundation
import SpriteKit

class Bullet: SKSpriteNode {
    
    var timer: Timer!
    var bulletSpeed: TimeInterval = 3
    
    init(position: CGPoint){
        let texture = SKTexture(imageNamed: "bullet")
        super.init(texture: texture, color: .clear, size: CGSize(width: 10 , height: 10))
        self.zPosition = 2
        self.position = position
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func flyTo(direction: CGPoint)  {
        
        //self.physicsBody = SKPhysicsBody(circleOfRadius: 5)
//        self.physicsBody?.affectedByGravity = false
//        self.physicsBody?.allowsRotation = false
//        self.physicsBody?.applyImpulse(CGVector(dx: direction.x, dy: direction.y))
        let flyAction = SKAction.moveBy(x: direction.x*999, y: direction.y*999, duration: self.bulletSpeed)
        let wait = SKAction.wait(forDuration: 3)
        let seq = SKAction.sequence([flyAction,wait,SKAction.removeFromParent()])
        self.run(seq)
    }
    
    
}
