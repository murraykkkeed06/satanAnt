//
//  Panda.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/13.
//

import Foundation
import SpriteKit

enum CatState: Int {
    case right
    case left
    case up
    case down
    case idle
    
    static func random() -> CatState{
        return CatState(rawValue: Int.random(in: 0..<5))!
    }
}


class Cat: Pet {
    
    var catSize = CGSize(width: 25, height: 25)
   
    
    var homeScene: GameScene!
    
    private var _state: CatState!
    var state: CatState{
        set{
            _state = newValue
            self.removeAllActions()
            switch _state {
            case .right:
                self.run(SKAction(named: "catRight")!)
            case .left:
                self.run(SKAction(named: "catLeft")!)
            case .down:
                self.run(SKAction(named: "catFor")!)
            case .up:
                self.run(SKAction(named: "catBack")!)
            case .idle:
                self.run(SKAction(named: "idle")!)
                if let homeScene = self.homeScene{
                    homeScene.run(homeScene.meowSound)
                }
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
                self.state = CatState.random()
            }
            
        }
        get{
            return _sinceStart
        }
        
    }
    
    
    init(){
        let texture = SKTexture(imageNamed: "catFor_1")
        super.init(texture: texture, color: .clear, size: catSize)
        self.zPosition = 1
        self.state = .idle
        self.sinceStart = 0

        self.name = "cat"
        
        self.physicsBody = SKPhysicsBody(rectangleOf: catSize)
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
       
        var temp = CatState.random()
        while temp == self.state {
            temp = CatState.random()
        }
        self.state = temp
        
    
    }
    
    
    
}
