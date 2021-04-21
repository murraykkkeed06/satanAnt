//
//  Door.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/3/24.
//

import Foundation
import SpriteKit

enum DoorDirection: Int {
    case right
    case left
    case up
    case down
}

class Door: SKSpriteNode {
    
    //32 26 16 13
    var doorSize = CGSize(width: 80, height: 52)
    
    init(position: CGPoint, name: String, doorDirection: DoorDirection){
        //let texture = SKTexture(imageNamed: "caveDoor_1")
        //let texture = SKTexture(imageNamed: "bornEffect_1")
        
        var texture: SKTexture!
        switch doorDirection {
        case .up:
            texture = SKTexture(imageNamed: "bridge_top")
        case .down:
            texture = SKTexture(imageNamed: "bridge_top")
        case .left:
            texture = SKTexture(imageNamed: "bridge")
        case .right:
            texture = SKTexture(imageNamed: "bridge")
        }
        super.init(texture: texture, color: .clear, size: doorSize)
        //self.run(SKAction(named: "newPortalMove")!)
        //self.run(SKAction(named: "bornEffect")!)
        switch doorDirection {
        case .right:
            self.anchorPoint = CGPoint(x: 1, y: 0.5)
        case .left:
            self.anchorPoint = CGPoint(x: 0, y: 0.5)
        case .up:
            self.anchorPoint = CGPoint(x: 1, y: 0.5)
            self.zRotation = 90 * (CGFloat.pi/180)
        case .down:
            self.anchorPoint = CGPoint(x: 0, y: 0.5)
            self.zRotation = 90 * (CGFloat.pi/180)
        }

        self.position = position
        self.name = name
        self.zPosition = 1
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: 1))
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.pinned = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.categoryBitMask = 3
        self.physicsBody?.contactTestBitMask = 1
        //self.name = "door"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
