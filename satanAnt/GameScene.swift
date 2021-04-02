//
//  GameScene.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/3/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var logList = [Log]()
    
    var player: Player!
    var mount: SKSpriteNode!
    var handler: SKSpriteNode!

    var handlerBackground: SKSpriteNode!
    
    var fireButton: MSButtonNode!
    var popoButton: MSButtonNode!
    
    //var popoBornTime: TimeInterval = 5
    
    var sinceStart: TimeInterval!
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
    
    var mapPosition: SKSpriteNode!
    
    var setupIsSet = false

    var isBornRoom = false
    var isBonusRoom = false
    var YX: GridYX!
    
    var isDoorSet = false
    
    var weaponOnHand: SKSpriteNode!
    /* Make a Class method to load levels */
    class func level(_ levelNumber: Int) -> GameScene? {
        
        if levelNumber == 1 {
            let randomMap = Int.random(in: 0..<7)
            guard let scene = GameScene(fileNamed: "Level_\(levelNumber)_\(randomMap)") else {
                return nil
            }
            scene.scaleMode = .aspectFill
            return scene
        }else{
        guard let scene = GameScene(fileNamed: "Level_\(levelNumber)") else {
            return nil
        }
        scene.scaleMode = .aspectFill
        return scene
        }
    }
    
    override func didMove(to view: SKView) {

        //player.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        //addChild(player)
        if !self.setupIsSet {
            mount = (self.childNode(withName: "//mount") as! SKSpriteNode)
            handler = (self.childNode(withName: "//handler") as! SKSpriteNode)
            mapPosition = (self.childNode(withName: "map") as! SKSpriteNode)
            handlerBackground = (self.childNode(withName: "//handlerBackground") as! SKSpriteNode)
            fireButton = (self.childNode(withName: "fireButton") as! MSButtonNode)
            popoButton = (self.childNode(withName: "popoButton") as! MSButtonNode)
            //setupDoor()
            setupMap()
            if !isBornRoom && !isBonusRoom{setupMonster()}
        }
        
        handler.isHidden = true
        
        sinceStart = 0
        mount.position = handlerBackground.position
        handler.position = handlerBackground.position
        physicsWorld.contactDelegate = self
        
        player.move(toParent: self)
        player.playerIsMoving = false
        player.state = .idle
        player.homeScene = self
        player.healthChanged = true
        player.levelChanged = true
        player.expChanged = true
        player.moneyChanged = true
        player.weaponChanged = true
        
        fireButton.selectedHandler = {
            self.player.fireStart = 0
            self.player.weapon.attack(direction: self.player.facing,homeScene: self)
        }
        
        
        popoButton.selectedHandler = {
            //if !(self.popoStart > 6){return}
            let popo = Popo(position: self.player.position)
            self.addChild(popo)
            self.player.popoStart = 0
            
        }
        
        
       
       
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        if location.x > self.frame.width/2{
            mount.position = location
            handler.position = location
        }
        handleHandler(phase: "began", location: location)
        //handleFacingHandler(phase: "began", location: location)
        
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        
        handleHandler(phase: "moved", location: location)
        //handleFacingHandler(phase: "moved", location: location)
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        player.state = .idle
        handleHandler(phase: "ended", location: location)
        //handleFacingHandler(phase: "ended", location: location)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        player.popoStart += eachFrame
        player.fireStart += eachFrame
        sinceStart += eachFrame
        for i in 0..<logList.count{
            logList[i].sinceStart += eachFrame
        }
        
        playerSetupHud()
        timeControl()
        
        
//        for i in 0..<logList.count{if logList[i].isAlived{print("\(i): \(logList[i].position.x),\(logList[i].position.y)")}}
        
        //finsh cleaning monster
        if isBornRoom || isBonusRoom{if !isDoorSet{setupDoor();isDoorSet=true}
        }else{
            for i in 0..<logList.count{
                if logList[i].isAlived{break}
                if i == logList.count - 1 && !isDoorSet{setupDoor();isDoorSet=true}
            }
        }
        
        

    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        
        if let nodeA = nodeA {
            if let nodeB = nodeB{
                setupDoorPass(nodeA: nodeA, nodeB: nodeB)
                setupMonsterMoving(nodeA: nodeA, nodeB: nodeB)
                setupDamage(nodeA: nodeA, nodeB: nodeB)
            }
        }
    
    }
    
    
    
    func playerSetupHud() {
        //set exp
        if player.expChanged{
            let expBar = (self.childNode(withName: "//expBar") as! SKSpriteNode)
            expBar.xScale = player.exp/100
            player.expChanged = false
        }
        
        //set health
        if player.healthChanged {
            let heartBorn = (self.childNode(withName: "//heartBorn") as! SKSpriteNode)
            heartBorn.removeAllChildren()
            
            let integer = player.health.rounded(.down)
            let left = player.health.truncatingRemainder(dividingBy: 1.0)
            
            for i in 0..<Int(integer){
                let newHeart = Heart(number: 1)
                newHeart.run(SKAction(named: "idle")!)
                newHeart.position =  CGPoint(x: i*20, y: 0)
                heartBorn.addChild(newHeart)
                if i == Int(integer)-1{
                    let newHeart = Heart(number: left)
                    newHeart.run(SKAction(named: "idle")!)
                    newHeart.position =  CGPoint(x: (i+1)*20, y: 0)
                    heartBorn.addChild(newHeart)
                }
            }
            player.healthChanged = false
        }
        //set level
        if player.levelChanged{
            let levelBorn = (self.childNode(withName: "//levelBorn") as! SKSpriteNode)
            levelBorn.removeAllChildren()
            
            let firstNum: Int = Int((player.level/10).rounded(.down))
            let secondNum: Int = Int(player.level.truncatingRemainder(dividingBy: 10))
            
            let firstNode = Num(number: firstNum,size: 10)
            levelBorn.addChild(firstNode)
            firstNode.position = CGPoint(x: 0, y: 0)
            
            let secondNode = Num(number: secondNum,size: 10)
            levelBorn.addChild(secondNode)
            secondNode.position = CGPoint(x: 10, y: 0)
            player.levelChanged = false
        }
        
        //set money
        if player.moneyChanged {
            let moneyBorn = (self.childNode(withName: "//moneyBorn") as! SKSpriteNode)
            moneyBorn.removeAllChildren()
            
            let firstMoney: Int = Int((player.money/100).rounded(.down))
            let tempMoney: Int = (player.money >= 100) ? Int(player.money) - firstMoney*100 : Int(player.money)
            let secondMoney: Int = Int(tempMoney/10)
            let thirdMoney: Int = Int(player.money.truncatingRemainder(dividingBy: 10))
            
            
            let firstMoneyNode = Num(number: firstMoney,size: 15)
            moneyBorn.addChild(firstMoneyNode)
            firstMoneyNode.position = CGPoint(x: 0, y: 0)
            
            let secondMoneyNode = Num(number: secondMoney,size: 15)
            moneyBorn.addChild(secondMoneyNode)
            secondMoneyNode.position = CGPoint(x: 15, y: 0)
            
            let thirdMoneyNode = Num(number: thirdMoney,size: 15)
            moneyBorn.addChild(thirdMoneyNode)
            thirdMoneyNode.position = CGPoint(x: 30, y: 0)
            player.moneyChanged = false
        }
        //set weapon on hud and player
        if player.weaponChanged{
            let weaponBorn = (self.childNode(withName: "//weaponBorn") as! SKSpriteNode)
            let weaponName = player.weapon.name!
            weaponBorn.removeAllChildren()
            let newWeapon = Weapon(name: weaponName)
            newWeapon.position = CGPoint(x: 0, y: 0)
            weaponBorn.addChild(newWeapon)
            
            player.removeAllChildren()
            weaponOnHand = Weapon(name: weaponName)
            weaponOnHand.position = CGPoint(x: 10, y: -8)
            weaponOnHand.anchorPoint = CGPoint(x: 0.2, y: 0.3)
        
            let bornPoint = SKSpriteNode(color: .red, size: CGSize(width: 1, height: 1))
            bornPoint.position = CGPoint(x: 28.4, y: 3.3)
            bornPoint.name = "bornPoint"
            weaponOnHand.addChild(bornPoint)
            
            player.addChild(weaponOnHand)
            player.weaponChanged = false
        }
        
        //weapon on hand rotate each frame
        weaponOnHand.zRotation  = (player.facing.angle) * (3.14/180)
        
        
        
    }
    
    func setupMonsterMoving(nodeA: SKNode, nodeB: SKNode) {
        if nodeA.name == "log" {
            
            let node = nodeA as! Log
            node.bump()
            
        }
        if nodeB.name == "log" {
            
            let node = nodeB as! Log
            node.bump()
            
        }
    }
    
    func setupDamage(nodeA: SKNode, nodeB: SKNode) {
        if (nodeA.name == "staffBullet" && nodeB.name == "log"){
            let bullet = nodeA as! Bullet
            bullet.removeFromParent()
            let log = nodeB as! Log
            log.beingHit()
            log.health -= 0.25
            if log.health <= 0 {
                player.exp += 10
                player.expChanged = true
            }
            //print("hit!")
        }
        if (nodeA.name == "log" && nodeB.name == "staffBullet"){
            let bullet = nodeB as! Bullet
            bullet.removeFromParent()
            let log = nodeA as! Log
            log.beingHit()
            log.health -= 0.25
            if log.health <= 0 {
                player.exp += 10
                player.expChanged = true
            }
            //print("hit!")
        }
        
        if (nodeA.name == "log" && nodeB.name == "player"){
            player.health -= 0.25
            player.healthChanged = true
        }
        if (nodeA.name == "player" && nodeB.name == "log"){
            player.health -= 0.25
            player.healthChanged = true
            
        }
        
        
        
    }
    
    func timeControl()  {
        if sinceStart > eachFrame{
            handler.isHidden = false
        }
        if player.popoStart < 6 {popoButton.isHidden = true} else {popoButton.isHidden = false}
        
        if player.fireStart < player.weapon.attackSpeed {fireButton.isHidden = true} else{
            fireButton.isHidden = false
        }
        
        if player.playerIsMoving{
            player.position+=(player.facing * player.moveDistance)
        }
    }
    
    func setupMonster() {
        for _ in 0..<10 {
            var borned = false
            var check = 0
            var bornX = CGFloat.random(in: 50..<self.frame.width-50)
            var bornY = CGFloat.random(in: 50..<self.frame.height-50)
            while !borned {
                for node in self.children {
                    if node.physicsBody != nil && node.frame.contains(CGPoint(x: bornX, y: bornY)) {
                        bornX = CGFloat.random(in: 50..<self.frame.width-50)
                        bornY = CGFloat.random(in: 50..<self.frame.height-50)
                        break
                    }else {
                        check += 1
                        if check == self.children.count {borned = true}
                    }
                }
            }
            let newLog = Log(scene: self)
            newLog.position = CGPoint(x: bornX, y: bornY)
            addChild(newLog)
            logList.append(newLog)
        }
        
    }
    
    func setupMap() {
        let map = Map().map[player.inMapNumber]
        for y in 0..<Map().sceneRow{
            for x in 0..<Map().sceneCol{
                //set room for none zero
                if map[y][x] != 0 {
                    let newRoom = SKSpriteNode(color: .white, size: CGSize(width: 20, height: 20))
                    newRoom.zPosition = 2
                    newRoom.alpha = 0.5
                    //player room
                    if x == YX.x && y == YX.y {
                        newRoom.color = .red
                    }
                    newRoom.position = mapPosition.position + CGPoint(x: 20*x, y: -20*y)
                    addChild(newRoom)
                    
                    
                }
                
               
            }
        }
        
    }
    
    
    func setupDoorPass(nodeA: SKNode, nodeB: SKNode) {
        
        
        
        let fade = SKTransition.fade(withDuration: 1)
        
        if (nodeA.name == "rightDoor" && nodeB.name == "player") || (nodeA.name == "player" && nodeB.name == "rightDoor"){
            if  let view = self.view as SKView?{
                let scene = self.right
                scene?.scaleMode = .aspectFit
                scene?.player = player
                scene?.player.position = leftDoor.position + CGPoint(x: 70, y: 0)
                //scene?.handler.position = self.handler.position
                
                view.presentScene(scene!, transition: fade)
                view.showsFPS = true
                view.showsNodeCount = true
                view.ignoresSiblingOrder = true
            }
        }
        if (nodeA.name == "leftDoor" && nodeB.name == "player") || (nodeA.name == "player" && nodeB.name == "leftDoor") {
            if  let view = self.view as SKView?{
                let scene = self.left
                scene?.scaleMode = .aspectFit
                scene?.player = player
                scene?.player.position = rightDoor.position + CGPoint(x: -70, y: 0)
                //scene?.handler.position = self.handler.position
                
                view.presentScene(scene!, transition: fade)
                view.showsFPS = true
                view.showsNodeCount = true
                view.ignoresSiblingOrder = true}
        }
        if (nodeA.name == "topDoor" && nodeB.name == "player") || (nodeA.name == "player" && nodeB.name == "topDoor") {
            if  let view = self.view as SKView?{
                let scene = self.top
                scene?.scaleMode = .aspectFit
                scene?.player = player
                scene?.player.position = bottomDoor.position + CGPoint(x: 0, y: 70)
                //scene?.handler.position = self.handler.position
                
                view.presentScene(scene!, transition: fade)
                view.showsFPS = true
                view.showsNodeCount = true
                view.ignoresSiblingOrder = true}
        }
        if (nodeA.name == "bottomDoor" && nodeB.name == "player") || (nodeA.name == "player" && nodeB.name == "bottomDoor") {
            if  let view = self.view as SKView?{
                let scene = self.bototm
                scene?.scaleMode = .aspectFit
                scene?.player = player
                scene?.player.position = topDoor.position + CGPoint(x: 0, y: -70)
                //scene?.handler.position = self.handler.position
                
                view.presentScene(scene!, transition: fade)
                view.showsFPS = true
                view.showsNodeCount = true
                view.ignoresSiblingOrder = true}
        }
        self.setupIsSet = true
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

            handler.position = location
            player.playerIsMoving = true
            
        case "moved":
            
            if !player.playerIsMoving {return}
            
            let vec = location - mount.position
            //print("\(vec)")
            player.facing = vec.normalized()
            //print("\(player.facing)")
            
            //if !handlerBackground.frame.contains(location){
            if location.x < self.frame.width/2{
                player.playerIsMoving = false
                handler.position = mount.position
            }else {
                handler.position = location
            }
               
        case "ended":
            //print("ended!")
            handler.position = mount.position
            player.playerIsMoving = false
        default:
            break
        }
    }
    
    
    
    
}


