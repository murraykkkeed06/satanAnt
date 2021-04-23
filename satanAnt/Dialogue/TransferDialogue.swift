//
//  BigDialogue.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/4.
//

import Foundation
import SpriteKit
import AVFoundation

class TransferDialogue: SKSpriteNode {
    
    var homeScene: GameScene!
    
    var num: Int = 0
   
    var isFinish = false
    var rightNode: SKNode!
    var leftNode: SKNode!
    
    
    init(scene: GameScene){
       
        let texture = SKTexture(imageNamed: "transferDialogue")
        //super.init(texture: texture, color: .clear, size: CGSize(width: 412, height: 124))
        super.init(texture: texture, color: .clear, size: CGSize(width: 136, height: 79))
        //self.position = CGPoint(x: 337, y: 116)
        self.zPosition = 200
        self.name = "transferDialogue"
        self.homeScene = scene
        self.anchorPoint = CGPoint(x: 0, y: 1)
        self.isUserInteractionEnabled = true
        
        let wait = SKAction.wait(forDuration: 0.5)
        self.run(SKAction.sequence([wait,SKAction.run(render),SKAction.run(renderStartButton),SKAction.run(renderCancelButton)]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        
        //print("\(atPoint(location).name)")
        
        if atPoint(location).name == "startButton"{
            if homeScene.player.collectionList.count == 0 {return}
            homeScene.player.collectionList.remove(at: 0)
            homeScene.player.collectionChanged = true
            
            let power = rightNode as! Power
            let position = homeScene.convert(homeScene.powerBorn.position + CGPoint(x: 0, y: -30 * homeScene.player.powerList.count), to: self)
            power.run(SKAction.sequence([SKAction.move(to: position, duration: 0.5),SKAction.removeFromParent()]))
            print("\(homeScene.powerBorn.position)")
    
            homeScene.player.powerList.append(fromType(type: power.type))
            let add = SKAction.run{
                self.homeScene.player.powerChanged = true
            }
            homeScene.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),add]))
            homeScene.run(homeScene.transferSound)
            
            leftNode.removeFromParent()
            //rightNode.removeFromParent()
           
            render()
        }
        
        
    }
    
    
    func render()  {
        
       
        if homeScene.player.collectionList.count == 0 {return}
            
        
        
        leftNode = homeScene.player.collectionList[0]
        leftNode.position = CGPoint(x: 42, y: -33)
        leftNode.zPosition = 1
        leftNode.name = "leftNode"
        addChild(leftNode)
        
        rightNode = getRightNodeFromLeftNode(leftNode: leftNode)
        rightNode.position = CGPoint(x: 89, y: -33)
        rightNode.zPosition = 1
        rightNode.name = "rightNode"
        addChild(rightNode)
        
        
        
    }
    
    func renderStartButton()  {
        let startButton = SKSpriteNode(texture: SKTexture(imageNamed: "startButton"), color: .clear, size: CGSize(width: 55, height: 20))
        startButton.position = CGPoint(x: 65, y: -58)
        startButton.zPosition = 1
        startButton.name = "startButton"
        addChild(startButton)
    }
    
    func renderCancelButton()  {
        let cancelButton = CancelButton()
        cancelButton.position = CGPoint(x: 370, y: 235)
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
    
    func getRightNodeFromLeftNode(leftNode: SKNode) -> SKNode {
        
        var rightNode: SKNode!
        
        let collection = leftNode as! Collection
        
        switch collection.type {
        case .ducky:
            rightNode = FlyingBird()
        case .poop:
            rightNode = HalfMonster()
        case .truffle:
            rightNode = HealthGainer()
        default:
            break
        }
        
        return rightNode
        
    }
    
    
   
    
    
}
