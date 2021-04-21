//
//  LoadCancelButton.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/21.
//

import Foundation
import SpriteKit
import SwiftyJSON

class LoadCancelButton: SKSpriteNode {
    
    var col: Int!
    var homeScene: StartScene!
    
    init(col: Int, scene: StartScene){
        let texture = SKTexture(imageNamed: "loadCancelButton")
        super.init(texture: texture, color: .clear, size: CGSize(width: 30, height: 30))
        self.zPosition = 101
        self.isUserInteractionEnabled = true
        self.col = col
        self.homeScene = scene
        
        switch col {
        case 1:
            self.position = CGPoint(x: 404, y: 295)
        case 2:
            self.position = CGPoint(x: 404, y: 218)
        case 3:
            self.position = CGPoint(x: 404, y: 151)
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
            resetData(dataName: "playerData1")
            for node in homeScene.children{
                if node.name == "firstLabel"{
                    let label = node as! SKLabelNode
                    label.text = "New"
                }
            }
        case 2:
            resetData(dataName: "playerData2")
            for node in homeScene.children{
                if node.name == "secondLabel"{
                    let label = node as! SKLabelNode
                    label.text = "New"
                }
            }
        case 3:
            resetData(dataName: "playerData3")
            for node in homeScene.children{
                if node.name == "thirdLabel"{
                    let label = node as! SKLabelNode
                    label.text = "New"
                }
            }
        default:
            break
        }
        self.removeFromParent()
    }
    
    
    func resetData(dataName: String)  {
        let jsonObject: [String: Any] = [
            "name" : "player",
            "level" : 3,
            "savingTime" : 0,
            "attackPoint": 0,
            "bulletSpeedPoint" : 0,
            "healthPoint" : 0,
            "rangePoint" : 0
        ]
        
        let json = JSON(jsonObject)
        let str = json.description
        let data = str.data(using: .utf8)!
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)[0].appendingPathComponent(dataName)
        
        
        //write
        do {
            try data.write(to: path)
            print("File saved: \(path.absoluteURL)")
        } catch {
            // Catch any errors
            print(error.localizedDescription)
        }
    }
}
