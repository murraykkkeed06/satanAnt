//
//  CancelButton.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/5.
//

import Foundation
import SpriteKit

class CancelButton: SKSpriteNode {
    
    var selectHandler: ()->Void = {print("cancel button touch not implemented!")}
    
    init(){
        let texture = SKTexture(imageNamed: "cancelButton")
        super.init(texture: texture, color: .clear, size: CGSize(width: 30, height: 30))
        self.zPosition = 50
        self.isUserInteractionEnabled = true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectHandler()
    }
}
