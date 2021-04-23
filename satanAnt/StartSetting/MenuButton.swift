//
//  SavingButton.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/21.
//

import Foundation
import SpriteKit
import SwiftyJSON

class MenuButton: SKSpriteNode {
    
    var homeScene: GameScene!
    
    init(scene: GameScene){
        
        let texture = SKTexture(imageNamed: "menuButton")
        super.init(texture: texture, color: .clear, size: CGSize(width: 190, height: 70))
        self.zPosition = 1000
        self.position = CGPoint(x: 317, y: 264)
        //self.isUserInteractionEnabled = true
        self.homeScene = scene
        self.name = "menuButton"
        self.run(SKAction(named: "idle")!)
        self.isHidden = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    
    func work()  {
        
        self.homeScene.view?.isPaused = false
        
        if let view = homeScene.view {
            
            if let scene = StartScene(fileNamed: "StartScene"){
                
                let fade = SKTransition.fade(withDuration: 1)
                
                scene.scaleMode = .aspectFit
                view.presentScene(scene, transition: fade)
                view.ignoresSiblingOrder = true
                view.showsFPS = true
                view.showsNodeCount = true
               
            }
        }
        
        
    }
    
    
}

