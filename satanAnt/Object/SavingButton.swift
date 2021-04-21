//
//  SavingButton.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/21.
//

import Foundation
import SpriteKit
import SwiftyJSON

class SavingButton: SKSpriteNode {
    
    var homeScene: GameScene!
    
    init(scene: GameScene){
        
        let texture = SKTexture(imageNamed: "savingButton")
        super.init(texture: texture, color: .clear, size: CGSize(width: 30, height: 30))
        self.zPosition = 1000
        self.position = CGPoint(x: 640, y: 350)
        self.isUserInteractionEnabled = true
        self.homeScene = scene
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        homeScene.player.savingTime += 1
        let jsonObject: [String: Any] = [
            "name" : "player",
            "level" : Int(homeScene.player.level),
            "savingTime" : homeScene.player.savingTime,
            "attackPoint": Int(homeScene.player.baseAttackPoint),
            "bulletSpeedPoint" : Int(homeScene.player.baseBulletSpeedPoint),
            "healthPoint" : Int(homeScene.player.baseHealthPoint),
            "rangePoint" : Int(homeScene.player.baseBulletRangePoint)
        ]
        
        let json = JSON(jsonObject)
        let str = json.description
        let data = str.data(using: .utf8)!
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)[0].appendingPathComponent(homeScene.player.saveDataTo)
        
        
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
