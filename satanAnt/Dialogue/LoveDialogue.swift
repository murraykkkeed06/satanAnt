//
//  Dialogue.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/4.
//

import Foundation
import SpriteKit

class LoveDialogue: SKSpriteNode {

   
    
    init(){
        let texture = SKTexture(imageNamed: "love_1")
        super.init(texture: texture, color: .clear, size: CGSize(width: 20, height: 18))
        self.zPosition = 1
        self.name = "loveDialogue"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func start()  {
        self.run(SKAction(named: "loveAction")!)
    }
    
   
}
