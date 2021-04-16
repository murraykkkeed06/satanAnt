//
//  Poop.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/15.
//

import Foundation
import SpriteKit


class FlyingBird: Power {
    
    private var _sinceStart: TimeInterval!
    override var sinceStart: TimeInterval!{
        set{
            _sinceStart = newValue
            if _start && homeScene.isMonsterRoom && !homeScene.isDoorSet{
                
                _start = false
                
                self.useNumber -= 1
                homeScene.player.powerChanged = true
                
                let bornAction = SKAction.run({
                
                    let bird = Bird(scene: self.homeScene)
                    bird.position = CGPoint(x: CGFloat.random(in: 700..<800), y: CGFloat.random(in: 200..<360))
                    self.homeScene.addChild(bird)
                })
                let wait = SKAction.wait(forDuration: 0.1)
                
                homeScene.run(SKAction.repeat(SKAction.sequence([bornAction,wait]), count: 100))
                
                let umbrella = Umbrella()
                umbrella.position = homeScene.player.position + CGPoint(x: 0, y: 50)
                
                homeScene.addChild(umbrella)
 
                let waitAWhile = SKAction.wait(forDuration: 20)
                umbrella.run(SKAction.sequence([waitAWhile,SKAction.removeFromParent()]))
                
                //effect
 
                
            }
            
           
        }
        get{
            return _sinceStart
        }
    }
    
    private var _start: Bool!
    override var start: Bool!{
        set{
            _start = newValue
            if _start{
                _sinceStart = 0
            }
        }
        get{
            return _start
        }
    }
    
    init(){
        let texture = SKTexture(imageNamed: "flyingBird")
        super.init(texture: texture, color: .clear, size: CGSize(width: 20, height: 20))
        self.zPosition = 5
        self.type = .flyingBird
        self.name = "flyingBird"
        self._sinceStart = 0
        self.useNumber = 5
        self.start = false
    
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
