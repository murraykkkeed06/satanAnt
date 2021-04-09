//
//  Slime.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/9.
//

import Foundation
import SpriteKit

class Slime: Monster {
    
    var slimeSize = CGSize(width: 25, height: 25)
    var homeScene: GameScene!
    
    private var _health: CGFloat!
    var health: CGFloat{
        set{
            if self.isAlived {
                _health = newValue
                if _health<=0 {
            
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
            if _sinceStart > TimeInterval.random(in: 2..<3) {
                _sinceStart = 0
                move()
            }
        }
        get{
            return _sinceStart
        }
    }
    
    init(scene: GameScene){
        let texture = SKTexture(imageNamed: "slime_1")
        super.init(texture: texture, color: .clear, size: slimeSize)
        self.run(SKAction(named: "slimeIdle")!)
        
        self.physicsBody = SKPhysicsBody(rectangleOf: slimeSize)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.contactTestBitMask = 1
        self.zPosition = 10
        self.homeScene = scene
        self.isAlived = true
        self.name = "slime"
        self.health = 1
        self.sinceStart = TimeInterval.random(in: 0..<2)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    
    //move 20 dist : 1 s
    
    func move()  {
        
        let diff = homeScene.player.position - self.position
        let x = diff.normalized().x
        let y = diff.normalized().y
        let range: CGFloat = 60
        let duration = TimeInterval.random(in: 1..<2)
        
        self.run(SKAction.moveBy(x: x * range, y: y * range, duration: duration))
       
    }
    
    
    
    func random()  {
        let x = CGFloat.random(in: -1..<1)
        let y = CGFloat.random(in: -1..<1)
        let range: CGFloat = 20
        
        self.run(SKAction.moveBy(x: x * range, y: y * range, duration: 1))
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
