//
//  Box.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/4.
//

import Foundation
import SpriteKit

class Box: SKSpriteNode {
    
    var selectHandler: () -> Void = {print("box touch not implemented!")}
    
    init(){
        let texture = SKTexture(imageNamed: "box_1")
        super.init(texture: texture, color: .clear, size: CGSize(width: 40, height: 30))
        self.zPosition = 1
        self.isUserInteractionEnabled = true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func open()  {
        self.run(SKAction(named: "boxOpen")!)
    }
    
    func close()  {
        self.run(SKAction(named: "boxClose")!)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectHandler()
    }
}
