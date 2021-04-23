//
//  OnePlayerButton.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/23.
//

import Foundation
import SpriteKit

class SettingButton: SKSpriteNode {
    
    var selectHandler : ()->Void = { print("one player button not implemented! ")}
    
    
    init(){
        let texture = SKTexture(imageNamed: "settingButton")
        super.init(texture: texture, color: .clear, size: CGSize(width: 160, height: 60))
        self.zPosition = 1
        self.alpha = 0
        self.position = CGPoint(x: 333, y: 141)
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
