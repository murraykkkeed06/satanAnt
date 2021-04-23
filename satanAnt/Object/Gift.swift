//
//  Gift.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/23.
//

import Foundation
import SpriteKit

class Gift: SKSpriteNode {
    
    var onFloor = false
    
    init(){
        let texture = SKTexture(imageNamed: "gift")
        super.init(texture: texture, color: .clear, size: CGSize(width: 30, height: 30))
        self.zPosition = 10
        self.name = "gift"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
