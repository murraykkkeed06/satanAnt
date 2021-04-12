//
//  Npc.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/4.
//

import Foundation
import SpriteKit

enum NpcState: Int {
    case idle
    case right
    case left
    case backward
    case forward
    
    static func random() -> NpcState{
        return NpcState(rawValue: Int.random(in: 0..<5))!
    }
}

class Npc: SKSpriteNode {
    
    
    
    private var _state: NpcState!
    var state: NpcState{
        set{
            _state = newValue
            self.removeAllActions()
            switch _state {
            case .backward:
                self.run(SKAction(named: "npcBack")!)
            case .forward:
                self.run(SKAction(named: "npcFor")!)
            case .right:
                self.run(SKAction(named: "npcRight")!)
            case .left:
                self.run(SKAction(named: "npcLeft")!)
            case .idle:
                self.run(SKAction(named: "npcIdle")!)
            default:
                self.run(SKAction(named: "npcIdle")!)
            }
            
        }
        get{return _state}
        
    }
    
    private var _sinceBorn: TimeInterval!
    var sinceBorn: TimeInterval{
        set{
            _sinceBorn = newValue
            if _sinceBorn > 3 {
                switch state {
                case .idle:
                    self.state = .right
                case .right:
                    state = .forward
                case .forward:
                    state = .left
                case .left:
                    state = .backward
                case .backward:
                    state = .idle
                }
            _sinceBorn = 0            
            }
        }
        get{
            return _sinceBorn
        }
    }
    
    init(){
        let texture = SKTexture(imageNamed: "npcFor_1")
        super.init(texture: texture, color: .clear, size: CGSize(width: 28, height: 34))
        self.state = .idle
        self.zPosition = 3
        self.sinceBorn = 0
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 28, height: 34))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.contactTestBitMask = 0
        self.physicsBody?.isDynamic = false
        self.name = "npc"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func bump() {
        self.state = NpcState.random()
        self.sinceBorn = 0
    }
}
