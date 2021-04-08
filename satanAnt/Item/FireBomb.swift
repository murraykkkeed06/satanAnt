//
//  FireBomb.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/8.
//

import Foundation
import SpriteKit

class FireBomb: Item {
    
    var bombSize = CGSize(width: 20, height: 20)
    
    init(){
        let texture = SKTexture(imageNamed: "fireBomb_1")
        super.init(texture: texture, color: .clear, size: bombSize)
        self.run(SKAction(named: "bombFire")!)
        self.name = "fireBomb"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
