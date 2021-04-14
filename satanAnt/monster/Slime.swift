//
//  Slime.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/9.
//

import Foundation
import SpriteKit

enum SlimeColor: Int {
    case green
    case red
    case blue
    case purple
    
    static func random() -> SlimeColor{
        return SlimeColor(rawValue: Int.random(in: 0..<4))!
    }
    
}


class Slime: Monster {
    
    var slimeSize = CGSize(width: 25, height: 25)
    var homeScene: GameScene!
    
    private var _health: CGFloat!
    override var health: CGFloat!{
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
                    
//                    let tomb = Tomb()
//                    tomb.position = self.position
//                    self.homeScene.addChild(tomb)
                    
                    let deadSlime = DeadSlime()
                    deadSlime.position = self.position
                    homeScene.addChild(deadSlime)
                    
                    homeScene.run(SKAction.playSoundFileNamed("slimeDie.wav", waitForCompletion: true))
                    
                    if Int.random(in: 0..<10)<1{
                        bornDrop(num: 1, position: self.position, homeScene: homeScene)
                        bornItemTexture(num: 1, position: self.position, homeScene: homeScene)
                    }
                    //let dieAction = SKAction(named: "slimeDie")!
                    let dieAction = SKAction(named: "monsterDie")!
                    
                    self.run(SKAction.sequence([dieAction,SKAction.run(deadSlime.dieAction),SKAction.removeFromParent()]))
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
            if isAlived && _sinceStart > TimeInterval.random(in: 2..<3) {
                _sinceStart = 0
                move()
            }
        }
        get{
            return _sinceStart
        }
    }
    
    init(scene: GameScene, color: SlimeColor){
        var texture: SKTexture!
        
        switch color {
        case .green:
            texture = SKTexture(imageNamed: "slime_1")
        case .purple:
            texture = SKTexture(imageNamed: "slimePurple_1")
        case .red:
            texture = SKTexture(imageNamed: "slimeRed_1")
        case .blue:
            texture = SKTexture(imageNamed: "slimeBlue_1")
        
        }
        
        super.init(texture: texture, color: .clear, size: slimeSize)
        
        switch color {
        case .green:
            self.run(SKAction(named: "slimeIdle")!)
        case .purple:
            self.run(SKAction(named: "slimePurlpleIdle")!)
        case .red:
            self.run(SKAction(named: "slimeRedIdle")!)
        case .blue:
            self.run(SKAction(named: "slimeBlueIdle")!)
        }
        self.physicsBody = SKPhysicsBody(rectangleOf: slimeSize)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.contactTestBitMask = 1
        self.physicsBody?.categoryBitMask = 4
        self.physicsBody?.collisionBitMask = 2
        self.zPosition = 2
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
       
        homeScene.run(SKAction.playSoundFileNamed("slimeJump.mp3", waitForCompletion: false))
    }
    
    
    
    func random()  {
        let x = CGFloat.random(in: -1..<1)
        let y = CGFloat.random(in: -1..<1)
        let range: CGFloat = 20
        
        self.run(SKAction.moveBy(x: x * range, y: y * range, duration: 1))
    }
    
    func bigger(scale: CGFloat)  {
        self.health += 1
        
        var newSize: CGSize!
        if self.frame.size.width * scale >= 100 || self.frame.size.height >= 100 {
            newSize = CGSize(width: 100, height: 100)
            self.run(SKAction.scale(to: newSize, duration: 1))
        }else {
            newSize = CGSize(width: self.slimeSize.width * scale, height: self.slimeSize.height * scale)
            self.run(SKAction.scale(by: scale, duration: 1))
        }
        self.physicsBody = SKPhysicsBody(rectangleOf: newSize)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.contactTestBitMask = 1
        self.physicsBody?.categoryBitMask = 4
        self.physicsBody?.collisionBitMask = 2
        self.zPosition = 10
    }
   
    
    
}
