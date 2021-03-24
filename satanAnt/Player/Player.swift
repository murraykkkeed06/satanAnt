//
//  Player.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/3/24.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    
    var playerIsMoving = false
    
    var timer: Timer!
    
    let moveDistance: CGFloat = 3
    
    var timerSet = false
    
    var facing: CGPoint = CGPoint(x: 0, y: 0)
    
    var popoStart: TimeInterval = 0
    
    init(){
        let texture = SKTexture(imageNamed: "nakedAnt_2")
        super.init(texture: texture, color: .clear, size: CGSize(width: 50, height: 50))
        
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.categoryBitMask = 1
        self.physicsBody?.contactTestBitMask = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
}
