//
//  Poop.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/15.
//

import Foundation
import SpriteKit


class HealthGainer: Power {
    private var _sinceStart: TimeInterval!
    override var sinceStart: TimeInterval!{
        set{
            _sinceStart = newValue
            if _start && _sinceStart > 20{
                
                _sinceStart = 0
                
                self.useNumber -= 1
                homeScene.player.powerChanged = true
                
                homeScene.player.health += 1
                homeScene.player.healthChanged = true
                
                //effect 
                let sound = SKAction.playSoundFileNamed("heal.mp3", waitForCompletion: false)
                homeScene.run(sound)
                
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
        let texture = SKTexture(imageNamed: "healthGainer")
        super.init(texture: texture, color: .clear, size: CGSize(width: 20, height: 20))
        self.zPosition = 5
        self.type = .healthGainer
        self.name = "healthGainer"
        self._sinceStart = 0
        self.useNumber = 20
        self.start = false
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
