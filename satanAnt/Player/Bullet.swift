//
//  Bullet.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/3/24.
//

import Foundation
import SpriteKit

class Bullet: SKSpriteNode {
    
    var range: CGFloat!
    var bulletSpeed: TimeInterval!
    var bulletSize: CGSize = CGSize(width: 10, height: 10)
    var homeScene: GameScene!
    
    init(position: CGPoint, name: String, homeScene: GameScene){
        let texture = SKTexture(imageNamed: name)
        super.init(texture: texture, color: .clear, size: bulletSize)
        self.zPosition = 2
        self.position = position
        self.name = name
        self.physicsBody = SKPhysicsBody(circleOfRadius: 5)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.contactTestBitMask = 4 + 2 + 64
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.categoryBitMask = 16
        self.homeScene = homeScene
        
        self.range = 150 + homeScene.player.baseBulletRange
        self.bulletSpeed = 0.5 + homeScene.player.baseBulletSpeed
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func flyTo(direction: CGPoint)  {
        
//        var targetMonster: SKSpriteNode!
//        var newDirection: CGPoint!
//        //auto detect monster and fly to in 30 degree in range
//        let logList = homeScene.logList
//        for i in 0..<logList.count{
//            let diff = (logList[i].position - homeScene.player.position)
//            if logList[i].position.distanceTo(homeScene.player.position) < range && abs(diff.angle - homeScene.player.facing.angle) < 30 {
//                newDirection = diff.normalized()
//                targetMonster = logList[i]
//                break
//            }
//        }
//
//        if targetMonster != nil {
//            let flyAction = SKAction.moveBy(x: newDirection.x*range, y: newDirection.y*range, duration: self.bulletSpeed)
//            let seq = SKAction.sequence([flyAction,SKAction.removeFromParent()])
//            self.run(seq)
//        }else {
//
//            let flyAction = SKAction.moveBy(x: direction.x*range, y: direction.y*range, duration: self.bulletSpeed)
//            let seq = SKAction.sequence([flyAction,SKAction.removeFromParent()])
//            self.run(seq)
//        }
        
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
