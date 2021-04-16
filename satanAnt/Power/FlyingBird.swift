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
            if _start && _sinceStart > 5{
                
                _sinceStart = 0
                
                self.useNumber -= 1
                homeScene.player.powerChanged = true
                
             
                
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
        self.useNumber = 3
        self.start = false
    
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
