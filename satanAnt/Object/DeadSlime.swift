//
//  Tomb.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/4.
//

import Foundation
import SpriteKit

class DeadSlime: SKSpriteNode {
    init(){
        let texture = SKTexture(imageNamed: "slimeDie_1")
        super.init(texture: texture, color: .clear, size: CGSize(width: 25, height: 25))
        self.zPosition = 1
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func dieAction()  {
        self.run(SKAction(named: "slimeDie")!)
    }
}
