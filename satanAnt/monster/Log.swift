//
//  Log.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/3/27.
//

import Foundation
import SpriteKit
import AVFoundation

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
    var AudioPlayer = AVAudioPlayer()
    var AudioPlayer2 = AVAudioPlayer()
    var hurtSound: NSURL!
    var walkSound: NSURL!
    var isAlived = true
    var homeScene: GameScene!
    private var _health: CGFloat!
    var health: CGFloat{
        set{
            if self.isAlived {
                _health = newValue
                if _health<=0 {
                    self.AudioPlayer2.stop()
                    //first run action
                    homeScene.player.exp += 10
                    homeScene.player.expChanged = true
                    self.logState = .idle
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
            
            //set walk sound
            if logState != .idle && isAlived && homeScene.player.isAlived{
                self.AudioPlayer2 = try! AVAudioPlayer(contentsOf: self.walkSound as URL)

                self.AudioPlayer2.volume = 0.5
                self.AudioPlayer2.prepareToPlay()
                self.AudioPlayer2.numberOfLoops = -1
                self.AudioPlayer2.play()
            }else{
                self.AudioPlayer2.stop()
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
    
    init(scene: GameScene){

        hurtSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "logHurt", ofType: "mp3")!)
        walkSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "logWalk", ofType: "wav")!)

        self.AudioPlayer = try! AVAudioPlayer(contentsOf: self.hurtSound as URL)
        
        let texture = SKTexture(imageNamed: "log_forward_1")
        super.init(texture: texture, color: .clear, size: logSize)
        self.zPosition = 5
        self.logState = .idle
        self.physicsBody = SKPhysicsBody(rectangleOf: logSize)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.contactTestBitMask = 7 + 64
        self.physicsBody?.categoryBitMask = 4
        self.name = "log"
        self.sinceStart = 0
        self.health = 1
        self.homeScene = scene
        
        
        
        //self.startMoving()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func bump(){
        //print("bump!")
        sinceStart = 0
        logState = LogState.random()
    }
    func beingHit(){
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
