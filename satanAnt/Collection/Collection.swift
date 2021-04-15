//
//  Collection.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/15.
//

import Foundation
import SpriteKit


enum CollectionType: Int {
    case poop
    case ducky
    case truffle
    static func random() -> CollectionType{
        return CollectionType(rawValue: Int.random(in: 0..<3))!
    }
}

class Collection: SKSpriteNode {
    var type: CollectionType!
}

func fromType(type: CollectionType) -> Collection {
    
    var collection: Collection!
    switch type {
    case .poop:
        collection = Poop()
    case .ducky:
        collection = Ducky()
    case .truffle:
        collection = Truffle()
    }
    
    return collection
    
}


func bornCollection(num: Int, scene: GameScene, position: CGPoint)  {
    for _ in 0..<num {
        let collection = fromType(type: CollectionType.random())
        collection.position = position
        scene.addChild(collection)
    }
}

