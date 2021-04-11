//
//  BulletHitPoint.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/6.
//

import Foundation
import SpriteKit
import AVFoundation

class BornEffect: SKSpriteNode {
    
    var AudioPlayer = AVAudioPlayer()
    var bornSound: NSURL!
    var homeScene: GameScene!
    
    init(scene: GameScene){
        let texutre = SKTexture(imageNamed: "bornEffect_1")
        super.init(texture: texutre, color: .clear, size: CGSize(width: 40, height: 20))
        self.zPosition = 1
        bornSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "bornSound", ofType: "wav")!)
        self.homeScene = scene
        start()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func start()  {
        let bornAction = SKAction(named: "bornEffect")!
        self.run(bornAction)
//
//        self.AudioPlayer = try! AVAudioPlayer(contentsOf: self.bornSound as URL)
//        self.AudioPlayer.volume = 0.5
//        self.AudioPlayer.numberOfLoops = -1
//        self.AudioPlayer.prepareToPlay()
//        self.AudioPlayer.play()
        homeScene.run(SKAction.playSoundFileNamed("bornSound.wav", waitForCompletion: true))
        
//        let wait = SKAction.wait(forDuration: 3)
//
//        let stop = SKAction.run({
//            self.removeAllActions()
//            self.isHidden = true
//            self.removeFromParent()
//        })
//        bornAction.duration = 3
        
       // self.run(SKAction.sequence([bornAction,wait,stop]))
        
    }
    
    
}
