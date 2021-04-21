//
//  Record.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/21.
//

import Foundation
import SpriteKit
import SwiftyJSON

class Record: SKSpriteNode {
    
    var homeScene: GameScene!
    
    init(scene: GameScene){
        
        let texture = SKTexture(imageNamed: "record")
        super.init(texture: texture, color: .clear, size: CGSize(width: 40, height: 40))
        self.zPosition = 10
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
            
            let label = SKLabelNode(fontNamed: "Chalkduster")
            label.text = "Record Save !"
            label.fontSize = 32
            label.zPosition = 50
            label.position = self.position + CGPoint(x: 0, y: 30)
            homeScene.addChild(label)
            label.run(SKAction.sequence([SKAction.fadeAlpha(to: 0, duration: 5),SKAction.removeFromParent()]))
            
            
            
        } catch {
            // Catch any errors
            print(error.localizedDescription)
        }
        
        
    }
        
    
}
