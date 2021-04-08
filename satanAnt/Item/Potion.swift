//
//  Potion.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/8.
//

import Foundation
import SpriteKit

class Potion: Item {
    
    var homeScene: GameScene!
    
    init(){
        let texture = SKTexture(imageNamed: "potion")
        super.init(texture: texture, color: .clear, size: CGSize(width: 20, height: 30))
        self.zPosition = 50
        self.name = "potion"
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func work(scene: GameScene)  {
        self.homeScene = scene
        self.removeFromParent()
        //remove in item list
//        for i in 0..<homeScene.player.itemList.count{
//            if homeScene.player.itemList[i].name == self.name{
//                homeScene.player.itemList.remove(at: i)
//                break
//            }
//        }
        homeScene.player.itemList.remove(at: homeScene.player.inItemListNumber)
        
        if homeScene.player.inItemListNumber == homeScene.player.itemList.count{
            homeScene.player.inItemListNumber -= 1
        }
        
        //set player item to next in itemlist
        if homeScene.player.itemList.count > 0 {
            homeScene.player.item = homeScene.player.itemList[homeScene.player.inItemListNumber]
        }else {
            homeScene.player.item = nil
        }
        
        homeScene.player.itemChanged = true
        
        
        
//        for node in homeScene.player.itemList{
//            if node == nil{
//                print("found nil")
//            }
//        }
        
        
        homeScene.run(SKAction.playSoundFileNamed("bigger.wav", waitForCompletion: true))
        
        let bigger = SKAction.scale(to: CGSize(width: 50, height: 50), duration: 1)
        let wait = SKAction.wait(forDuration: 5)
        let smaller = SKAction.scale(to: CGSize(width: 28, height: 34), duration: 1)
        
        //remove player.item
        
        homeScene.player.run(SKAction.sequence([bigger,wait,smaller]))
        
        
        
        
        
    }
    
}
