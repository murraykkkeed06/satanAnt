//
//  Ghost.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/9.
//

import Foundation
import SpriteKit

enum GhostState {
    case right
    case left
}

class Ghost: Monster {
    
    var ghostSize = CGSize(width: 30, height: 36)
    var homeScene: GameScene!
    private var _health: CGFloat!
    override var health: CGFloat!{
        set{
            if self.isAlived {
                _health = newValue
                if _health<=0 {
                    
                    self.removeAllActions()
                    //first run action
                    homeScene.player.exp += 10
                    homeScene.player.expChanged = true
                    
                    self.isAlived = false
                    self.physicsBody = nil
                    //self.run(SKAction.fadeAlpha(by: 0, duration: 1))
                    
//                    let tomb = Tomb()
//                    tomb.position = self.position
//                    self.homeScene.addChild(tomb)
                    
                    let deadGhost = SKSpriteNode(texture: SKTexture(imageNamed: "deadGhost"), color: .clear, size: CGSize(width: 20, height: 20))
                    deadGhost.zPosition = 1
                    deadGhost.position = self.position
                    homeScene.addChild(deadGhost)
                    
                    //play dead sound
                    homeScene.run(homeScene.ghostDieSound)
                    
                    if Int.random(in: 0..<10)<1{
                        bornDrop(num: 1, position: self.position, homeScene: homeScene)
                        bornItemTexture(num: 1, position: self.position, homeScene: homeScene)
                    }
                    
                    let dieAction = SKAction(named: "monsterDie")!
                    self.run(SKAction.sequence([dieAction,SKAction.removeFromParent()]))
                    //self.removeFromParent()
                    
                }
            }else{
                self.physicsBody = nil
            }
        }
        get{
            return _health
        }
    }
    
    private var _sinceStart: TimeInterval!
    override var sinceStart: TimeInterval!{
        set{
            _sinceStart = newValue
            if _sinceStart>1 && isAlived{
                _sinceStart = 0
                move()
            }
            
        }
        get{return _sinceStart}
    }
    
    private var _ghostState: GhostState!
    var ghostState: GhostState{
        set{
            _ghostState = newValue
            switch newValue {
            case .left:
                self.run(SKAction(named: "ghostLeft")!)
            case .right:
                self.run(SKAction(named: "ghostRight")!)
            }
        }
        get{return _ghostState}
    }
    
    init(scene: GameScene){
        let texture = SKTexture(imageNamed: "ghostRight_1")
        super.init(texture: texture, color: .clear, size: ghostSize)
        self.zPosition = 3
        self.homeScene = scene
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 20))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.contactTestBitMask = 1
        self.physicsBody?.categoryBitMask = 4
        self.physicsBody?.collisionBitMask = 2
        self._ghostState = .right
        self.sinceStart = TimeInterval.random(in: 0..<1)
        self.name = "ghost"
        self.health = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func rightAttack()  {
        self.run(SKAction(named: "ghostRightAttack")!)
        homeScene.run(homeScene.ghostAttackSound)
        if homeScene.player.isAlived{
            homeScene.player.beingHit()
        }
    }
    
    func leftAttack()  {
        self.run(SKAction(named: "ghostLeftAttack")!)
        homeScene.run(homeScene.ghostAttackSound)
        if homeScene.player.isAlived{
            homeScene.player.beingHit()
        }
    }
    
    func move()  {
        //fly sound
//        if Int.random(in: 0..<10)<2{
//            homeScene.run(SKAction.playSoundFileNamed("ghostFly.wav", waitForCompletion: false))
//        }
        //if very close to player then attack and return
        if self.position.distanceTo(homeScene.player.position) < 50 {
            if self.ghostState == .left{leftAttack()}
            else{rightAttack()}
            return
        }
        
        
        
        //set state
        if homeScene.player.position.x < self.position.x {
            self.ghostState = .left
        }else {
            self.ghostState = .right
        }
        
        
        let diff = homeScene.player.position - self.position
        let x = diff.normalized().x
        let y = diff.normalized().y
        let range: CGFloat = 30
        
        
        self.run(SKAction.moveBy(x: x * range, y: y * range, duration:1 ))
       
    }
    
   
}
