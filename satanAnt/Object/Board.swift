//
//  wordButton.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/5.
//

import Foundation
import SpriteKit

class Board: SKSpriteNode {
    
    var newTexture: SKTexture!
    var selectHandler: () -> Void = {print("board not implemented!")}
    var boardSize = CGSize(width: 60, height: 50)
    
    init(name: String){
        switch name {
        case "home":
            newTexture = SKTexture(imageNamed: "homeBoard")
        case "continue":
            newTexture = SKTexture(imageNamed: "continueBoard")
        default:
            break
        }
        
        super.init(texture: newTexture, color: .clear, size: boardSize)
        self.zPosition = 21
        self.isUserInteractionEnabled = true
        self.physicsBody = SKPhysicsBody(rectangleOf: boardSize)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.pinned = true
        self.physicsBody?.allowsRotation = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectHandler()
    }
}

