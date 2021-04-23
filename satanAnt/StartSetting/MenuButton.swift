//
//  OnePlayerButton.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/23.
//

import Foundation
import SpriteKit

class MenuButton: SKSpriteNode {
    
    var selectHandler: ()-> Void = {print("menu button press not implemnet!")}
    
    init(){
        let texture = SKTexture(imageNamed: "menuButton")
        super.init(texture: texture, color: .clear, size: CGSize(width: 100, height: 40))
        self.zPosition = 1
        self.alpha = 0
        self.position = CGPoint(x: 590, y: 35)
        self.name = "startButton"
        self.run(SKAction(named: "idle")!)
        self.run(SKAction.fadeAlpha(to: 1, duration: 3))
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectHandler()
    }
}
