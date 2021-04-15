//
//  wordButton.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/5.
//

import Foundation
import SpriteKit

class WordButton: SKSpriteNode {
    
    var newTexture: SKTexture!
    var selectHandler: () -> Void = {print("word Button not implemented!")}
    
    init(name: String){
        switch name {
        case "enter":
            newTexture = SKTexture(imageNamed: "enterButton")
        case "leave":
            newTexture = SKTexture(imageNamed: "leaveButton")
        case "buy":
            newTexture = SKTexture(imageNamed: "buyButton")
        case "give":
            newTexture = SKTexture(imageNamed: "giveButton")
        default:
            break
        }
        
        super.init(texture: newTexture, color: .clear, size: CGSize(width: 60, height: 40))
        self.zPosition = 201
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectHandler()
    }
}
