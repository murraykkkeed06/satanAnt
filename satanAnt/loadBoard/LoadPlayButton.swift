//
//  LoadCancelButton.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/21.
//

import Foundation
import SpriteKit
import SwiftyJSON

class LoadPlayButton: SKSpriteNode {
    
    var col: Int!
    var homeScene: StartScene!
    
    init(col: Int, scene: StartScene){
        let texture = SKTexture(imageNamed: "loadPlayButton")
        super.init(texture: texture, color: .clear, size: CGSize(width: 62, height: 27))
        self.zPosition = 101
        self.isUserInteractionEnabled = true
        self.col = col
        self.homeScene = scene
        
        switch col {
        case 1:
            self.position = CGPoint(x: 352, y: 271)
        case 2:
            self.position = CGPoint(x: 352, y: 200)
        case 3:
            self.position = CGPoint(x: 352, y: 135)
        default:
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch col {
        case 1:
            loadDataFromDataName(dataName: "playerData1")
        case 2:
            loadDataFromDataName(dataName: "playerData2")
        case 3:
            loadDataFromDataName(dataName: "playerData3")
        default:
            break
        }
    }
    
    
    func loadDataFromDataName(dataName: String) {
        do {
            
            let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let path = URL(fileURLWithPath: dataName, relativeTo: directoryURL)

            let savedData = try Data(contentsOf: path)
            let json = try JSON(data: savedData)
            //print("\(json.count)")
            if let savingTime = json["savingTime"].int {
                homeScene.player.savingTime = savingTime
            }
               
            if let attackPoint = json["attackPoint"].int {
                homeScene.player.baseAttackPoint = CGFloat(attackPoint)
            }

            if let bulletSpeedPoint = json["bulletSpeedPoint"].int {
                homeScene.player.baseBulletSpeedPoint = TimeInterval(bulletSpeedPoint)
            }
            if let healthPoint = json["healthPoint"].int {
                homeScene.player.baseHealthPoint = CGFloat(healthPoint)
            }
            if let rangePoint = json["rangePoint"].int {
                homeScene.player.baseBulletRangePoint = CGFloat(rangePoint)
            }
            if let level = json["level"].int {
                homeScene.player.level = CGFloat(level)
            }
                
            

            print("able to read file: \(dataName)")
        } catch {
            // Catch any errors
            print("Unable to read the file")
            
            
            
        }
        
        homeScene.player.saveDataTo = dataName
        moveToRoom()

    }
    
    func moveToRoom()  {
        if let view = homeScene.view {
            if let scene = GameScene.level(4) {
                homeScene.player.roomScene = scene

                scene.scaleMode = .aspectFit
                scene.isBedRoom = true
                scene.player = homeScene.player
                scene.player.position = CGPoint(x: 160, y: 250)

                

                    // Present the scene
                view.presentScene(scene)


                view.ignoresSiblingOrder = true

                view.showsFPS = true
                view.showsNodeCount = true
            }
        }
    }
    
}
