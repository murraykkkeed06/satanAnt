//
//  Bullet.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/3/24.
//

import Foundation
import SpriteKit

class Bullet: SKSpriteNode {
    
    var range: CGFloat = 100
    var bulletSpeed: TimeInterval = 0.5
    var bulletSize: CGSize = CGSize(width: 10, height: 10)
    
    init(position: CGPoint, name: String){
        let texture = SKTexture(imageNamed: name)
        super.init(texture: texture, color: .clear, size: bulletSize)
        self.zPosition = 2
        self.position = position
        self.name = name
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func flyTo(direction: CGPoint)  {
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 5)
        //self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        //self.physicsBody?.allowsRotation = false
        //self.physicsBody?.applyImpulse(CGVector(dx: direction.x, dy: direction.y))
        self.physicsBody?.contactTestBitMask = 1
        self.physicsBody?.collisionBitMask = 0
        let flyAction = SKAction.moveBy(x: direction.x*range, y: direction.y*range, duration: self.bulletSpeed)
        let seq = SKAction.sequence([flyAction,SKAction.removeFromParent()])
        self.run(seq)
    }
    
    
}
