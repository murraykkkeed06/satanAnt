//
//  Potion.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/8.
//

import Foundation
import SpriteKit

class Potion: Item {
    
    init(){
        let texture = SKTexture(imageNamed: "potion")
        super.init(texture: texture, color: .clear, size: CGSize(width: 20, height: 30))
        self.zPosition = 5
        self.name = "potion"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
