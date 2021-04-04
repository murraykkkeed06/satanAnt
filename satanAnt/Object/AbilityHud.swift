//
//  AbilityHud.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/4.
//

import Foundation
import SpriteKit

class AbilityHud: SKSpriteNode {
    var homeScene: GameScene!
    init(scene: GameScene){
        let texture = SKTexture(imageNamed: "abilityHud")
        super.init(texture: texture, color: .clear, size: CGSize(width: 20, height: 20))
        self.zPosition = 15
        self.position = CGPoint(x: 300, y: 120)
        self.homeScene = scene
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func open()  {
        self.run(SKAction.move(to: CGPoint(x: homeScene.frame.width/2, y: homeScene.frame.height/2), duration: 1))
        self.run(SKAction.scale(to: CGSize(width: 300, height: 300), duration: 1))
        homeScene.inDialogue = true
        
        let wait = SKAction.wait(forDuration: 1)
        self.run(SKAction.sequence([wait,SKAction.run(setupPoint)]))
        
    }
    
    func setupPoint() {
        let rangeButton = PlusButton(name: "rangeButton")
        rangeButton.position = CGPoint(x: 425, y: 255)
        homeScene.addChild(rangeButton)
        let speedButton = PlusButton(name: "speedButton")
        speedButton.position = CGPoint(x: 425, y: 210)
        homeScene.addChild(speedButton)
        let attackButton = PlusButton(name: "attackButton")
        attackButton.position = CGPoint(x: 425, y: 165)
        homeScene.addChild(attackButton)
        let healthButton = PlusButton(name: "healthButton")
        healthButton.position = CGPoint(x: 425, y: 115)
        homeScene.addChild(healthButton)
    }
}
