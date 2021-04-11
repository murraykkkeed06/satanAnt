//
//  AttackPoint.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/3.
//

import Foundation
import SpriteKit

class AttackPoint: SKSpriteNode {
    
    init(){
        let texture = SKTexture(imageNamed: "attack_1")
        super.init(texture: texture, color: .clear, size: CGSize(width: 40, height: 40))
        self.zPosition = 11
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func startPoint()  {
        let start = SKAction(named: "attack")!
        self.run(SKAction.sequence([start,SKAction.removeFromParent()]))
    }
}
