//
//  LoadBoard.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/21.
//

import Foundation
import SpriteKit
import SwiftyJSON

class LoadBoard: SKSpriteNode {
    
    var homeScene: StartScene!
    
    init(scene: StartScene){
        let texture = SKTexture(imageNamed: "loadBoard")
        super.init(texture: texture, color: .clear, size: CGSize(width: 300, height: 300))
        self.zPosition = 100
        self.position = CGPoint(x: 333, y: 205) + CGPoint(x: 0, y: 200)
        
        let wait = SKAction.wait(forDuration: 1)
        
        self.run(SKAction.sequence([SKAction.run(rollDown),wait,SKAction.run(render)]))
        
        self.homeScene = scene
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func rollDown()  {
        let action = SKAction.move(to: CGPoint(x: 333, y: 205), duration: 1)
        action.timingMode = .easeOut
        self.run(action)
    }
    
    func render()  {
        
        if readData(dataName: "playerData1") != 0 {
            let cancelButton = LoadCancelButton(col: 1,scene: homeScene)
            let playButton = LoadPlayButton(col: 1, scene: homeScene)
            
            let label = SKLabelNode(fontNamed: "Chalkduster")
            let number = Int(getLevelFromData(dataName: "playerData1"))
            label.text =  "Lv " + "\(number)"
            label.position = CGPoint(x: 292, y: 271)
            label.zPosition = 101
            label.fontSize = 18
            label.name = "firstLabel"
            
            homeScene.addChild(cancelButton)
            homeScene.addChild(playButton)
            homeScene.addChild(label)
            
        }else{
            let playButton = LoadPlayButton(col: 1, scene: homeScene)
            
            let label = SKLabelNode(fontNamed: "Chalkduster")
            label.text =  "New"
            label.position = CGPoint(x: 292, y: 271)
            label.zPosition = 101
            label.fontSize = 18
            label.name = "firstLabel"
            
            homeScene.addChild(playButton)
            homeScene.addChild(label)
            
        }
        
        
        if readData(dataName: "playerData2") != 0 {
            let cancelButton = LoadCancelButton(col: 2,scene: homeScene)
            let playButton = LoadPlayButton(col: 2, scene: homeScene)
            
            let label = SKLabelNode(fontNamed: "Chalkduster")
            let number = Int(getLevelFromData(dataName: "playerData2"))
            label.text =  "Lv " + "\(number)"
            label.position = CGPoint(x: 292, y: 190)
            label.zPosition = 101
            label.fontSize = 18
            label.name = "secondLabel"
            
            homeScene.addChild(cancelButton)
            homeScene.addChild(playButton)
            homeScene.addChild(label)
            
        }else{
            let playButton = LoadPlayButton(col: 2, scene: homeScene)
            
            let label = SKLabelNode(fontNamed: "Chalkduster")
            label.text =  "New"
            label.position = CGPoint(x: 292, y: 190)
            label.zPosition = 101
            label.fontSize = 18
            label.name = "secondLabel"
            
            homeScene.addChild(playButton)
            homeScene.addChild(label)
            
        }
        
        
        
        if readData(dataName: "playerData3") != 0 {
            let cancelButton = LoadCancelButton(col: 3,scene: homeScene)
            let playButton = LoadPlayButton(col: 3, scene: homeScene)
            
            let label = SKLabelNode(fontNamed: "Chalkduster")
            let number = Int(getLevelFromData(dataName: "playerData3"))
            label.text =  "Lv " + "\(number)"
            label.position = CGPoint(x: 292, y: 130)
            label.zPosition = 101
            label.fontSize = 18
            label.name = "thirdLabel"
            
            homeScene.addChild(cancelButton)
            homeScene.addChild(playButton)
            homeScene.addChild(label)
            
        }else{
            let playButton = LoadPlayButton(col: 3, scene: homeScene)
            
            let label = SKLabelNode(fontNamed: "Chalkduster")
            label.text =  "New"
            label.position = CGPoint(x: 292, y: 130)
            label.zPosition = 101
            label.fontSize = 18
            label.name = "thirdLabel"
            
            homeScene.addChild(playButton)
            homeScene.addChild(label)
            
        }
        
    }
    
    
    func readData(dataName: String) -> Int {
        
        var time: Int!

        do {
            
            let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let path = URL(fileURLWithPath: dataName, relativeTo: directoryURL)

            let savedData = try Data(contentsOf: path)
            let json = try JSON(data: savedData)
            //print("\(json.count)")
            if let savingTime = json["savingTime"].int {
                time = savingTime
            }

            print("able to read file: \(dataName)")
        } catch {
            // Catch any errors
            print("Unable to read the file")
            time = 0
        }
        
        
        return time
        
        
    }
    
    
    func getLevelFromData(dataName: String) -> CGFloat {
        var level: CGFloat!
        do {
            
            let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let path = URL(fileURLWithPath: dataName, relativeTo: directoryURL)

            let savedData = try Data(contentsOf: path)
            let json = try JSON(data: savedData)
            //print("\(json.count)")
            if let levelData = json["level"].int {
               level = CGFloat(levelData)
            }

            print("able to read file: \(dataName)")
        } catch {
            // Catch any errors
            print("Unable to read the file")
        }

        return level
    }
    
}
