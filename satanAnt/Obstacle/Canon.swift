//
//  Canon.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/11.
//

import Foundation
import SpriteKit

enum CanonDirection {
    case left
    case right
}

class Canon: SKSpriteNode {
    
    var homeScene: GameScene!
    var sinceStart: TimeInterval!
    var canonDirection: CanonDirection!
  
    init(canonDirection: CanonDirection, scene: GameScene){
        
        var texture: SKTexture!
        
        switch canonDirection {
        case .right:
            texture = SKTexture(imageNamed: "canonRight_1")
        case .left:
            texture = SKTexture(imageNamed: "canonLeft_1")
        }
        
        super.init(texture: texture, color: .clear, size: CGSize(width: 50, height: 40))
        self.zPosition = 1
        self.homeScene = scene
        self.name = "canon"
        self.canonDirection = canonDirection
        self.sinceStart = 3
        
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 40))
        self.physicsBody?.pinned = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = 2
    
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func fireRight()  {
        
        homeScene.run(SKAction.playSoundFileNamed("canonFire.wav", waitForCompletion: true))
        
        self.run(SKAction(named: "canonFireRight")!)
        let point = CanonFirePoint()
        point.position = self.position + CGPoint(x: 20, y: 0)
        point.run(SKAction.moveBy(x: 50, y: 0, duration: 0.5))
        homeScene.addChild(point)
        
        let canonBall = CanonBall()
        canonBall.position = self.position + CGPoint(x: 40, y: 0)
        let range: CGFloat = 1000
        let fly = SKAction.move(to: CGPoint(x: canonBall.position.x + range, y: 0), duration: 20)
        canonBall.run(SKAction.sequence([fly,SKAction.removeFromParent()]))
        homeScene.addChild(canonBall)
    }
    
    func fireLeft()  {
        
        homeScene.run(SKAction.playSoundFileNamed("canonFire.wav", waitForCompletion: true))
        
        self.run(SKAction(named: "canonFireLeft")!)
        let point = CanonFirePoint()
        point.position = self.position + CGPoint(x: -20, y: 0)
        point.run(SKAction.moveBy(x: -50, y: 0, duration: 0.5))
        homeScene.addChild(point)
        
        let canonBall = CanonBall()
        canonBall.position = self.position + CGPoint(x: -40, y: 0)
        let range: CGFloat = 1000
        let fly = SKAction.move(to: CGPoint(x: canonBall.position.x - range, y: 0), duration: 20)
        canonBall.run(SKAction.sequence([fly,SKAction.removeFromParent()]))
        homeScene.addChild(canonBall)
        
    }
}
