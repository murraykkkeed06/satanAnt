//
//  Potion.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/8.
//

import Foundation
import SpriteKit

class Coke: Item {
    
    var homeScene: GameScene!
    
    init(){
        let texture = SKTexture(imageNamed: "coke")
        super.init(texture: texture, color: .clear, size: CGSize(width: 10, height: 20))
        self.zPosition = 50
        self.name = "coke"
        self.price = 20
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func work(scene: GameScene)  {
        self.homeScene = scene
        self.removeFromParent()
        
        removeItemAndReset(homeScene: scene)
        
        
        homeScene.run(SKAction.playSoundFileNamed("bottle.wav", waitForCompletion: true))

        homeScene.player.health += 0.5
        homeScene.player.healthChanged = true
        
        
        
        
        
    }
    
}
