//
//  Drop.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/10.
//

import Foundation
import SpriteKit

enum DropType: Int {
    case heartDrop
    case coinDrop
    
    static func random() -> DropType{
        return DropType(rawValue: Int.random(in: 0..<2))!
    }
}

class Drop: SKSpriteNode {
    
    func pickUpEffect(homeScene: GameScene)  {
        
    }
    
}


func fromType(type: DropType) -> Drop {
    
    var drop: Drop!
    
    switch type {
    case .coinDrop:
        drop = CoinDrop()
    case .heartDrop:
        drop = HeartDrop()
    }
    
    return drop
}


func bornDrop(num: Int, position: CGPoint, homeScene: GameScene) {
    
    for _ in 0..<num{
        
        homeScene.run(homeScene.landSound)
        
        let node = fromType(type: DropType.random())
        node.position = position
        homeScene.addChild(node)
        
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
    

    
}

func bornDrop(num: Int, position: CGPoint, homeScene: GameScene, type: DropType) {
    
    for _ in 0..<num{
        
        homeScene.run(homeScene.landSound)
        
        let node = fromType(type: type)
        node.position = position
        homeScene.addChild(node)
        
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
    

    
}

