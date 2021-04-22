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
   
    var player: Player!

    override func didMove(to view: SKView) {
        
        player = Player()

//        let loadBoard = LoadBoard(scene: self)
//        addChild(loadBoard)
        
        

    }
    
    override func update(_ currentTime: TimeInterval) {
       

    }
  
    
    
}
