//
//  Dialogue.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/4.
//

import Foundation
import SpriteKit

class Dialogue: SKSpriteNode {

    var selectHandler: ()-> Void = {print("dialogue touch not implemented!")}
    
    var dialogueType: String!
    
    init(dialogueType: String){
        var texture: SKTexture!
        switch dialogueType {
        case "...":
            texture = SKTexture(imageNamed: "dialogue_1")
        case "surprise":
            texture = SKTexture(imageNamed: "suprise_1")
        default:
            texture = SKTexture(imageNamed: "dialogue_1")
        }
        super.init(texture: texture, color: .clear, size: CGSize(width: 30, height: 20))
        self.zPosition = 5
        self.isUserInteractionEnabled = true
        self.dialogueType = dialogueType
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func start()  {
        switch dialogueType {
        case "...":
            self.run(SKAction(named: "dialogueRun")!)
        case "surprise":
            self.run(SKAction(named: "surpriseAction")!)
        default:
            self.run(SKAction(named: "dialogueRun")!)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectHandler()
    }
}
