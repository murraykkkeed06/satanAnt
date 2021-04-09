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
    var health: CGFloat{
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
                    
                    let tomb = Tomb()
                    tomb.position = self.position
                    self.homeScene.addChild(tomb)
                    
                    if Int.random(in: 0..<10) < 5 {
                    
                        let heart = HeartDrop()
                        
                        let x = CGFloat.random(in: 0..<10)
                        let y = CGFloat.random(in: 0..<10)
                        heart.position = self.position + CGPoint(x: x, y: y)
                        self.homeScene.addChild(heart)
                    }
                    
                    if Int.random(in: 0..<10) < 5 {
                        
                        let money = CoinDrop()
                        
                        let x = CGFloat.random(in: 0..<10)
                        let y = CGFloat.random(in: 0..<10)
                        money.position = self.position + CGPoint(x: x, y: y)
                        self.homeScene.addChild(money)
                    }
                    
                    
                    let dieAction = SKAction(named: "monsterDie")!
                    self.run(SKAction.sequence([dieAction,SKAction.removeFromParent()]))
                    //self.removeFromParent()
                    
                }
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
        self.zPosition = 10
        self.homeScene = scene
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 20))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.contactTestBitMask = 1
        self._ghostState = .right
        self.sinceStart = TimeInterval.random(in: 0..<1)
        self.name = "ghost"
        self.health = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func rightAttack()  {
        self.run(SKAction(named: "ghostRightAttack")!)
        homeScene.player.beingHit()
    }
    
    func leftAttack()  {
        self.run(SKAction(named: "ghostLeftAttack")!)
        homeScene.player.beingHit()
    }
    
    func move()  {
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
    
    override func beingHit(){
        //let sound = SKAction.playSoundFileNamed("hit", waitForCompletion: false)
        let red = SKAction.colorize(with: .red, colorBlendFactor: 1, duration: 0.1)
        let clear = SKAction.colorize(with: .red, colorBlendFactor: 0, duration: 0.1)
        let back = SKAction.moveBy(x: self.homeScene.player.facing.x*10, y: self.homeScene.player.facing.y*10, duration: 0.1)
        self.run(back)
        self.run(SKAction.sequence([red,clear]))
        
        self.health -= (homeScene.player.weapon.attackPoint + homeScene.player.baseAttackPoint)
        
//        self.AudioPlayer.volume = 5
//        self.AudioPlayer.prepareToPlay()
//        self.AudioPlayer.play()
        let sound = SKAction.playSoundFileNamed("logHurt.mp3", waitForCompletion: false)
        homeScene.run(sound)
        
    }
}
