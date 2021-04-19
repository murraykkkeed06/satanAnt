//
//  CandyBar.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/10.
//

import Foundation
import SpriteKit

class FishingRod: Weapon {
    
    var isFishing = false
    
    init(){
        
        
        let texture = SKTexture(imageNamed: "fishingRod")
        super.init(texture: texture, color: .clear, size: CGSize(width: 40, height: 14))
        self.name = "fishingRod"
        self.zPosition = 2
        self.attackPoint = 0.25
        self.weaponType = .fishingRod
        
        
       
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func rAttack(direction: CGPoint, homeScene: GameScene) {
        
       
        
    }
    
    override func attack(direction: CGPoint, homeScene: GameScene) {
        if homeScene.player.sinceFire < 0.3 {return}
        homeScene.player.sinceFire = 0
        
        
        if isFishing{
            for node in self.children{
                if node.name == "fishingLine"{
                    node.removeFromParent()
                }
            }
            isFishing = false
            return
        }else{
            isFishing = true
        }
        
        if let bornPoint = homeScene.weaponOnHand.childNode(withName: "bornPoint"){
            let position = homeScene.weaponOnHand.convert(bornPoint.position, to: homeScene)
            
            for node in homeScene.children{
                if node.name == "anchorPoint"{
                    node.removeFromParent()
                }
            }
            
            for node in self.children{
                if node.name == "fishingLine"{
                    node.removeFromParent()
                }
            }
            
            
            let line = SKShapeNode()
            let path = CGMutablePath()
            let anchorPoint = SKSpriteNode(color: .red, size: CGSize(width: 1, height: 1))
            anchorPoint.position = position + homeScene.player.facing*50
            anchorPoint.name = "anchorPoint"
            homeScene.addChild(anchorPoint)
            
            path.move(to: bornPoint.position)
            path.addLine(to: bornPoint.position + homeScene.player.facing*50)
            
            line.path = path
            line.name = "fishingLine"
            line.zPosition = -1
            
            self.addChild(line)
            
        }
        
    }
    
    override func attack(degree: CGFloat, homeScene: GameScene) {
        
    }
    
}
