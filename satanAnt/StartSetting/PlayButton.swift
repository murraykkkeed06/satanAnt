//
//  SavingButton.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/21.
//

import Foundation
import SpriteKit
import SwiftyJSON

class PlayButton: SKSpriteNode {
    
    var homeScene: GameScene!
    
    init(scene: GameScene){
        
        let texture = SKTexture(imageNamed: "pausePlayButton")
        super.init(texture: texture, color: .clear, size: CGSize(width: 190, height: 70))
        self.zPosition = 1000
        self.position = CGPoint(x: 316, y: 172)
       // self.isUserInteractionEnabled = true
        self.homeScene = scene
        self.name = "playButton"
        self.run(SKAction(named: "idle")!)
        self.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        
    }
    
    func work() {
        self.isHidden = true
        for node in homeScene.children{
            if node.name == "menuButton"{
                node.isHidden = true
            }
        }
        self.homeScene.view?.isPaused = false
    }
    
    
}

