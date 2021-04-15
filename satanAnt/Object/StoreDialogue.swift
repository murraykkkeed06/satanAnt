//
//  BigDialogue.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/4.
//

import Foundation
import SpriteKit
import AVFoundation

class StoreDialogue: SKSpriteNode {
    var AudioPlayer = AVAudioPlayer()
    var typeSound: NSURL!
    var homeScene: GameScene!
    var timer: Timer!
    var num: Int = 0
    var wordList = [SKLabelNode]()
    var isFinish = false
    var selectionNode: SKNode!
    
    init(scene: GameScene){
        typeSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "talking", ofType: "mp3")!)
        
        let texture = SKTexture(imageNamed: "storeHud")
        //super.init(texture: texture, color: .clear, size: CGSize(width: 412, height: 124))
        super.init(texture: texture, color: .clear, size: CGSize(width: 228, height: 227))
        //self.position = CGPoint(x: 337, y: 116)
        self.zPosition = 200
        self.name = "storeDialogue"
        self.homeScene = scene
        self.anchorPoint = CGPoint(x: 0, y: 1)
        self.isUserInteractionEnabled = true
        
        let wait = SKAction.wait(forDuration: 0.5)
        self.run(SKAction.sequence([wait,SKAction.run(render),SKAction.run(renderCancelButton)]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        
        if atPoint(location).name == "buyWordButton"{
            if let selectionNode = selectionNode{
                switch selectionNode.name {
                case "fireBombTextureOnHud":
                    bornItemTexture(num: 1, position: homeScene.player.position, homeScene: homeScene,type: .fireBomb)
                    if homeScene.player.money < fromType(type: .fireBomb).price{return}
                    homeScene.player.money -= fromType(type: .fireBomb).price
                    homeScene.player.moneyChanged = true
                case "potionTextureOnHud":
                    bornItemTexture(num: 1, position: homeScene.player.position, homeScene: homeScene,type: .potion)
                    if homeScene.player.money < fromType(type: .potion).price{return}
                    homeScene.player.money -= fromType(type: .potion).price
                    homeScene.player.moneyChanged = true
                case "cokeTextureOnHud":
                    bornItemTexture(num: 1, position: homeScene.player.position, homeScene: homeScene,type: .coke)
                    if homeScene.player.money < fromType(type: .coke).price{return}
                    homeScene.player.money -= fromType(type: .coke).price
                    homeScene.player.moneyChanged = true
                case "appleTextureOnHud":
                    bornItemTexture(num: 1, position: homeScene.player.position, homeScene: homeScene,type: .apple)
                    if homeScene.player.money < fromType(type: .apple).price{return}
                    homeScene.player.money -= fromType(type: .apple).price
                    homeScene.player.moneyChanged = true
                default:
                    break
                }
            }
            return
        }
        
        
        selectionNode = atPoint(location)
        if let selectionNode = selectionNode{
            for node in self.children{
                if node.name == "pointing"{
                    node.removeFromParent()
                }
            }
            
            let pointing = SKSpriteNode(texture: SKTexture(imageNamed: "pointing"), color: .clear, size: CGSize(width: 20, height: 30))
            pointing.position = selectionNode.position + CGPoint(x: 0, y: 20)
            pointing.run(SKAction(named: "idle")!)
            pointing.name = "pointing"
            pointing.zPosition = 50
            addChild(pointing)
        }
        
    }
    
    
    
    func render()  {
        
        let type1 = ItemType.random()
        let itemTexture1 =  fromTypeTexture(type: type1)
        itemTexture1.position = CGPoint(x: 64, y: -60)
        itemTexture1.zPosition = 1
        itemTexture1.name = itemTexture1.name! + "OnHud"
        itemTexture1.physicsBody = nil
        let price1 = fromType(type: type1).price!
        let firstMoney1: Int = Int(price1/10)
        let secondMoney1: Int = Int(price1.truncatingRemainder(dividingBy: 10))
        
        let firstNum1 = Num(number: firstMoney1, size: 15)
        let secondNum1 = Num(number: secondMoney1, size: 15)
        firstNum1.position = CGPoint(x: 95, y: -60)
        secondNum1.position = CGPoint(x: 105, y: -60)
        
        addChild(firstNum1)
        addChild(secondNum1)
        addChild(itemTexture1)
        
        let type2 = ItemType.random()
        let itemTexture2 =  fromTypeTexture(type: type2)
        itemTexture2.position = CGPoint(x: 134, y: -60)
        itemTexture2.zPosition = 1
        itemTexture2.name = itemTexture2.name! + "OnHud"
        itemTexture2.physicsBody = nil
        let price2 = fromType(type: type2).price!
        let firstMoney2: Int = Int(price2/10)
        let secondMoney2: Int = Int(price2.truncatingRemainder(dividingBy: 10))
        
        let firstNum2 = Num(number: firstMoney2, size: 15)
        let secondNum2 = Num(number: secondMoney2, size: 15)
        firstNum2.position = CGPoint(x: 165, y: -60)
        secondNum2.position = CGPoint(x: 175, y: -60)
        
        addChild(firstNum2)
        addChild(secondNum2)
        addChild(itemTexture2)
        
        let type3 = ItemType.random()
        let itemTexture3 =  fromTypeTexture(type: type3)
        itemTexture3.position = CGPoint(x: 64, y: -111)
        itemTexture3.zPosition = 1
        itemTexture3.name = itemTexture3.name! + "OnHud"
        itemTexture3.physicsBody = nil
        let price3 = fromType(type: type3).price!
        let firstMoney3: Int = Int(price3/10)
        let secondMoney3: Int = Int(price3.truncatingRemainder(dividingBy: 10))
        
        let firstNum3 = Num(number: firstMoney3, size: 15)
        let secondNum3 = Num(number: secondMoney3, size: 15)
        firstNum3.position = CGPoint(x: 95, y: -111)
        secondNum3.position = CGPoint(x: 105, y: -111)
        
        addChild(firstNum3)
        addChild(secondNum3)
        addChild(itemTexture3)
        
        let type4 = ItemType.random()
        let itemTexture4 =  fromTypeTexture(type: type4)
        itemTexture4.position = CGPoint(x: 135, y: -111)
        itemTexture4.zPosition = 1
        itemTexture4.name = itemTexture4.name! + "OnHud"
        itemTexture4.physicsBody = nil
        let price4 = fromType(type: type4).price!
        let firstMoney4: Int = Int(price4/10)
        let secondMoney4: Int = Int(price4.truncatingRemainder(dividingBy: 10))
        
        let firstNum4 = Num(number: firstMoney4, size: 15)
        let secondNum4 = Num(number: secondMoney4, size: 15)
        firstNum4.position = CGPoint(x: 165, y: -111)
        secondNum4.position = CGPoint(x: 175, y: -111)
        
        addChild(firstNum4)
        addChild(secondNum4)
        addChild(itemTexture4)
        
        
        let type5 = ItemType.random()
        let itemTexture5 =  fromTypeTexture(type: type5)
        itemTexture5.position = CGPoint(x: 64, y: -162)
        itemTexture5.zPosition = 1
        itemTexture5.name = itemTexture5.name! + "OnHud"
        itemTexture5.physicsBody = nil
        let price5 = fromType(type: type5).price!
        let firstMoney5: Int = Int(price5/10)
        let secondMoney5: Int = Int(price5.truncatingRemainder(dividingBy: 10))
        
        let firstNum5 = Num(number: firstMoney5, size: 15)
        let secondNum5 = Num(number: secondMoney5, size: 15)
        firstNum5.position = CGPoint(x: 95, y: -162)
        secondNum5.position = CGPoint(x: 105, y: -162)
        
        addChild(firstNum5)
        addChild(secondNum5)
        addChild(itemTexture5)
        
        
        let type6 = ItemType.random()
        let itemTexture6 =  fromTypeTexture(type: type6)
        itemTexture6.position = CGPoint(x: 135, y: -163)
        itemTexture6.zPosition = 1
        itemTexture6.name = itemTexture6.name! + "OnHud"
        itemTexture6.physicsBody = nil
        let price6 = fromType(type: type6).price!
        let firstMoney6: Int = Int(price6/10)
        let secondMoney6: Int = Int(price6.truncatingRemainder(dividingBy: 10))
        
        let firstNum6 = Num(number: firstMoney6, size: 15)
        let secondNum6 = Num(number: secondMoney6, size: 15)
        firstNum6.position = CGPoint(x: 165, y: -162)
        secondNum6.position = CGPoint(x: 175, y: -162)
        
        addChild(firstNum6)
        addChild(secondNum6)
        addChild(itemTexture6)
        
        
        let buyButton = SKSpriteNode(texture: SKTexture(imageNamed: "buyWordButton"), color: .clear, size: CGSize(width: 72, height: 21))
        buyButton.position = CGPoint(x: 110, y: -192)
        buyButton.name = "buyWordButton"
        buyButton.zPosition = 1
        addChild(buyButton)
        
        
    }
    

    func renderCancelButton()  {
        let cancelButton = CancelButton()
        cancelButton.position = CGPoint(x: 442, y: 320)
        homeScene.addChild(cancelButton)
        cancelButton.selectHandler = {
            self.removeAllChildren()
            self.removeFromParent()
            cancelButton.removeFromParent()
            
            self.homeScene.inDialogue = false
            self.homeScene.popoButton.isUserInteractionEnabled = true
            self.homeScene.fireButton.isUserInteractionEnabled = true
        }
    }
    
    
   
}



