//
//  Log.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/3/27.
//

import Foundation
import SpriteKit

enum LogState: Int{
    case right
    case left
    case forward
    case backward
    case idle
    
    static func random() -> LogState{
        return LogState(rawValue: Int.random(in: 0..<4))!
    }
}

class Log: SKSpriteNode{
    
    private var _health: CGFloat!
    var health: CGFloat{
        set{
            _health = newValue
            if _health<=0 {
                //first run action
                self.removeFromParent()
            }
        }
        get{
            return _health
        }
    }
    
    private var _logState: LogState!
    var logState: LogState {
        set{
            _logState = newValue
            self.removeAllActions()
            switch newValue {
            case .idle:
                self.run(SKAction.resize(toWidth: 36, duration: 0.01))
                self.run(SKAction(named: "logIdle")!)
            case .right:
                self.run(SKAction.resize(toWidth: 20, duration: 0.01))
                self.run(SKAction(named: "logRight")!)
            case .backward:
                self.run(SKAction.resize(toWidth: 36, duration: 0.01))
                self.run(SKAction(named: "logBackward")!)
            case .forward:
                self.run(SKAction.resize(toWidth: 36, duration: 0.01))
                self.run(SKAction(named: "logForward")!)
            case .left:
                self.run(SKAction.resize(toWidth: 20, duration: 0.01))
                self.run(SKAction(named: "logLeft")!)
            }
        }
        get{
            return _logState
        }
        
        
    }
    private var _sinceStart: TimeInterval!
    var sinceStart: TimeInterval{
        set{
            _sinceStart = newValue
            if _sinceStart > 2 {
                
                if logState == .idle {
                    logState = LogState.random()
                }else {
                    logState = .idle
                }
                _sinceStart = 0
            }
        }
        get{
            return _sinceStart
        }
    }
    var logSize = CGSize(width: 36, height: 36)
    var timer: Timer!
    
    init(){

        let texture = SKTexture(imageNamed: "log_forward_1")
        super.init(texture: texture, color: .clear, size: logSize)
        self.zPosition = 3
        self.logState = .idle
        self.physicsBody = SKPhysicsBody(rectangleOf: logSize)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.contactTestBitMask = 7
        self.physicsBody?.categoryBitMask = 4
        self.name = "log"
        self.sinceStart = 0
        self.health = 1
        //self.startMoving()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func bump(){
        print("bump!")
        sinceStart = 0
        logState = LogState.random()
    }
    
    
}
