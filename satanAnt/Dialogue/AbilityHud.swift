//
//  AbilityHud.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/4.
//

import Foundation
import SpriteKit
import AVFoundation

class AbilityHud: SKSpriteNode {
    var homeScene: GameScene!
   
    init(scene: GameScene){
        
        let texture = SKTexture(imageNamed: "abilityHud2")
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
        self.run(SKAction.sequence([wait,SKAction.run(renderPlusButton),SKAction.run(renderPoint),SKAction.run(renderCancelButton)]))
        
    }
    
    func renderPlusButton() {
        //667 375
        //render plus button
        let rangeButton = PlusButton(name: "rangeButton")
        rangeButton.position = CGPoint(x: 235, y: 255)
        homeScene.addChild(rangeButton)
        
        let speedButton = PlusButton(name: "speedButton")
        speedButton.position = CGPoint(x: 235, y: 210)
        homeScene.addChild(speedButton)
        let attackButton = PlusButton(name: "attackButton")
        attackButton.position = CGPoint(x: 235, y: 165)
        homeScene.addChild(attackButton)
        let healthButton = PlusButton(name: "healthButton")
        healthButton.position = CGPoint(x: 235, y: 115)
        homeScene.addChild(healthButton)
        
        
        rangeButton.selectHandler = {
            if self.homeScene.player.level == 0 {return}
            if self.homeScene.player.baseBulletRangePoint == 8{return}
            self.homeScene.player.baseBulletRangePoint += 1
            self.homeScene.player.level -= 1
            self.homeScene.player.levelChanged = true
            self.cleanPoint()
            self.renderPoint()
          
            self.homeScene.run(self.homeScene.pressSound)
        }
        speedButton.selectHandler = {
            if self.homeScene.player.level == 0 {return}
            if self.homeScene.player.baseBulletSpeedPoint == 8{return}
            self.homeScene.player.baseBulletSpeedPoint += 1
            self.homeScene.player.level -= 1
            self.homeScene.player.levelChanged = true
            self.cleanPoint()
            self.renderPoint()
            self.homeScene.run(self.homeScene.pressSound)
        }
        attackButton.selectHandler = {
            if self.homeScene.player.level == 0 {return}
            if self.homeScene.player.baseAttackPoint == 8{return}
            self.homeScene.player.baseAttackPoint += 1
            self.homeScene.player.level -= 1
            self.homeScene.player.levelChanged = true
            self.cleanPoint()
            self.renderPoint()
            self.homeScene.run(self.homeScene.pressSound)
        }
        healthButton.selectHandler = {
            if self.homeScene.player.level == 0 {return}
            if self.homeScene.player.baseHealthPoint == 8{return}
            self.homeScene.player.baseHealthPoint += 1
            self.homeScene.player.level -= 1
            self.homeScene.player.levelChanged = true
            self.cleanPoint()
            self.renderPoint()
            self.homeScene.run(self.homeScene.pressSound)
        }
        
    }
    
    func renderPoint()  {
        for i in 0..<Int(homeScene.player.baseBulletRangePoint){
            let newPoint = AbilityPoint(color: "red")
            newPoint.position = CGPoint(x: 273, y: 252) + CGPoint(x: 22*i, y: 0)
            homeScene.addChild(newPoint)
        }
        for i in 0..<Int(homeScene.player.baseBulletSpeedPoint){
            let newPoint = AbilityPoint(color: "white")
            newPoint.position = CGPoint(x: 273, y: 208) + CGPoint(x: 22*i, y: 0)
            homeScene.addChild(newPoint)
        }
        for i in 0..<Int(homeScene.player.baseAttackPoint){
            let newPoint = AbilityPoint(color: "purple")
            newPoint.position = CGPoint(x: 273, y: 160) + CGPoint(x: 22*i, y: 0)
            homeScene.addChild(newPoint)
        }
        for i in 0..<Int(homeScene.player.baseHealthPoint){
            let newPoint = AbilityPoint(color: "green")
            newPoint.position = CGPoint(x: 273, y: 113) + CGPoint(x: 22*i, y: 0)
            homeScene.addChild(newPoint)
        }
    }
    func cleanPoint() {
        for node in homeScene.children{
            if node.isMember(of: AbilityPoint.self){
                node.removeFromParent()
            }
        }
    }
    
    func cleanPlusButton()  {
        for node in homeScene.children{
            if node.isMember(of: PlusButton.self){
                node.removeFromParent()
            }
        }
    }
    
    func renderCancelButton()  {
        let cancelButton = CancelButton()
        cancelButton.position = CGPoint(x: 470, y: 320)
        homeScene.addChild(cancelButton)
        cancelButton.selectHandler = {
            self.cleanPoint()
            self.cleanPlusButton()
            self.removeFromParent()
            cancelButton.removeFromParent()
            
            if let book = self.homeScene.book{
                book.close()
            }
            self.homeScene.inDialogue = false
            
            self.homeScene.run(self.homeScene.openChestSound)
        }
    }
    
}
