//
//  PetEgg.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/14.
//

import Foundation
import SpriteKit

enum PetEggType: Int {
    case chicken
    case cat
    
    static func random()->PetEggType{
        return PetEggType(rawValue: Int.random(in: 0..<2))!
    }
    
}


class PetEgg:  SKSpriteNode{
    
    
}


func fromTypeTexture(type: PetEggType) -> SKNode {
    
    var result: SKNode!
    
    switch type {
    case .chicken:
        result = SKSpriteNode(texture: SKTexture(imageNamed: "egg"), color: .clear, size: CGSize(width: 15, height: 20))
        result.name = "chickenEggTexture"
    case .cat:
        result = SKSpriteNode(texture: SKTexture(imageNamed: "catEgg"), color: .clear, size: CGSize(width: 15, height: 20))
        result.name = "catEggTexture"

    }
    
    result.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 15, height: 20))
    result.physicsBody?.contactTestBitMask = 1
    result.physicsBody?.collisionBitMask = 2
    result.physicsBody?.allowsRotation = false
    result.physicsBody?.affectedByGravity = false
    result.zPosition = 10
    return result
}


func bornPetEggTexture(num: Int, position: CGPoint, homeScene: GameScene) {
    
    for _ in 0..<num{
        
        homeScene.run(SKAction.playSoundFileNamed("land.wav", waitForCompletion: false))
        
        let node = fromTypeTexture(type: PetEggType.random())
        node.position = position.randomPointInDistamce(distance: 30)
        homeScene.addChild(node)
        
        shootUp(node: node)
        
        

    }
    

    
}