//
//  Potion.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/8.
//

import Foundation
import SpriteKit

class Potion: Item {
    
    var homeScene: GameScene!
    
    
    init(){
        let texture = SKTexture(imageNamed: "potion")
        super.init(texture: texture, color: .clear, size: CGSize(width: 20, height: 30))
        self.zPosition = 50
        self.name = "potion"
        self.price = 30
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func work(scene: GameScene)  {
        self.homeScene = scene
        self.removeFromParent()
   
        removeItemAndReset(homeScene: scene)
//        let bigger = SKAction.scale(to: CGSize(width: 50, height: 50), duration: 1)
//        let wait = SKAction.wait(forDuration: 5)
//        let smaller = SKAction.scale(to: CGSize(width: 28, height: 34), duration: 1)
//
        let workAction = SKAction.sequence([SKAction.scale(to: CGSize(width: 50, height: 50), duration: 1),SKAction.wait(forDuration: 5),SKAction.scale(to: CGSize(width: 28, height: 34), duration: 1)])
        homeScene.run(homeScene.biggerSound)
        
       
        //remove player.item
        
        homeScene.player.run(workAction)
        
        
        
        
        
    }
    
}
