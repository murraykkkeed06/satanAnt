//
//  SavingButton.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/21.
//

import Foundation
import SpriteKit
import SwiftyJSON

class PauseButton: SKSpriteNode {
    
    var homeScene: GameScene!
    
    init(scene: GameScene){
        
        let texture = SKTexture(imageNamed: "pauseButton")
        super.init(texture: texture, color: .clear, size: CGSize(width: 44, height: 16))
        self.zPosition = 1000
        self.position = CGPoint(x: 626, y: 349)
        self.isUserInteractionEnabled = true
        self.homeScene = scene
        self.run(SKAction(named: "idle")!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
//        let gray = SKAction.colorize(with: .gray, colorBlendFactor: 1, duration: 1)
//
//        for node in homeScene.children{
//            //node.run(gray)
//
//        }
//
//        let menuButton = MenuButton(scene: homeScene)
//        let playButton = PlayButton(scene: homeScene)
        //homeScene.isPaused = true
//        for node in homeScene.children{
//            node.isPaused = true
//        }
        
        let firstAction = SKAction.run({
//        
//            let menuButton = MenuButton(scene: self.homeScene)
//            let playButton = PlayButton(scene: self.homeScene)
//            self.homeScene.addChild(menuButton)
//            self.homeScene.addChild(playButton)
            self.homeScene.menuButton.isHidden = false
            self.homeScene.playButton.isHidden = false
            
        })
        
        let wait = SKAction.wait(forDuration: 0.1)
        
        let secondAction = SKAction.run({
            self.homeScene.view?.isPaused = true
        })
       
        self.run(SKAction.sequence([firstAction,wait,secondAction]))
//        homeScene.addChild(menuButton)
//        homeScene.addChild(playButton)
        
        
    }
    
    
}

