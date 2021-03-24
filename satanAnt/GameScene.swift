//
//  GameScene.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/3/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var player: Player!
    var mount: SKSpriteNode!
    var handler: SKSpriteNode!
    var handlerBackground: SKSpriteNode!
    var touchJoint: SKPhysicsJointSpring!
    var fireButton: MSButtonNode!
    var popoButton: MSButtonNode!
    
    var popoBornTime: TimeInterval = 5
    
    
    var eachFrame: TimeInterval = 1/60
    
    var top: GameScene!
    var bototm: GameScene!
    var left: GameScene!
    var right: GameScene!
    
    var levelNum: Int!
    var roomType: Int!
    
    var topDoor: SKSpriteNode!
    var bottomDoor: SKSpriteNode!
    var leftDoor: SKSpriteNode!
    var rightDoor: SKSpriteNode!
    
    var YX: GridYX!
    /* Make a Class method to load levels */
    //    class func level(_ levelNumber: Int) -> GameScene? {
    //        guard let scene = GameScene(fileNamed: "Level_\(levelNumber)") else {
    //            return nil
    //        }
    //        scene.scaleMode = .aspectFill
    //        return scene
    //    }
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        player.move(toParent: self)
        player.playerIsMoving = false
        //player.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        //addChild(player)
        
        mount = (self.childNode(withName: "//mount") as! SKSpriteNode)
        handler = (self.childNode(withName: "//handler") as! SKSpriteNode)
        handlerBackground = (self.childNode(withName: "//handlerBackground") as! SKSpriteNode)
        
        //mount.position = handlerBackground.position
        //handler.position = handlerBackground.position
        
        fireButton = (self.childNode(withName: "fireButton") as! MSButtonNode)
        fireButton.selectedHandler = {
            print("touch!")
            let bullet = Bullet(position: self.player.position)
            self.addChild(bullet)
            bullet.flyTo(direction: self.player.facing)
        }
        
        popoButton = (self.childNode(withName: "popoButton") as! MSButtonNode)
        popoButton.selectedHandler = {
            //if !(self.popoStart > 6){return}
            let popo = Popo(position: self.player.position)
            self.addChild(popo)
            self.player.popoStart = 0
    
        }
        
        
        setupDoor()
        print("room y: \(YX.y) x: \(YX.x)")
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
        player.popoStart += eachFrame
        if player.popoStart < 6 {popoButton.isHidden = true} else {popoButton.isHidden = false}
        
        if player.playerIsMoving{
            player.position+=(player.facing * player.moveDistance)
        }
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        
        if let nodeA = nodeA {
            if let nodeB = nodeB{
                setupDoorPass(nodeA: nodeA, nodeB: nodeB)
            }
        }
        
        
        
        
    }
    
    
    func setupDoorPass(nodeA: SKNode, nodeB: SKNode) {
        
        
        if nodeA.name == "rightDoor" || nodeB.name == "rightDoor" {
            if  let view = self.view as SKView?{
                let scene = self.right
                scene?.scaleMode = .aspectFill
                scene?.player = player
                scene?.player.position = leftDoor.position + CGPoint(x: 70, y: 0)
                //scene?.handler.position = self.handler.position
                view.presentScene(scene)
                view.showsFPS = true
                view.showsNodeCount = true
                view.ignoresSiblingOrder = true
            }
        }
        if nodeA.name == "leftDoor" || nodeB.name == "leftDoor" {
            if  let view = self.view as SKView?{
                let scene = self.left
                scene?.scaleMode = .aspectFill
                scene?.player = player
                scene?.player.position = rightDoor.position + CGPoint(x: -70, y: 0)
                //scene?.handler.position = self.handler.position
                view.presentScene(scene)
                view.showsFPS = true
                view.showsNodeCount = true
                view.ignoresSiblingOrder = true}
        }
        if nodeA.name == "topDoor" || nodeB.name == "topDoor" {
            if  let view = self.view as SKView?{
                let scene = self.top
                scene?.scaleMode = .aspectFill
                scene?.player = player
                scene?.player.position = bottomDoor.position + CGPoint(x: 0, y: 70)
                //scene?.handler.position = self.handler.position
                view.presentScene(scene)
                view.showsFPS = true
                view.showsNodeCount = true
                view.ignoresSiblingOrder = true}
        }
        if nodeA.name == "bottomDoor" || nodeB.name == "bottomDoor" {
            if  let view = self.view as SKView?{
                let scene = self.bototm
                scene?.scaleMode = .aspectFill
                scene?.player = player
                scene?.player.position = topDoor.position + CGPoint(x: 0, y: -70)
                //scene?.handler.position = self.handler.position
                view.presentScene(scene)
                view.showsFPS = true
                view.showsNodeCount = true
                view.ignoresSiblingOrder = true}
        }
    }
    
    
    func setupDoor() {
         topDoor = (self.childNode(withName: "topDoor") as! SKSpriteNode)
         bottomDoor = (self.childNode(withName: "bottomDoor") as! SKSpriteNode)
         leftDoor = (self.childNode(withName: "leftDoor") as! SKSpriteNode)
         rightDoor = (self.childNode(withName: "rightDoor") as! SKSpriteNode)
        if self.top != nil {addChild(Door(position: topDoor.position,name: "topDoor"))}
        if self.bototm != nil {addChild(Door(position: bottomDoor.position, name: "bottomDoor"))}
        if self.left != nil {addChild(Door(position: leftDoor.position, name: "leftDoor"))}
        if self.right != nil {addChild(Door(position: rightDoor.position, name: "rightDoor"))}
        
        
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
                player.playerIsMoving = false
                return
            }
            handler.position = location
            let vec = handler.position - mount.position
            player.facing = vec.normalized()
            
            
        case "ended":
            player.playerIsMoving = false
        default:
            break
        }
    }
    
    
}


