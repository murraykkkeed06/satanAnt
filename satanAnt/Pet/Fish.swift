//
//  Panda.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/13.
//

import Foundation
import SpriteKit

enum FishState: Int {
    case right
    case left
    case idle
    
    static func random() -> FishState{
        return FishState(rawValue: Int.random(in: 0..<3))!
    }
}


class Fish: Pet {
    
    var fishSize = CGSize(width: 25, height: 25)
   
    
    var homeScene: GameScene!
    
    private var _state: FishState!
    var state: FishState{
        set{
            _state = newValue
            self.removeAllActions()
            switch _state {
            case .right:
                self.run(SKAction(named: "fishRight")!)
            case .left:
                self.run(SKAction(named: "fishLeft")!)
            case .idle:
                self.run(SKAction(named: "idle")!)
                //run sound
            default:
                break
            }
        }
        get{
            return _state
        }
    }
    
    private var _sinceStart: TimeInterval!
    override var sinceStart: TimeInterval!{
        set{
            _sinceStart = newValue
            
            if _sinceStart > 5{
                _sinceStart = 0
                self.state = FishState.random()
            }
            
        }
        get{
            return _sinceStart
        }
        
    }
    
    
    init(){
        let texture = SKTexture(imageNamed: "fishRight")
        super.init(texture: texture, color: .clear, size: fishSize)
        self.zPosition = 1
        self.state = .right
        self.sinceStart = 0

        self.name = "fish"
        
        self.physicsBody = SKPhysicsBody(rectangleOf: fishSize)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.pinned = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.contactTestBitMask = 128 + 2 + 4
        self.physicsBody?.collisionBitMask = 2
        self.physicsBody?.isDynamic = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setup(scene: GameScene)  {
        self.homeScene = scene
    }
    
    func bump()  {
       
        switch self.state {
        case .right:
            self.state = .left
        case .left:
            self.state = .right
        default:
            self.state = .idle
        }
        
    
    }
    
    
    
}
