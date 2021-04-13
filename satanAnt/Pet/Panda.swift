//
//  Panda.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/13.
//

import Foundation
import SpriteKit

enum PandaState: Int {
    case right
    case left
    case up
    case down
    case idle
    
    static func random() -> PandaState{
        return PandaState(rawValue: Int.random(in: 0..<5))!
    }
}


class Panda: Pet {
    
    var pandaSize = CGSize(width: 14, height: 20)
    var targetNode: SKNode!

   
    
    
    
    private var _facing: CGPoint!
    var facing: CGPoint{
        set{
            _facing = newValue
            if newValue.angle <= 45 || newValue.angle>=315{self.state = .right}
            else if newValue.angle <= 135 && newValue.angle>=45{self.state = .up}
            else if newValue.angle <= 225 && newValue.angle>=135{self.state = .left}
            else if newValue.angle <= 315 && newValue.angle>=225{self.state = .down}
            else {self.state = .right}
        }
        get{
            return _facing
        }
    }
    
    
    
    var homeScene: GameScene!
    
    private var _state: PandaState!
    var state: PandaState{
        set{
            _state = newValue
            self.removeAllActions()
            switch _state {
            case .right:
                self.run(SKAction(named: "pandaRight")!)
            case .left:
                self.run(SKAction(named: "pandaLeft")!)
            case .down:
                self.run(SKAction(named: "pandaFor")!)
            case .up:
                self.run(SKAction(named: "pandaBack")!)
            case .idle:
                self.run(SKAction(named: "idle")!)
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
            //check has moneytexture
            if targetNode == nil{
                if let homeScene = self.homeScene{
                    for node in homeScene.children{
                        if node.name == "cokeTexture" ||
                           node.name == "appleTexture" ||
                           node.name == "potionTexture" ||
                           node.name == "fireBombTexture" {
                            if let item = homeScene.childNode(withName: "popoButton"){
                                if !node.frame.contains(item.position){
                                    targetNode = node
                                    break
                                }
                            }
                        }
                    }
                }
            }
            
            if _sinceStart > 5 && targetNode == nil{
                _sinceStart = 0
                self.state = PandaState.random()
            }
            
            if _sinceStart > 2 && targetNode != nil{
                _sinceStart = 0
                var vec = targetNode.position - self.position
                self.facing = vec.normalize()
            }
            if targetNode != nil {
            //print("\(targetNode.name), \(facing)")
            }
            
        }
        get{
            return _sinceStart
        }
        
    }
    
    
    init(){
        let texture = SKTexture(imageNamed: "pandaFor_1")
        super.init(texture: texture, color: .clear, size: pandaSize)
        self.zPosition = 1
        self.state = .idle
        self.sinceStart = 0
        
        self.facing = CGPoint(x: 0, y: 0)
        self.name = "panda"
        
        self.physicsBody = SKPhysicsBody(rectangleOf: pandaSize)
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
        let originState = self.state
        var temp = PandaState.random()
        while temp == originState {
            temp = PandaState.random()
        }
        self.state = temp
        
        
        targetNode = nil
    }
    
    
    
}
