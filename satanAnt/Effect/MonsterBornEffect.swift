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
    
    
    var bornSound: NSURL!
    var homeScene: GameScene!
    
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
       
        homeScene.run(SKAction.playSoundFileNamed("monsterShow.mp3", waitForCompletion: false))
        
        let bornAction = SKAction(named: "monsterBornEffect")!
        
        let wait = SKAction.wait(forDuration: 2)
        
        self.run(SKAction.sequence([bornAction,wait,SKAction.removeFromParent()]))
        
    }
    
    
}
