//
//  Bird.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/12.
//

import Foundation
import SpriteKit

class Bird: SKSpriteNode {
    
    var homeScene: GameScene!
    private var _sinceStart: TimeInterval!
    var sinceStart: TimeInterval{
        set{
            _sinceStart = newValue
            if _sinceStart > TimeInterval.random(in: 2..<4){
                let egg = Egg(scene: homeScene)
                homeScene.run(SKAction.playSoundFileNamed("bird.wav", waitForCompletion: true))
                egg.position = self.position + CGPoint(x: 0, y: -10)
                homeScene.addChild(egg)
                _sinceStart = 0
            }
            
        }
        get{return _sinceStart}
    }
    
    var forRemove: TimeInterval = 0
    
    init(scene: GameScene){
        let texture = SKTexture(imageNamed: "bird_1")
        super.init(texture: texture, color: .clear, size: CGSize(width: 30, height: 20))
        self.zPosition = 500
        self.name = "bird"
        self.homeScene = scene
        self.sinceStart = 0
        let wait = SKAction.wait(forDuration: TimeInterval.random(in: 0..<1))
        self.run(SKAction.sequence([wait,SKAction(named: "birdFly")!]))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
}
