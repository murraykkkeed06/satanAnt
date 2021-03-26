//
//  Player.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/3/24.
//

import Foundation
import SpriteKit


enum playerState {
    case idle
    case right
    case left
    case forward
    case backward
}


class Player: SKSpriteNode {
    
    var playerIsMoving = false
    
    var timer: Timer!
    
    let moveDistance: CGFloat = 2
    
    var timerSet = false
    
    

    var popoStart: TimeInterval = 0
    
    var inMapNumber: Int!
    
    var playerSize = CGSize(width: 28, height: 34)
    
    var rightIsSet = false
    var leftIsSet = false
    var backIsSet = false
    var forIsSet = false
    
    
    private var _state: playerState!
    var state: playerState {
        set{
            _state = newValue
            
            switch newValue {
            case .idle:
                //self.removeAllActions()
                self.run(SKAction(named: "playerIdle")!)
            case .left:
                if leftIsSet {break}
                self.run(SKAction(named: "playerLeft")!)
                leftIsSet = true
                rightIsSet = false
                backIsSet = false
                forIsSet = false
            case .right:
                if rightIsSet {break}
                self.run(SKAction(named: "playerRight")!)
                rightIsSet = true
                leftIsSet = false
                backIsSet = false
                forIsSet = false
            case .forward:
                if forIsSet {break}
                self.run(SKAction(named: "playerForward")!)
                forIsSet = true
                leftIsSet = false
                rightIsSet = false
                backIsSet = false
            case .backward:
                if backIsSet {return}
                self.run(SKAction(named: "playerBackward")!)
                backIsSet = true
                leftIsSet = false
                rightIsSet = false
                forIsSet = false
            }
        }
        get{
            return _state
        }
    }
    private var _facing: CGPoint!
    var facing: CGPoint {
        set{
            _facing = newValue
            if newValue.angle < 45 || newValue.angle>315{self.state = .right}
            if newValue.angle < 135 && newValue.angle>45{self.state = .backward}
            if newValue.angle < 225 && newValue.angle>135{self.state = .left}
            if newValue.angle < 315 && newValue.angle>225{self.state = .forward}
           
        }
        get{
            return _facing
        }
    }
    
    init(){
        let texture = SKTexture(imageNamed: "new_forward_1")
        super.init(texture: texture, color: .clear, size: playerSize)
        self.zPosition = 1
        self.state = .idle
        self._facing = CGPoint(x: 0, y: 0)
        //self.idleStart = 0
        self.physicsBody = SKPhysicsBody(rectangleOf: playerSize)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.isDynamic = true
        //self.physicsBody?.collisionBitMask = 2
        self.physicsBody?.categoryBitMask = 1
        self.physicsBody?.contactTestBitMask = 3
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
}
