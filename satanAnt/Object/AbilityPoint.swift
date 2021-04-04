//
//  AbilityPoint.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/4.
//

import Foundation
import SpriteKit

class AbilityPoint: SKSpriteNode {
    
    init(color: String){
        var texture: SKTexture!
        
        switch color {
        case "purple":
            texture = SKTexture(imageNamed: "point_purple")
        case "red":
            texture = SKTexture(imageNamed: "point_red")
        case "white":
            texture = SKTexture(imageNamed: "point_white")
        case "green":
            texture = SKTexture(imageNamed: "point_green")
        default:
            break
        }
        
        super.init(texture: texture, color: .clear, size: CGSize(width: 20, height: 20))
        self.zPosition = 16
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
