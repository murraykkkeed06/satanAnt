//
//  Egg.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/12.
//

import Foundation
import SpriteKit

class PlantDog: Hat {
    
    var plantSize = CGSize(width: 30, height: 36)
    var homeScene: GameScene!
    var oldHealthNum: CGFloat!
    
    
    private var _sinceStart: TimeInterval!
    override var sinceStart: TimeInterval!{
        set{
            _sinceStart = newValue
            if _sinceStart > 1{
                if let oldHealthNum = oldHealthNum{
                    if oldHealthNum - homeScene.player.health > 1{
                        explode()
                    }
                    print("\(homeScene.player.health-oldHealthNum)")
                    self.oldHealthNum = homeScene.player.health
                    _sinceStart = 0
                }
            }
            
            
            
            
        }
        get{
            return _sinceStart
        }
    }
    
    
    
    
    init(){
        let texture = SKTexture(imageNamed: "plantDog_1")
        super.init(texture: texture, color: .clear, size: plantSize)
        self.zPosition = 20
        self.name = "plantDog"
        self.run(SKAction(named: "plantDog")!)
        self.sinceStart = 0
//        
//        self.physicsBody = SKPhysicsBody(rectangleOf: plantSize)
//        self.physicsBody?.pinned = true
//        self.physicsBody?.affectedByGravity = false
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setup(scene: GameScene) {
        self.homeScene = scene
        oldHealthNum = homeScene.player.health
    }
    
    func explode()  {
        for monster in homeScene.monsterList{
            monster.beingHit(homeScene: homeScene, damage: 0.5)
        }
    }
    
   
    
}
