//
//  Poop.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/15.
//

import Foundation
import SpriteKit


class HalfMonster: Power {
    
    private var _sinceStart: TimeInterval!
    override var sinceStart: TimeInterval!{
        set{
            _sinceStart = newValue
            if _start && homeScene.isMonsterRoom && !homeScene.isDoorSet{
                
                _start = false
                
                self.useNumber -= 1
                homeScene.player.powerChanged = true
                
                let wait = SKAction.wait(forDuration: 5)
                let setAction = SKAction.run({
                    for i in 0..<self.homeScene.monsterList.count/2{
                        self.homeScene.monsterList[i].beingHit(homeScene: self.homeScene, damage: 10)
                    }
                })
                
                homeScene.run(SKAction.sequence([wait,setAction]))
                
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
        let texture = SKTexture(imageNamed: "halfMonster")
        super.init(texture: texture, color: .clear, size: CGSize(width: 20, height: 20))
        self.zPosition = 5
        self.type = .halfMonster
        self.name = "halfMonster"
        self._sinceStart = 0
        self.useNumber = 3
        self.start =  false
       
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
