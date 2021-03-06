//
//  PlusButton.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/5.
//

import Foundation
import SpriteKit

class PlusButton: SKSpriteNode {
    
    var selectHandler: ()->Void = {print("plusButton touch not implemented!")}
    var homeScene: GameScene!
    
    init(name: String){
        let texture = SKTexture(imageNamed: "pressButton")
        super.init(texture: texture, color: .clear, size: CGSize(width: 30, height: 30))
        self.zPosition = 20
        self.isUserInteractionEnabled = true
        self.name = name
        self.alpha = 1
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectHandler()
    }
}
