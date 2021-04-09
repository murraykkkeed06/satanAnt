//
//  FireBomb.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/8.
//

import Foundation
import SpriteKit

class FireBomb: Item {
    
    var bombSize = CGSize(width: 20, height: 20)
    var homeScene: GameScene!
    init(){
        let texture = SKTexture(imageNamed: "fireBomb_1")
        super.init(texture: texture, color: .clear, size: bombSize)
        self.run(SKAction(named: "bombFire")!)
        self.name = "fireBomb_1"
        self.zPosition = 50
        self.physicsBody = SKPhysicsBody(circleOfRadius: bombSize.width/2)
        //self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.mass = 0.5
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func work(scene: GameScene)  {
        self.homeScene = scene
        self.removeFromParent()
        //remove in item list
        removeItemAndReset(homeScene: scene)
        
        //bomb throw and explode
        shoot()
        
        
        
    }
    
    func shoot() {
        
        self.position = homeScene.player.position + homeScene.player.facing * 20
        homeScene.addChild(self)
        
        if homeScene.player.facing.y > 0 {
            homeScene.physicsWorld.gravity = CGVector(dx: 0, dy: -3);
        }else{
            homeScene.physicsWorld.gravity = CGVector(dx: 0, dy: -0.5);
        }
        
        let wait1 = SKAction.wait(forDuration: 0.3)
        let wait2 = SKAction.wait(forDuration: 5)
        self.run(SKAction.sequence([SKAction.run(up),wait1,SKAction.run(down),wait2,SKAction.run(explode),SKAction.removeFromParent()]))
        
    }
    
    func up()  {
        homeScene.run(SKAction.playSoundFileNamed("throw.wav", waitForCompletion: true))
        let force: CGFloat = 100
        // Apply an impulse at the vector.
        let v = CGVector(dx: homeScene.player.facing.x * force, dy: homeScene.player.facing.y * force)
        
        self.physicsBody?.applyImpulse(v)
        
        
    }
    func down()  {
        
//        self.physicsBody = nil
//        homeScene.physicsWorld.gravity = CGVector(dx: 0, dy: 0);
        self.physicsBody?.pinned = true
        let particle = SKEmitterNode(fileNamed: "popo")!
        addChild(particle)
        particle.position = CGPoint(x: 0, y: 10)
        let wait = SKAction.wait(forDuration: 5)
        let remove = SKAction.removeFromParent()
        let seq = SKAction.sequence([wait,remove])
        particle.zPosition = 1
        particle.run(seq)
        self.run(seq)
        self.run(SKAction(named: "bombFire")!)
        
    }
    
    func explode()  {
        
        homeScene.run(SKAction.playSoundFileNamed("explosion.wav", waitForCompletion: true))
        
        for monster in homeScene.monsterList{
            if monster.position.distanceTo(self.position) < 100{
                monster.beingHit()
            }
        }
        
    }
    
}
