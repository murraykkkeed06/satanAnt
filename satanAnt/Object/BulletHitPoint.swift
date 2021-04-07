//
//  BulletHitPoint.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/6.
//

import Foundation
import SpriteKit
import AVFoundation

class BulletHitPoint: SKSpriteNode {
    
    var AudioPlayer = AVAudioPlayer()
    var hitSound: NSURL!
    var homeScene: GameScene!
    init(scene: GameScene){
        let texutre = SKTexture(imageNamed: "bulletHitPoint_1")
        super.init(texture: texutre, color: .clear, size: CGSize(width: 30, height: 30))
        self.zPosition = 5
        hitSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "fireHit", ofType: "mp3")!)
        self.homeScene = scene
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func hit()  {
        let hitAction = SKAction(named: "bulletHit")!
        //print("hit!")
//        self.AudioPlayer = try! AVAudioPlayer(contentsOf: self.hitSound as URL)
//        self.AudioPlayer.volume = 10
//        self.AudioPlayer.prepareToPlay()
        //self.AudioPlayer.play()
        let sound = SKAction.playSoundFileNamed("fireHit.mp3", waitForCompletion: false)
        homeScene.run(sound)
        
        self.run(SKAction.sequence([hitAction,SKAction.removeFromParent()]))
        
    }
    
    
}
