//
//  Item.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/8.
//

import Foundation
import SpriteKit

enum ItemType: Int{
    case fireBomb
    case potion
    case apple
    case coke
    
    static func random() -> ItemType{
        return ItemType(rawValue: Int.random(in: 0..<4))!
    }
}

class Item : SKSpriteNode {
    var price: CGFloat!
    
    
    
    
    
}

func fromType(type: ItemType) -> Item {
    
    var item: Item!
    
    switch type {
    case .fireBomb:
        item = FireBomb()
    case .potion:
        item = Potion()
    case .apple:
        item = Apple()
    case .coke:
        item = Coke()
    }
    
    return item
}

func fromTypeTexture(type: ItemType) -> SKNode {
    
    
    
    var item: SKNode!
    
    switch type {
    case .fireBomb:
        let texture = SKTexture(imageNamed: "fireBomb_1")
        item = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 20, height: 20))
        item.name = "fireBombTexture"
        
    case .potion:
        let texture = SKTexture(imageNamed: "potion")
        item = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 20, height: 30))
        item.name = "potionTexture"
       
        
    case .apple:
        let texture = SKTexture(imageNamed: "apple")
        item = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 20, height: 20))
        item.name = "appleTexture"
        
        
    case .coke:
        let texture = SKTexture(imageNamed: "coke")
        item = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 10, height: 30))
        item.name = "cokeTexture"
        
        
    }
    
    item.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 30))
    item.physicsBody?.affectedByGravity = true
    item.physicsBody?.contactTestBitMask = 1 + 4
    item.physicsBody?.collisionBitMask = 2
    item.physicsBody?.categoryBitMask = 128
    item.physicsBody?.allowsRotation = false
    item.physicsBody?.mass = 0.5
    item.zPosition = 10
    return item
}

func bornItemTexture(num: Int, position: CGPoint, homeScene: GameScene) {
    
    for _ in 0..<num{
        
        homeScene.run(homeScene.landSound)
        
        let node = fromTypeTexture(type: ItemType.random())
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

func bornItemTexture(num: Int, position: CGPoint, homeScene: GameScene, type: ItemType) {
    
    for _ in 0..<num{
        
        homeScene.run(homeScene.landSound)
        
        let node = fromTypeTexture(type: type)
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

func removeItemAndReset(homeScene: GameScene){
    homeScene.player.itemList.remove(at: homeScene.player.inItemListNumber)
    
    if homeScene.player.inItemListNumber == homeScene.player.itemList.count{
        homeScene.player.inItemListNumber -= 1
    }
    
    //set player item to next in itemlist
    if homeScene.player.itemList.count > 0 {
        homeScene.player.item = homeScene.player.itemList[homeScene.player.inItemListNumber]
    }else {
        homeScene.player.item = nil
    }
    
    homeScene.player.itemChanged = true
}
