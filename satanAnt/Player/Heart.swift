//
//  Heart.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/3/27.
//

import Foundation
import SpriteKit

class Heart: SKSpriteNode {
    
    init(number: CGFloat){
        var texture: SKTexture!
        switch number {
        case 1:
            texture = SKTexture(imageNamed: "heart_0")
        case 0.25:
            texture = SKTexture(imageNamed: "heart_3")
        case 0.5:
            texture = SKTexture(imageNamed: "heart_2")
        case 0.75:
            texture = SKTexture(imageNamed: "heart_1")
        default:
            break
        //print("heart not allowed!")
        }
        super.init(texture: texture, color: .clear, size: CGSize(width: 20, height: 20))
        self.zPosition = 5
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
