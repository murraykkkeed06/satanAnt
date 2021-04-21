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
        
        readData()
    }
    func readData()  {
        
       
        
        do {
            // Get the saved data
            let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let path = URL(fileURLWithPath: "playerData", relativeTo: directoryURL)

            let savedData = try Data(contentsOf: path)
            let json = try JSON(data: savedData)
            //print("\(json.count)")
            if let savingTime = json["savingTime"].int {
                //Now you got your value
                print("\(savingTime)")

            }
            print("able to read file!")
        } catch {
            // Catch any errors
            print("Unable to read the file")
        }
        
        
        
        
        
    }
    
}
