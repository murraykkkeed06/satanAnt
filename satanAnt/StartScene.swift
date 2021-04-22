//
//  MainMenu.swift
//  PeevedPenguin
//
//  Created by 劉孟學 on 2021/3/7.
//

import Foundation
import SpriteKit
import SwiftyJSON

class StartScene: SKScene {
    
    var lastUpdateTime: TimeInterval = 0
    var currentFPS: Double = 0
    
    var player: Player!

    override func didMove(to view: SKView) {
        
        player = Player()

        let loadBoard = LoadBoard(scene: self)
        addChild(loadBoard)
        
        

    }
    
    override func update(_ currentTime: TimeInterval) {
        //get fps
        let deltaTime = currentTime - lastUpdateTime
        currentFPS = 1 / deltaTime
        lastUpdateTime = currentTime
        print(currentFPS)
        
        //remove picture when load ok
        for node in self.children{
            if node.name == "loadingPicture" && currentFPS > 59{
                node.removeFromParent()
            }
        }
    }
  
    
    
}
