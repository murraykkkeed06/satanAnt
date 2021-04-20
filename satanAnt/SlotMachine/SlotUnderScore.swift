//
//  SlotUnderScore.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/20.
//

import Foundation
import SpriteKit


class SlotUnderScore: SKSpriteNode {
    
    init(){
        let texture = SKTexture(imageNamed: "slotUnderScore")
        super.init(texture: texture, color: .clear, size: CGSize(width: 10, height: 1))
        self.zPosition = 2
        self.name = "slotUnderScore"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
