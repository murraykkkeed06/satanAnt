//
//  Weapon.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/3/27.
//

import Foundation
import SpriteKit
import AVFoundation

enum WeaponType: Int {
    case staff
    case candyBar
    case sword
    case fishingRod
    
    static func random() -> WeaponType{
        return WeaponType(rawValue: Int.random(in: 0..<3))!
        //return WeaponType(rawValue: 3)!
    }
}


class Weapon: SKSpriteNode {
    
    var attackPoint: CGFloat!
    var attackSpeed: TimeInterval!
    var weaponType: WeaponType!
    var tempTime: TimeInterval!
    
    
    
    func rAttack(direction: CGPoint, homeScene: GameScene){
        
    }
    
    
    func attack(direction: CGPoint, homeScene: GameScene){
 
    }
    
    func reset(){}
    
    
    
    func attack(degree: CGFloat, homeScene: GameScene){
        
        
    }
    
}

func fromType(type: WeaponType) -> Weapon {
    
    var weapon: Weapon!
    
    switch type {
    case .staff:
        weapon = Staff()
    case .candyBar:
        weapon = CandyBar()
    case .sword:
        weapon = Sword()
    case .fishingRod:
        weapon = FishingRod()
    }
    
    return weapon
}

func fromTypeTexture(type: WeaponType) -> SKNode{
    
    var result: SKNode!
    
    switch type {
    case .staff:
        let texture = SKTexture(imageNamed: "staff")
        result = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 40, height: 24))
        result.name = "staffTexture"
        
     
    case .candyBar:
        let texture = SKTexture(imageNamed: "candyBar")
        result = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 40, height: 24))
        result.name = "candyBarTexture"
      
    case .sword:
        let texture = SKTexture(imageNamed: "sword")
        result = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 40, height: 24))
        result.name = "swordTexture"
        
    case .fishingRod:
        let texture = SKTexture(imageNamed: "fishingRod")
        result = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 40, height: 24))
        result.name = "fishingRodTexture"
        
    }
    result.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 40, height: 24))
    result.physicsBody?.affectedByGravity = false
    result.physicsBody?.contactTestBitMask = 1
    result.physicsBody?.collisionBitMask = 2
    result.physicsBody?.categoryBitMask = 512
    result.zPosition = 10
    return result
}

func bornWeaponTexture(num: Int, position: CGPoint, homeScene: GameScene) {
    
    for _ in 0..<num{
        
        //sound and born action
        
        let node = fromTypeTexture(type: WeaponType.random())
        node.position = position
        homeScene.addChild(node)
        shootUp(node: node)

        
    }
    
}

func shootUp(node: SKNode) {
    
    node.physicsBody?.affectedByGravity = true
    node.physicsBody?.mass = 0.5
        
    
    let wait = SKAction.wait(forDuration: 0.2)
    let up = SKAction.run({
        let force = CGFloat.random(in: 180..<220)
        // Apply an impulse at the vector.
        let v = CGVector(dx: CGFloat.random(in: -0.5..<0.5) * force, dy: CGFloat.random(in: 0.8..<1) * force)
        
        node.physicsBody?.applyImpulse(v)
        
    })
    let down = SKAction.run({
        node.physicsBody?.pinned = true
    })
    node.run(SKAction.sequence([up,wait,down]))
}

func shootWithDirection(node: SKNode, homeScene: GameScene) {
    
    if homeScene.player.facing.y > 0 {
        homeScene.physicsWorld.gravity = CGVector(dx: 0, dy: -3);
    }else{
        homeScene.physicsWorld.gravity = CGVector(dx: 0, dy: 0);
    }
    
    node.physicsBody?.affectedByGravity = true
    node.physicsBody?.mass = 0.5
        
    
    let wait = SKAction.wait(forDuration: 0.2)
    let up = SKAction.run({
        let force = CGFloat.random(in: 80..<120)
        // Apply an impulse at the vector.
        let v = CGVector(dx: homeScene.player.facing.x * force, dy: homeScene.player.facing.y * force)
        
        node.physicsBody?.applyImpulse(v)
        
    })
    let down = SKAction.run({
        node.physicsBody?.pinned = true
    })
    node.run(SKAction.sequence([up,wait,down]))
}
