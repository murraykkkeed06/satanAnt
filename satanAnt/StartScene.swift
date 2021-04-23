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
        let menuButton = BackButton()
        
        onePlayerButton.selectHandler = {
            let loadBoard = LoadBoard(scene: self)
            self.addChild(loadBoard)
        }
        
        twoPlayerButton.selectHandler = {
            
            let label = SKLabelNode(fontNamed: "Chalkduster")
            label.text = "no friend no need"
            label.fontSize = 25
            label.zPosition = 10
            label.position = twoPlayerButton.position + CGPoint(x: 0, y: 30)
            self.addChild(label)
            label.run(SKAction.sequence([SKAction.fadeAlpha(to: 0, duration: 5),SKAction.removeFromParent()]))
        }
        
        settingButton.selectHandler = {
            let label = SKLabelNode(fontNamed: "Chalkduster")
            label.text = "nothing to set"
            label.fontSize = 25
            label.zPosition = 10
            label.position = settingButton.position + CGPoint(x: 0, y: 30)
            self.addChild(label)
            label.run(SKAction.sequence([SKAction.fadeAlpha(to: 0, duration: 5),SKAction.removeFromParent()]))
        }
        
        staffButton.selectHandler = {
            let label = SKLabelNode(fontNamed: "Chalkduster")
            label.text = "murray"
            label.fontSize = 25
            label.zPosition = 10
            label.position = staffButton.position + CGPoint(x: 0, y: 30)
            self.addChild(label)
            label.run(SKAction.sequence([SKAction.fadeAlpha(to: 0, duration: 5),SKAction.removeFromParent()]))
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
        
        self.run(SKAction.sequence([firstAction,wait,secondAction,wait,thirdAction,wait,fourthAction,wait,fifthAction]))
        
        
        
        
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
       

    }
  
    
    
}
