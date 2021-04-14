//
//  Panda.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/13.
//

import Foundation
import SpriteKit

enum ChickenSate: Int {
    case right
    case left
    case up
    case down
    case idle
    
    static func random() -> ChickenSate{
        return ChickenSate(rawValue: Int.random(in: 0..<5))!
    }
}


class Chicken: Pet {
    
    var chickenSize = CGSize(width: 20, height: 20)
   
    
    var homeScene: GameScene!
    
    private var _state: ChickenSate!
    var state: ChickenSate{
        set{
            _state = newValue
            self.removeAllActions()
            switch _state {
            case .right:
                self.run(SKAction(named: "chickenRight")!)
            case .left:
                self.run(SKAction(named: "chickenLeft")!)
            case .down:
                self.run(SKAction(named: "chickenFor")!)
            case .up:
                self.run(SKAction(named: "chickenBack")!)
            case .idle:
                self.run(SKAction(named: "idle")!)
                if let homeScene = self.homeScene{
                    homeScene.run(SKAction.playSoundFileNamed("chickenSound.mp3", waitForCompletion: false))
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
                self.state = ChickenSate.random()
            }
            
        }
        get{
            return _sinceStart
        }
        
    }
    
    
    init(){
        let texture = SKTexture(imageNamed: "chickenFor_1")
        super.init(texture: texture, color: .clear, size: chickenSize)
        self.zPosition = 1
        self.state = .idle
        self.sinceStart = 0

        self.name = "chicken"
        
        self.physicsBody = SKPhysicsBody(rectangleOf: chickenSize)
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
       
        var temp = ChickenSate.random()
        while temp == self.state {
            temp = ChickenSate.random()
        }
        self.state = temp
        
    
    }
    
    
    
}
