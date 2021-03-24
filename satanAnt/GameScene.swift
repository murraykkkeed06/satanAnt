//
//  GameScene.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/3/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var player: Player!
    var mount: SKSpriteNode!
    var handler: SKSpriteNode!
    var handlerBackground: SKSpriteNode!
    var touchJoint: SKPhysicsJointSpring!
    var fireButton: MSButtonNode!
    var popoButton: MSButtonNode!
    
    var popoBornTime: TimeInterval = 5
    
    var popoStart: TimeInterval = 0
    var eachFrame: TimeInterval = 1/60
    
    
    override func didMove(to view: SKView) {
        player = Player()
        player.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        addChild(player)
        
        mount = (self.childNode(withName: "//mount") as! SKSpriteNode)
        handler = (self.childNode(withName: "//handler") as! SKSpriteNode)
        handlerBackground = (self.childNode(withName: "//handlerBackground") as! SKSpriteNode)
        
        mount.position = handlerBackground.position
        handler.position = handlerBackground.position
        
        fireButton = (self.childNode(withName: "fireButton") as! MSButtonNode)
        fireButton.selectedHandler = {
            print("touch!")
            let bullet = Bullet(position: self.player.position)
            self.addChild(bullet)
            bullet.flyTo(direction: self.player.facing)
        }
        
        popoButton = (self.childNode(withName: "popoButton") as! MSButtonNode)
        popoButton.isHidden = true
        popoButton.selectedHandler = {
            //if !(self.popoStart > 6){return}
            let popo = Popo(position: self.player.position)
            self.addChild(popo)
            self.popoStart = 0
            
            
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
    
        handleHandler(phase: "began", location: location)
        
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        
        handleHandler(phase: "moved", location: location)
        
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        
        handleHandler(phase: "ended", location: location)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        popoStart += eachFrame
        if popoStart < 6 {popoButton.isHidden = true} else {popoButton.isHidden = false}
    }
    
    
    func handleHandler(phase: String, location: CGPoint) {
        let nodeAtpoint = atPoint(location)
        if nodeAtpoint.name != "handler" {return}
        
        switch phase {
        case "began":
            touchJoint = SKPhysicsJointSpring.joint(withBodyA: mount.physicsBody!, bodyB: handler.physicsBody!, anchorA: mount.position, anchorB: location)
            touchJoint.damping = 1
            touchJoint.frequency = 1
            physicsWorld.add(touchJoint)
            
            handler.position = location
            
            player.playerIsMoving = true
            
        case "moved":
            if !handlerBackground.frame.contains(location) {
                player.stopWalk();
                player.playerIsMoving = false
                return
            }
            handler.position = location
            player.walkBy(handlePosition: handler.position, handleMiddlePosition: mount.position)
            
            let vec = handler.position - mount.position
            player.facing = vec.normalized()
            
        case "ended":
            player.playerIsMoving = false
            player.stopWalk()
        default:
            break
        }
    }
    
    
}


