//
//  AttackPoint.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/3.
//

import Foundation
import SpriteKit

class CanonFirePoint: SKSpriteNode {
    
    init(){
        let texture = SKTexture(imageNamed: "canonFire_1")
        super.init(texture: texture, color: .clear, size: CGSize(width: 30, height: 30))
        self.zPosition = 2
        startPoint()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func startPoint()  {
        let start = SKAction(named: "canonFirePoint")!
        self.run(SKAction.sequence([start,SKAction.removeFromParent()]))
    }
}

