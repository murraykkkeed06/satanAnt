//
//  SlotIcon.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/20.
//

import Foundation
import SpriteKit

enum SlotIconType: Int {
    case bell
    case cherries
    case clover
    case heart
    case horseShoe
    case lemon
    case melon
    case lucky7
    
    static func random() -> SlotIconType{
        
        return SlotIconType(rawValue: Int.random(in: 0..<2))!
        
    }
}


class SlotICon: SKSpriteNode {
    
    
    var type: SlotIconType!
    
    init(type: SlotIconType){
       
        var texture: SKTexture!
        switch type {
        case .bell:
            texture = SKTexture(imageNamed: "bell")
        case .cherries:
            texture = SKTexture(imageNamed: "cherries")
        case .clover:
            texture = SKTexture(imageNamed: "clover")
        case .heart:
            texture = SKTexture(imageNamed: "heart")
        case .horseShoe:
            texture = SKTexture(imageNamed: "horseshoe")
        case .lemon:
            texture = SKTexture(imageNamed: "lemon")
        case .melon:
            texture = SKTexture(imageNamed: "melon")
        case .lucky7:
            texture = SKTexture(imageNamed: "lucky7")
            
        }
        
        super.init(texture: texture, color: .clear, size: CGSize(width: 10, height: 10))
        self.type = type
        self.zPosition = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
