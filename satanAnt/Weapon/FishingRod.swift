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
        
        for monster in homeScene.monsterList{
            monster.sinceStart = 0
            let wait = SKAction.wait(forDuration: TimeInterval.random(in: 0..<1))
            let action = SKAction(named: "jellyFishAction")!
            monster.run(SKAction.sequence([wait,action]))
        }
        
    }
    
    override func attack(direction: CGPoint, homeScene: GameScene) {
        if homeScene.player.sinceFire < 0.3 {return}
        homeScene.player.sinceFire = 0
        
        
        if isFishing{
            for node in self.children{
                if node.name == "fishingLine"{
                    node.removeFromParent()
                }
                
                if homeScene.fishGot != nil{

                    let item = fromType(type: CollectionType.random())
                    item.position = homeScene.fishGot.position
                    homeScene.addChild(item)
                    item.run(SKAction.move(to: homeScene.player.position, duration: 1))
                    
                    homeScene.fishGot.removeFromParent()
                    homeScene.fishGot = nil
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
            
            
            //attack
            for monster in homeScene.monsterList{
                if monster.position.distanceTo(anchorPoint.position) < 35{
                    monster.beingHit(homeScene: homeScene)
                }
            }

            
            
        }
        
    }
    
    override func attack(degree: CGFloat, homeScene: GameScene) {
        
    }
    
}
