//
//  SavingButton.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/21.
//

import Foundation
import SpriteKit
import SwiftyJSON

class DebugButton: SKSpriteNode {
    
    var homeScene: GameScene!
    
    init(scene: GameScene){
        
        let texture = SKTexture(imageNamed: "debugButton")
        super.init(texture: texture, color: .clear, size: CGSize(width: 30, height: 30))
        self.zPosition = 1000
        self.position = CGPoint(x: 640, y: 20)
        self.isUserInteractionEnabled = true
        self.homeScene = scene
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        resetData(dataName: "playerData1")
        resetData(dataName: "playerData2")
        resetData(dataName: "playerData3")
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
