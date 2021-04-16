//
//  Break.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/14.
//

import Foundation
import SpriteKit

enum BreakType: Int {
    case stone
    case bucket
    case stock
    case van
    
    static func random() -> BreakType{
        return BreakType(rawValue: Int.random(in: 0..<4))!
    }
}

class Break: SKSpriteNode {
    
    var hitTime:Int = 0
    
    func beingHit(scene: GameScene)  {
        hitTime += 1
        if hitTime > 3{
            let dieAction = SKAction(named: "monsterDie")!
            self.run(SKAction.sequence([dieAction,SKAction.removeFromParent()]))
            
            if Int.random(in: 0..<100)<1{
                
                let hole = SKSpriteNode(texture: SKTexture(imageNamed: "hole"), color: .clear, size: CGSize(width: 15, height: 15))
                hole.zPosition = 1
                hole.name = "hole"
                hole.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 20))
                hole.physicsBody?.pinned = true
                hole.physicsBody?.contactTestBitMask = 2
                hole.position = self.position
                
                scene.addChild(hole)
            }
            
        }
        
        let black = SKAction.colorize(with: .black, colorBlendFactor: 1, duration: 0.1)
        let clear = SKAction.colorize(with: .black, colorBlendFactor: 0, duration: 0.1)
    
        self.run(SKAction.sequence([black,clear]))
        
        
        
    }
    func beingHit(scene: GameScene, hit: Int)  {
        hitTime += hit
        if hitTime > 3{
            let dieAction = SKAction(named: "monsterDie")!
            self.run(SKAction.sequence([dieAction,SKAction.removeFromParent()]))
            
            if Int.random(in: 0..<100)<1{
                
                let hole = SKSpriteNode(texture: SKTexture(imageNamed: "hole"), color: .clear, size: CGSize(width: 15, height: 15))
                hole.zPosition = 1
                hole.name = "hole"
                hole.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 20))
                hole.physicsBody?.pinned = true
                hole.physicsBody?.contactTestBitMask = 2
                hole.position = self.position
                
                scene.addChild(hole)
            }
            
        }
        
        let black = SKAction.colorize(with: .black, colorBlendFactor: 1, duration: 0.1)
        let clear = SKAction.colorize(with: .black, colorBlendFactor: 0, duration: 0.1)
    
        self.run(SKAction.sequence([black,clear]))
        
        
        
    }
}


func fromType(type: BreakType) -> Break {
    
    var result: Break!
    
    switch type {
    case .bucket:
        result = Bucket()
    case .van:
        result = Van()
    case .stock:
        result = Stock()
    case .stone:
        result = Stone()
    }
    
    return result
}

func bornBreak(num: Int, homeScene: GameScene)  {
    
    for _ in 0..<num{
        
        var newX = CGFloat.random(in: 50..<homeScene.frame.width-50)
        var newY = CGFloat.random(in: 50..<homeScene.frame.height-50)
        
        while homeScene.atPoint(CGPoint(x: newX, y: newY)).physicsBody != nil {
            newX = CGFloat.random(in: 50..<homeScene.frame.width-50)
            newY = CGFloat.random(in: 50..<homeScene.frame.height-50)
        }
        
        let stuff = fromType(type: BreakType.random())
        stuff.position = CGPoint(x: newX, y: newY)
        homeScene.addChild(stuff)
        
    }
    
    
    
}
