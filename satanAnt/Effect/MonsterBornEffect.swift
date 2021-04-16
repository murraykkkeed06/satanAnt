//
//  BulletHitPoint.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/6.
//

import Foundation
import SpriteKit
import AVFoundation

class MonsterBornEffect: SKSpriteNode {
    
    
    
    var homeScene: GameScene!
    let bornAction = SKAction(named: "monsterBornEffect")!
    
    init(scene: GameScene){
        let texutre = SKTexture(imageNamed: "bornEffect_1")
        super.init(texture: texutre, color: .clear, size: CGSize(width: 60, height: 60))
        self.zPosition = 1
        self.homeScene = scene
        start()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func start()  {
       
        homeScene.run(homeScene.monsterShowSound)
        
        
        
        let wait = SKAction.wait(forDuration: 2)
        
        self.run(SKAction.sequence([bornAction,wait,SKAction.removeFromParent()]))
        
    }
    
    
}
