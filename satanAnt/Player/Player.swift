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
    let moveDistance: CGFloat = 2
    var popoStart: TimeInterval = 0
    //var fireStart: TimeInterval = 0
    //which map in Map.swift
    var inMapNumber: Int!
    var playerSize = CGSize(width: 28, height: 34)
    
    //for  SKAction
    var rightIsSet = false
    var leftIsSet = false
    var backIsSet = false
    var forIsSet = false
    
    //weapon
    var weapon: Weapon!
    var weaponChanged = true
    
    var homeScene: GameScene!
    //player ability
    var health: CGFloat!
    var level: CGFloat!
    var money: CGFloat!
    private var _exp: CGFloat!
    var exp: CGFloat {
        set{
            _exp = newValue
            if _exp > 100 {
                self.level += 1
                self.levelChanged = true
                _exp = _exp - 100
            }
        }
        get{
            return _exp
        }
    }
    
    var healthChanged = true
    var levelChanged = true
    var moneyChanged = true
    var expChanged = true
    
    
    
    
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
            if newValue.angle <= 45 || newValue.angle>=315{self.state = .right}
            if newValue.angle <= 135 && newValue.angle>=45{self.state = .backward}
            if newValue.angle <= 225 && newValue.angle>=135{self.state = .left}
            if newValue.angle <= 315 && newValue.angle>=225{self.state = .forward}
           
        }
        get{
            return _facing
        }
    }
    
    init(){
        let texture = SKTexture(imageNamed: "new_forward_1")
        super.init(texture: texture, color: .clear, size: playerSize)
        self.zPosition = 6
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
        self.name = "player"
        self.exp = 89
        self.level = 3
        self.health = 2.75
        self.money = 178
        self.weapon = Weapon(name: "staff")
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    func beingHit()  {
        let red = SKAction.colorize(with: .red, colorBlendFactor: 1, duration: 0.5)
        let clear = SKAction.colorize(with: .red, colorBlendFactor: 0, duration: 0.1)
        let back = SKAction.moveBy(x: -self.homeScene.player.facing.x*10, y: -self.homeScene.player.facing.y*10, duration: 0.1)
        
        self.run(SKAction.sequence([red,clear]))
        self.run(back)
    }
    
    
}
