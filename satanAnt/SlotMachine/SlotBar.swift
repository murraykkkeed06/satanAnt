//
//  SlotBar.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/20.
//

import Foundation
import SpriteKit


class SlotBar: SKSpriteNode {
    
    var isPressed = false
   
    var firstHead: SKNode!
    var secondHead: SKNode!
    var thirdHead: SKNode!
    
    var homeScene: GameScene!
    
    var firstStop = true
    var secondStop = true
    var thirdStop = true
    
    
    init(scene: GameScene){
        
        let texture = SKTexture(imageNamed: "slotBar")
        super.init(texture: texture, color: .clear, size: CGSize(width: 8, height: 20))
        self.zPosition = 10
        self.anchorPoint = CGPoint(x: 0.4, y: 0)
        self.position = CGPoint(x: 330, y: 238)
        self.name = "slotBar"
        self.isUserInteractionEnabled = true
        
        firstHead = SKSpriteNode(color: .red, size: CGSize(width: 0.1, height: 0.1))
        firstHead.zPosition = 2
        firstHead.position = CGPoint(x: 284.5, y: 233)
        firstHead.name = "firstHead"
        
        secondHead = SKSpriteNode(color: .red, size: CGSize(width: 0.1, height: 0.1))
        secondHead.zPosition = 2
        secondHead.position = CGPoint(x: 299, y: 233)
        secondHead.name = "secondHead"
        
        thirdHead = SKSpriteNode(color: .red, size: CGSize(width: 0.1, height: 0.1))
        thirdHead.zPosition = 2
        thirdHead.position = CGPoint(x: 314, y: 233)
        thirdHead.name = "thirdHead"
        
        self.homeScene = scene
        
        homeScene.addChild(firstHead)
        homeScene.addChild(secondHead)
        homeScene.addChild(thirdHead)
        initialCol()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isPressed{return}
        if homeScene.player.money < 10 {return}
        homeScene.player.money -= 10
        homeScene.player.moneyChanged = true
        isPressed = true
        self.run(SKAction.rotate(byAngle: -140 * (CGFloat.pi/180), duration: 1))
        
        startRolling()
        
        
        
    }
    
    func startRolling()  {
        firstStop = false
        secondStop = false
        thirdStop = false
        let firstAction = SKAction.moveBy(x: 0, y: -700, duration: TimeInterval.random(in: 5..<10))
        firstAction.timingMode = .easeInEaseOut
        
        let secondAction = SKAction.moveBy(x: 0, y: -700, duration: TimeInterval.random(in: 5..<10))
        firstAction.timingMode = .easeInEaseOut
        
        let thirdAction = SKAction.moveBy(x: 0, y: -700, duration: TimeInterval.random(in: 5..<10))
        firstAction.timingMode = .easeInEaseOut
        
        firstHead.run(SKAction.sequence([firstAction,SKAction.run({
            self.firstStop = true
            self.check()
        })]))
        
        secondHead.run(SKAction.sequence([secondAction,SKAction.run({
            self.secondStop = true
            self.check()
        })]))
        
        thirdHead.run(SKAction.sequence([thirdAction,SKAction.run({
            self.thirdStop = true
            self.check()
        })]))
        
        
        
    }
    
    func check()  {
        if firstStop && secondStop && thirdStop{
            
            self.run(SKAction.rotate(toAngle: 0, duration: 1))
            isPressed = false
            
            
            var firstResult: SlotICon!
            var secondResult: SlotICon!
            var thirdResult: SlotICon!
            
            let firstPosition = homeScene.convert(CGPoint(x: 284.5, y: 244), to: firstHead)
            
            for node in self.firstHead.children{
                if node.frame.contains(firstPosition){
                    let icon = node as! SlotICon
                    //print("\(String(describing: icon.type))")
                    firstResult = icon
                }
                //if node.position.y < firstPosition.y - 20{node.removeFromParent()}
                
            }
            
            let secondPosition = homeScene.convert(CGPoint(x: 299, y: 244), to: secondHead)
            
            for node in self.secondHead.children{
                if node.frame.contains(secondPosition){
                    let icon = node as! SlotICon
                    //print("\(String(describing: icon.type))")
                    secondResult = icon
                }
                //if node.position.y < secondPosition.y - 20{node.removeFromParent()}
            }
            
            let thirdPosition = homeScene.convert(CGPoint(x: 314, y: 244), to: thirdHead)
            
            for node in self.thirdHead.children{
                if node.frame.contains(thirdPosition){
                    let icon = node as! SlotICon
                    //print("\(String(describing: icon.type))")
                    thirdResult = icon
                }
                //if node.position.y < thirdPosition.y - 20{node.removeFromParent()}
            }
            
            if firstResult.type == secondResult.type && secondResult.type == thirdResult.type{
                
                bornItemTexture(num: 1, position: CGPoint(x: 300, y: 200), homeScene: homeScene)

            }
        }
    }
    
    func initialCol()  {
        
        for i in 0 ..< 1000{
            let firstIcon = SlotICon(type: SlotIconType.random())
            let secondIcon = SlotICon(type: SlotIconType.random())
            let thirdIcon = SlotICon(type: SlotIconType.random())
            
            firstIcon.position = CGPoint(x: 0, y: 14 * i)
            secondIcon.position = CGPoint(x: 0, y: 14 * i)
            thirdIcon.position = CGPoint(x: 0, y: 14 * i)
            
            let firstBar = SlotUnderScore()
            let secondBar = SlotUnderScore()
            let thirdBar = SlotUnderScore()
            firstBar.position = firstIcon.position + CGPoint(x: 0, y: 7)
            secondBar.position = secondIcon.position + CGPoint(x: 0, y: 7)
            thirdBar.position = thirdIcon.position + CGPoint(x: 0, y: 7)
            
            firstHead.addChild(firstIcon)
            firstHead.addChild(firstBar)
            
            secondHead.addChild(secondIcon)
            secondHead.addChild(secondBar)
            
            thirdHead.addChild(thirdIcon)
            thirdHead.addChild(thirdBar)

        }
 
        
    }
    
}
