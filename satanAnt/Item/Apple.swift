//
//  Potion.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/8.
//

import Foundation
import SpriteKit

class Apple: Item {
    
    var homeScene: GameScene!
    
    init(){
        let texture = SKTexture(imageNamed: "apple")
        super.init(texture: texture, color: .clear, size: CGSize(width: 20, height: 20))
        self.zPosition = 50
        self.name = "apple"
        self.price = 15
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func work(scene: GameScene)  {
        self.homeScene = scene
        self.removeFromParent()
        
        removeItemAndReset(homeScene: scene)
        
        homeScene.run(homeScene.eatSound)

        homeScene.player.health += 0.25
        homeScene.player.healthChanged = true
        
        
        
        
        
    }
    
}
