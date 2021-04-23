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


        
        let onePlayerButton = OnePlayerButton()
        let twoPlayerButton = TwoPlayerButton()
        let settingButton = SettingButton()
        let staffButton = StaffButton()
        let menuButton = MenuButton()
        
        onePlayerButton.selectHandler = {
            let loadBoard = LoadBoard(scene: self)
            self.addChild(loadBoard)
        }
        
        menuButton.selectHandler = {
            for node in self.children{
                if node.name != "startButton" && node.name != "startScene"{
                    node.removeFromParent()
                }
            }
        }
        
        
  
       
        let wait = SKAction.wait(forDuration: 0.5)
        
        let firstAction = SKAction.run({
            self.addChild(onePlayerButton)
        })
        let secondAction = SKAction.run({
            self.addChild(twoPlayerButton)
        })
        let thirdAction = SKAction.run({
            self.addChild(settingButton)
        })
        let fourthAction = SKAction.run({
            self.addChild(staffButton)
        })
        let fifthAction = SKAction.run({
            self.addChild(menuButton)
        })
        
        self.run(SKAction.sequence([wait,firstAction,wait,secondAction,wait,thirdAction,wait,fourthAction,wait,fifthAction]))
        
        
        
        
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
       

    }
  
    
    
}
