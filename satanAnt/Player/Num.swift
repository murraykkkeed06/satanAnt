//
//  Num.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/3/27.
//

import Foundation
import SpriteKit

class Num: SKSpriteNode {
    
    init(number: Int, size: Int){
        var texture: SKTexture!
        switch number {
        case 0:
            texture = SKTexture(imageNamed: "zero")
        case 1:
            texture = SKTexture(imageNamed: "one")
        case 2:
            texture = SKTexture(imageNamed: "two")
        case 3:
            texture = SKTexture(imageNamed: "three")
        case 4:
            texture = SKTexture(imageNamed: "four")
        case 5:
            texture = SKTexture(imageNamed: "five")
        case 6:
            texture = SKTexture(imageNamed: "six")
        case 7:
            texture = SKTexture(imageNamed: "seven")
        case 8:
            texture = SKTexture(imageNamed: "eight")
        case 9:
            texture = SKTexture(imageNamed: "nine")
        default:
            texture = SKTexture(imageNamed: "zero")
        }
        super.init(texture: texture, color: .clear, size: CGSize(width: size, height: size))
        self.zPosition = 8
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
