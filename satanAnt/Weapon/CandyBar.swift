//
//  CandyBar.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/10.
//

import Foundation
import SpriteKit

class CandyBar: Weapon {
    init(){
        
        
        let texture = SKTexture(imageNamed: "candyBar")
        super.init(texture: texture, color: .clear, size: CGSize(width: 40, height: 24))
        self.name = "candyBar"
        self.zPosition = 3
        self.attackPoint = 0.25
        self.weaponType = .candyBar
        
       
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func rAttack(direction: CGPoint, homeScene: GameScene) {
        
        homeScene.player.health += 1
        homeScene.player.healthChanged = true
       
        homeScene.run(SKAction.playSoundFileNamed("heal.mp3", waitForCompletion: true))
        let healEffect = SKEmitterNode(fileNamed: "healParticle")!
        healEffect.name = "heal"
        healEffect.position = homeScene.player.position
        homeScene.addChild(healEffect)
        healEffect.run(SKAction.sequence([SKAction.wait(forDuration: 3),SKAction.removeFromParent()]))
        
        
    }
    
    override func attack(direction: CGPoint, homeScene: GameScene) {
        if homeScene.player.sinceFire < 0.3 {return}
        homeScene.player.sinceFire = 0
        
        if let bornPoint = homeScene.weaponOnHand.childNode(withName: "bornPoint"){
            let position = homeScene.weaponOnHand.convert(bornPoint.position, to: homeScene)
            let candy = Candy(position: position ,homeScene: homeScene,force: 100 ,bulletSize: CGSize(width: 20, height: 20))
            homeScene.addChild(candy)
            candy.flyTo(direction: direction)
            
            let sound = SKAction.playSoundFileNamed("candyBarAttack.wav", waitForCompletion: false)
            homeScene.run(sound)
            
            
        }
        
    }
    
    override func attack(degree: CGFloat, homeScene: GameScene) {
        
    }
    
}
