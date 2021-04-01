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
        self.physicsBody = SKPhysicsBody(circleOfRadius: 5)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.contactTestBitMask = 1
        self.physicsBody?.collisionBitMask = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func flyTo(direction: CGPoint)  {
        
        
        let flyAction = SKAction.moveBy(x: direction.x*range, y: direction.y*range, duration: self.bulletSpeed)
        let seq = SKAction.sequence([flyAction,SKAction.removeFromParent()])
        self.run(seq)
    }
    
    func  flyTo(degree: CGFloat)  {
        let x: CGFloat!
        let y: CGFloat!
        if degree < 90 {
             x = cos(degree * CGFloat.pi / 180)
             y = sin(degree * CGFloat.pi / 180)
        }else if degree < 180 {
            let newDegree = 180 - degree
            x = -cos(newDegree * CGFloat.pi / 180)
            y = sin(newDegree * CGFloat.pi / 180)
        }else if degree < 270{
            let newDegree =  degree - 180
            x = -cos(newDegree * CGFloat.pi / 180)
            y = -sin(newDegree * CGFloat.pi / 180)
        }else {
            let newDegree =  360 - degree
            x = cos(newDegree * CGFloat.pi / 180)
            y = -sin(newDegree * CGFloat.pi / 180)
        }
        let flyAction = SKAction.moveBy(x: x*range, y: y*range, duration: self.bulletSpeed)
        let seq = SKAction.sequence([flyAction,SKAction.removeFromParent()])
        self.run(seq)
    }
    
    
}
