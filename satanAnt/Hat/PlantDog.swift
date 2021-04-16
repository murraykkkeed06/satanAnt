//
//  Egg.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/12.
//

import Foundation
import SpriteKit

class PlantDog: Hat {
    //5:6
    var plantSize = CGSize(width: 30, height: 36)
    var homeScene: GameScene!
    var oldHealthNum: CGFloat!
    
    
    private var _sinceStart: TimeInterval!
    override var sinceStart: TimeInterval!{
        set{
            _sinceStart = newValue
            if _sinceStart > 1{
                if let oldHealthNum = oldHealthNum{
                    if oldHealthNum - homeScene.player.health > 0.5{
                        explode()
                    }
                    //print("\(homeScene.player.health-oldHealthNum)")
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
        self.zPosition = 1
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
        
        self.homeScene.run(homeScene.plantDogScreamSound)
        
        //laser eye
        let bigger = SKAction.scale(to: CGSize(width: 120, height: 144), duration: 0.5)
        let smaller = SKAction.scale(to: CGSize(width: 30, height: 36), duration: 0.5)
        
        let laserEffect = SKAction.run {
            let laserEyeLeft = SKSpriteNode(texture: SKTexture(imageNamed: "laserEye"), color: .clear, size: CGSize(width: 10, height: 10))
            let laserEyeRight = SKSpriteNode(texture: SKTexture(imageNamed: "laserEye"), color: .clear, size: CGSize(width: 10, height: 10))
            laserEyeLeft.zPosition = 1
            laserEyeLeft.position = CGPoint(x: -5, y: 10)
            laserEyeRight.zPosition = 1
            laserEyeRight.position = CGPoint(x: 5, y: 10)
            self.addChild(laserEyeLeft)
            self.addChild(laserEyeRight)
            let scaleAction = SKAction.scale(to: CGSize(width: 50, height: 50), duration: 0.2)
            laserEyeLeft.run(SKAction.sequence([scaleAction,SKAction.removeFromParent()]))
            laserEyeRight.run(SKAction.sequence([scaleAction,SKAction.removeFromParent()]))
            
        }
        
        
        self.run(SKAction.sequence([bigger,laserEffect,smaller]))
        
        for monster in homeScene.monsterList{
            monster.beingHit(homeScene: homeScene, damage: 1)
        }
    }
    
    
    
}
