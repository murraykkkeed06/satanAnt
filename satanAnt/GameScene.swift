//
//  GameScene.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/3/24.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var AudioPlayer = AVAudioPlayer()
    
    //var shootSound: NSURL!
    var openBookSound: NSURL!
    var doorCloseSound: NSURL!
    var helloSound: NSURL!
    var stopSound: NSURL!
    var portalSound: NSURL!
    var portalBornSound: NSURL!
    //move from gameviewcontroller
    var sceneList = [GameScene]()
    var map = [[Int]]()
    
    
    var levelChanged = true
    var logList = [Log]()
    
    var player: Player!
    var mount: SKSpriteNode!
    var handler: SKSpriteNode!
    
    var handlerBackground: SKSpriteNode!
    
    var fireButton: MSButtonNode!
    var popoButton: MSButtonNode!
    var rButton: MSButtonNode!
    var leftButton: MSButtonNode!
    var rightButton: MSButtonNode!
    
    //var popoBornTime: TimeInterval = 5
    
    var sinceStart: TimeInterval = 0
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
    var cavePosition: SKSpriteNode!
    
    var setupIsSet = false
    
    var isBornRoom = false
    var isBonusRoom = false
    var isBedRoom = false
    var isMonsterRoom = false
    var isCaveRoom = false
    var isEnterCaveRoom = false
    var isBreakRoom = false
    var YX: GridYX!
    
    var isDoorSet = false
    var dialogueIsSet = false
    var dialogue: Dialogue!
    var weaponOnHand: SKSpriteNode!
    var npcBornPoint = CGPoint(x: 350, y: 220)
    var inDialogue = false
    
    var book: Book!
    var npc: Npc!
    var soilder: Soilder!
    var cave: Cave!
    
    var levelNumber: Num!
    
    var bigDialogue: BigDialogue!
    
    var popo: Popo!
    var box: Box!
    var boxIsSet = false
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
        
        //sound
        //shootSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "shoot", ofType: "mp3")!)
        
        //self.physicsWorld.gravity = CGVector(dx: 0, dy: -3);
        
        openBookSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "openChest", ofType: "wav")!)
        doorCloseSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "door", ofType: "mp3")!)
        helloSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "hello", ofType: "mp3")!)
        stopSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "stop", ofType: "mp3")!)
        portalSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "portal", ofType: "mp3")!)
        
        portalBornSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "portalBorn", ofType: "wav")!)
        
        //player.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        //addChild(player)
        if !self.setupIsSet {
            mount = (self.childNode(withName: "//mount") as! SKSpriteNode)
            handler = (self.childNode(withName: "//handler") as! SKSpriteNode)
            
            handlerBackground = (self.childNode(withName: "//handlerBackground") as! SKSpriteNode)
            fireButton = (self.childNode(withName: "fireButton") as! MSButtonNode)
            popoButton = (self.childNode(withName: "popoButton") as! MSButtonNode)
            rButton = (self.childNode(withName: "rHandler") as! MSButtonNode)
            //setupDoor()
            leftButton = (self.childNode(withName: "left") as! MSButtonNode)
            leftButton.selectedHandler = {
                if self.player.itemList.count < 2 {
                    self.run(SKAction.playSoundFileNamed("erro.wav", waitForCompletion: true))
                    return}
                if self.player.inItemListNumber == 0 {self.run(SKAction.playSoundFileNamed("erro.wav", waitForCompletion: true));return}
                self.run(SKAction.playSoundFileNamed("slide.wav", waitForCompletion: false))
                self.player.item = self.player.itemList[self.player.inItemListNumber-1]
                self.player.inItemListNumber -= 1
                self.player.itemChanged = true
                
            }
            rightButton = (self.childNode(withName: "right") as! MSButtonNode)
            rightButton.selectedHandler = {
                if self.player.itemList.count < 2 {self.run(SKAction.playSoundFileNamed("erro.wav", waitForCompletion: true));return}
                if self.player.inItemListNumber == self.player.itemList.count-1 {self.run(SKAction.playSoundFileNamed("erro.wav", waitForCompletion: true));return}
                self.run(SKAction.playSoundFileNamed("slide.wav", waitForCompletion: false))
                self.player.item = self.player.itemList[self.player.inItemListNumber+1]
                self.player.inItemListNumber += 1
                self.player.itemChanged = true
                
            }
            
            if isMonsterRoom {setupMonster()}
            setupIsSet = true
            if isBedRoom{
                setupBedRoom()
                self.run(SKAction.playSoundFileNamed("start.wav", waitForCompletion: false))
            }
            if isCaveRoom{setupCave()}
            if isBornRoom{
                box = Box()
                box.position = CGPoint(x: 320, y: 120)
                addChild(box)
            }
        }
        if !isEnterCaveRoom && !isBedRoom {mapPosition = (self.childNode(withName: "map") as! SKSpriteNode);setupMap(mapNumber: player.gameLevel)}
        if isBedRoom{
            player.health = 2.5 + player.baseHealth
            player.healthChanged = true
            
        }
        
        setupNpc()
        
        //        if player.round > round {
        //            round = player.round
        //            //print("door")
        //            if isMonsterRoom{
        //                cleanMonster()
        //                setupMonster()
        //                cleanDoor()
        //
        //                //setupDoor()
        //            }
        //        }
        
        self.view?.isUserInteractionEnabled = true
        player.isHidden = false
        
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
        player.itemChanged = true
        
        player.isAlived = true
        levelChanged = true
        player.isFiring = false
        player.popoStart = 6
        
        
        //if npc != nil {npc.position = npcBornPoint}
        fireButton.touchStartHandler = {self.player.isFiring = true}
        fireButton.selectedHandler = {self.player.isFiring = false}
        
        popoButton.selectedHandler = {
            //if !(self.popoStart > 6){return}
            //            self.popo = Popo(position: self.player.position + self.player.facing * 30,scene: self)
            //            self.addChild(self.popo)
            //            self.popo.shoot()
            //            self.player.popoStart = 0
            
            if self.player.item == nil {return}
            switch self.player.item.name {
            case "potion":
                let item = self.player.item as! Potion
                item.work(scene: self)
            //self.player.itemChanged = true
            case "fireBomb_1":
                let item = self.player.item as! FireBomb
                item.work(scene: self)
            case "apple":
                let item = self.player.item as! Apple
                item.work(scene: self)
            case "coke":
                let item = self.player.item as! Coke
                item.work(scene: self)
            default:
                break
            }
            
            
        }
        
        
        
        
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        
        if inDialogue {return}
        //if player.round > round{return}
        
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
        player.playerIsMoving = false
        //handleFacingHandler(phase: "ended", location: location)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        //print("\(player.itemList.count)")
        
        player.popoStart += eachFrame
        player.sinceFire += eachFrame
        player.rStart += eachFrame
        //player.fireStart += eachFrame
        sinceStart += eachFrame
        
        for i in 0..<logList.count{
            logList[i].sinceStart += eachFrame
        }
        
        playerSetupHud()
        timeControl()
        
        if npc != nil{
            npc.sinceBorn += eachFrame
            checkNpcAround()
        }
        
        if soilder != nil {
            checkSoilderAround()
        }
        
        if player.isFiring{
            self.player.weapon.attack(direction: self.player.facing,homeScene: self)
            
        }else {player.weapon.tempTime = 0.3}
        
        
        //finsh cleaning monster
        if isBornRoom || isBonusRoom {if !isDoorSet{setupDoor();isDoorSet=true}
        }else if isEnterCaveRoom {
            for i in 0..<logList.count{
                if logList[i].isAlived{break}
                if i == logList.count - 1 && !isDoorSet{
                    setupHomeOrKeepGoing()
                    isDoorSet=true
                }
            }
        }
        else{
            for i in 0..<logList.count{
                if logList[i].isAlived{break}
                if i == logList.count - 1 && !isDoorSet{setupDoor();isDoorSet=true}
            }
        }
        
        //heal effect
        for node in self.children{
            if node.name == "heal"{
                node.position = player.position
            }
        }
        
        if player.rStart > 5 {
            player.rStart = 5
            rButton.selectedHandler = {
                self.player.rStart = 0
                let wait = SKAction.wait(forDuration: 0.1)
                let fire = SKAction.run({
                                            self.player.weapon.rAttack(direction: self.player.facing,homeScene: self) })
                self.run(SKAction.sequence([fire,wait,fire,wait,fire]))
            }
            
        }else {
            let white = (rButton.childNode(withName: "white") as! SKSpriteNode)
            white.yScale = CGFloat(player.rStart)/5
            rButton.selectedHandler = {}
        }
        
        //        for i in 0..<player.itemList.count{
        //            if player.itemList[i].parent == nil {
        //                player.itemList.remove(at: i)
        //            }
        //        }
        
        checkBoxAround()
        
        for node in logList{
            if !player.isAlived{
                node.AudioPlayer2.stop()
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
                setupExitDoor(nodeA: nodeA, nodeB: nodeB)
                setupHomeOrKeepGoingPass(nodeA: nodeA, nodeB: nodeB)
                setupBulletHit(nodeA: nodeA, nodeB: nodeB)
                setupPickUp(nodeA: nodeA, nodeB: nodeB)
            }
        }
        
    }
    func setupCave()  {
        let cavePosition = (self.childNode(withName: "cavePosition") as! SKSpriteNode)
        cave = Cave()
        cave.position = cavePosition.position
        self.addChild(cave)
        
        soilder = Soilder()
        soilder.position = cave.position + CGPoint(x: 50, y: -60)
        self.addChild(soilder)
        
    }
    
    func setupBedRoom()  {
        
        book = Book()
        book.position = CGPoint(x: 460, y: 130)
        book.selectHandler = {
            self.book.open()
            let abilityHud = AbilityHud(scene: self)
            self.addChild(abilityHud)
            abilityHud.open()
            self.AudioPlayer = try! AVAudioPlayer(contentsOf: self.openBookSound as URL)
            self.AudioPlayer.volume = 5
            self.AudioPlayer.prepareToPlay()
            self.AudioPlayer.play()
        }
        addChild(book)
        
    }
    
    func cleanMonster()  {
        for log in logList{
            log.removeFromParent()
        }
        logList = []
    }
    
    func cleanDoor()  {
        
        for node in self.children{
            if node.isMember(of: Door.self){
                if node.name == "rightDoor" || node.name == "leftDoor" || node.name == "topDoor" || node.name == "bottomDoor"{
                    node.removeFromParent()
                    //print("clean")
                }
            }
        }
        isDoorSet = false
    }
    func checkSoilderAround()  {
        
        let dist = player.position.distanceTo(soilder.position)
        if dist < 50 {
            if !dialogueIsSet {
                dialogueIsSet = true
                //sound
                self.AudioPlayer = try! AVAudioPlayer(contentsOf: self.stopSound as URL)
                
                self.AudioPlayer.volume = 3
                self.AudioPlayer.prepareToPlay()
                self.AudioPlayer.play()
                
                dialogue = Dialogue()
                dialogue.position = soilder.position + CGPoint(x: 0, y: 30)
                dialogue.selectHandler = {
                    
                    self.bigDialogue = BigDialogue(scene: self)
                    self.bigDialogue.position = self.dialogue.position
                    self.addChild(self.bigDialogue)
                    self.bigDialogue.run(SKAction.move(to: CGPoint(x: 131, y: 187), duration: 0.5))
                    self.bigDialogue.run(SKAction.scale(to: CGSize(width: 412, height: 124), duration: 0.5))
                    
                    //tricky way to disable handler
                    self.inDialogue = true
                    self.popoButton.isUserInteractionEnabled = false
                    self.fireButton.isUserInteractionEnabled = false
                    self.dialogue.removeFromParent()
                    
                    self.bigDialogue.startWord(sentence: Word().caveWord)
                    self.run(SKAction.sequence([SKAction.wait(forDuration: 2),SKAction.run(self.addWordButton)]))
                    
                }
                
                addChild(dialogue)
                dialogue.start()
                
            }
        }else{
            if dialogue != nil {
                dialogue.removeFromParent()
                dialogueIsSet = false
            }
        }
    }
    
    func addWordButton()  {
        let enterButton = WordButton(name: "enter")
        let leaveButton = WordButton(name: "leave")
        enterButton.position = CGPoint(x: 400, y: 100)
        leaveButton.position = CGPoint(x: 480, y: 100)
        self.addChild(enterButton)
        self.addChild(leaveButton)
        
        enterButton.selectHandler = {
            if self.bigDialogue.isFinish{
                self.bigDialogue.removeFromParent()
                for node in self.bigDialogue.wordList{
                    node.removeFromParent()
                }
                //tricky way to enable handler
                self.inDialogue = false
                self.popoButton.isUserInteractionEnabled = true
                self.fireButton.isUserInteractionEnabled = true
                //homeScene.dialogue.isHidden = false
                enterButton.removeFromParent()
                leaveButton.removeFromParent()
            }
            
            if  let view = self.view as SKView?{
                if let scene = GameScene.level(5){
                    // Set the scale mode to scale to fit the window
                    scene.isEnterCaveRoom = true
                    scene.isMonsterRoom = true
                    scene.scaleMode = .aspectFit
                    scene.player = self.player
                    scene.player.position = CGPoint(x: 160, y: 250)
                    //let fadeAction = SKTransition.fade(withDuration: 1)
                    view.presentScene(scene)
                    
                    
                    view.ignoresSiblingOrder = true
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
            
        }
        
        
        
        leaveButton.selectHandler = {
            if self.bigDialogue.isFinish{
                self.bigDialogue.removeFromParent()
                for node in self.bigDialogue.wordList{
                    node.removeFromParent()
                }
                //tricky way to enable handler
                self.inDialogue = false
                self.popoButton.isUserInteractionEnabled = true
                self.fireButton.isUserInteractionEnabled = true
                //homeScene.dialogue.isHidden = false
                enterButton.removeFromParent()
                leaveButton.removeFromParent()
            }
        }
        
    }
    
    func checkBoxAround() {
        if box == nil {return}
        let dist = player.position.distanceTo(box.position)
        if !boxIsSet{
            if dist < 50 && !box.isOpen{
                boxIsSet = true
                box.open()
                box.isOpen = true
                //pop some item
                bornItemTexture(num: 8, position: box.position, homeScene: self)
                
            }
        }
    }
    
    
    
    
    
    func checkNpcAround() {
        let dist = player.position.distanceTo(npc.position)
        if dist < 60 {
            if !dialogueIsSet {
                dialogueIsSet = true
                dialogue = Dialogue()
                dialogue.position = npc.position + CGPoint(x: 0, y: 30)
                //set hello
                self.AudioPlayer = try! AVAudioPlayer(contentsOf: self.helloSound as URL)
                
                self.AudioPlayer.volume = 3
                self.AudioPlayer.prepareToPlay()
                self.AudioPlayer.play()
                
                
                
                dialogue.selectHandler = {
                    
                    let bigDialogue = BigDialogue(scene: self)
                    bigDialogue.position = self.dialogue.position
                    self.addChild(bigDialogue)
                    bigDialogue.run(SKAction.move(to: CGPoint(x: 131, y: 187), duration: 0.5))
                    bigDialogue.run(SKAction.scale(to: CGSize(width: 412, height: 124), duration: 0.5))
                    
                    //tricky way to disable handler
                    self.inDialogue = true
                    self.popoButton.isUserInteractionEnabled = false
                    self.fireButton.isUserInteractionEnabled = false
                    self.dialogue.removeFromParent()
                    
                    bigDialogue.startWord(sentence: Word().helloWord)
                    bigDialogue.selectHandler = {
                        bigDialogue.justClose()
                    }
                    
                }
                
                addChild(dialogue)
                dialogue.start()
                
            }
            npc.state = .idle
            npc.sinceBorn = 0
        }else{
            if dialogue != nil {
                dialogue.removeFromParent()
                dialogueIsSet = false
            }
        }
        
        
    }
    
    func setupNpc() {
        if !isBornRoom{return}
        if isBreakRoom{return}
        if npc != nil {npc.removeFromParent()}
        npc = Npc()
        npc.position = npcBornPoint
        self.addChild(npc)
    }
    
    
    func playerSetupHud() {
        
        //set item
        if player.itemChanged{
            //print("\(player.itemList.count)")
            if player.item != nil {
                
                let popoButton = (self.childNode(withName: "popoButton") as! SKSpriteNode)
                popoButton.removeAllChildren()
                
                let texture = SKTexture(imageNamed: player.item.name!)
                //print("\(player.itemList[0].name!)")
                let item = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 25, height: 25))
                item.zPosition = 1
                item.position = CGPoint(x: 0, y: 0)
                popoButton.addChild(item)
                item.run(SKAction(named: "coinPop")!)
                
            }else {
                let popoButton = (self.childNode(withName: "popoButton") as! SKSpriteNode)
                popoButton.removeAllChildren()
                
            }
            player.itemChanged = false
            
        }
        
        
        //set game level
        if levelChanged{
            //print("\(level)")
            if levelNumber != nil {levelNumber.removeFromParent()}
            levelNumber = Num(number: player.gameLevel, size: 20)
            levelNumber.position = CGPoint(x: 640, y: 28)
            levelNumber.run(SKAction(named: "idle")!)
            addChild(levelNumber)
            levelChanged = false
        }
        
        //set exp
        if player.expChanged{
            let expBar = (self.childNode(withName: "//expBar") as! SKSpriteNode)
            expBar.xScale = player.exp/100
            player.expChanged = false
        }
        
        //set health
        if player.healthChanged {
            
            if player.health < 0 {player.healthChanged = false;return}
            
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
            
            if integer == 0{
                let newHeart = Heart(number: left)
                newHeart.run(SKAction(named: "idle")!)
                newHeart.position =  CGPoint(x: 0, y: 0)
                heartBorn.addChild(newHeart)
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
            
            let first = SKAction.run({
                let firstMoneyNode = Num(number: firstMoney,size: 15)
                moneyBorn.addChild(firstMoneyNode)
                firstMoneyNode.position = CGPoint(x: 0, y: 0)
                firstMoneyNode.run(SKAction(named: "coinPop")!)
            })
            let second = SKAction.run({
                let secondMoneyNode = Num(number: secondMoney,size: 15)
                moneyBorn.addChild(secondMoneyNode)
                secondMoneyNode.position = CGPoint(x: 15, y: 0)
                secondMoneyNode.run(SKAction(named: "coinPop")!)
            })
            let third = SKAction.run({
                let thirdMoneyNode = Num(number: thirdMoney,size: 15)
                moneyBorn.addChild(thirdMoneyNode)
                thirdMoneyNode.position = CGPoint(x: 30, y: 0)
                thirdMoneyNode.run(SKAction(named: "coinPop")!)
            })
            let wait = SKAction.wait(forDuration: 0.2)
            self.run(SKAction.sequence([first,wait,second,wait,third]))
            
            
            
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
        if weaponOnHand != nil {
            weaponOnHand.zRotation  = (player.facing.angle) * (3.14/180)
        }
        
        
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
    
    func setupPickUp(nodeA: SKNode, nodeB: SKNode)  {
        if nodeA.name == "heart" && nodeB.name == "player"{
            //print("hit!")
            let heart = nodeA as! HeartDrop
            heart.removeFromParent()
            player.health += 0.25
            player.healthChanged = true
            let sound = SKAction.playSoundFileNamed("heal.mp3", waitForCompletion: true)
            self.run(sound)
            let healEffect = SKEmitterNode(fileNamed: "healParticle")!
            healEffect.name = "heal"
            healEffect.position = player.position
            addChild(healEffect)
            healEffect.run(SKAction.sequence([SKAction.wait(forDuration: 3),SKAction.removeFromParent()]))
        }
        if nodeB.name == "heart" && nodeA.name == "player"{
            
            let heart = nodeB as! HeartDrop
            heart.removeFromParent()
            
            player.health += 0.25
            player.healthChanged = true
            let sound = SKAction.playSoundFileNamed("heal.mp3", waitForCompletion: true)
            self.run(sound)
            let healEffect = SKEmitterNode(fileNamed: "healParticle")!
            healEffect.name = "heal"
            healEffect.position = player.position
            addChild(healEffect)
            healEffect.run(SKAction.sequence([SKAction.wait(forDuration: 3),SKAction.removeFromParent()]))
        }
        
        if nodeA.name == "coin" && nodeB.name == "player"{
            //print("hit!")
            let coin = nodeA as! CoinDrop
            coin.removeFromParent()
            player.money += CGFloat.random(in: 5..<10)
            player.moneyChanged = true
            let sound = SKAction.playSoundFileNamed("coin.wav", waitForCompletion: true)
            self.run(sound)
            
        }
        
        if nodeB.name == "coin" && nodeA.name == "player"{
            //print("hit!")
            let coin = nodeB as! CoinDrop
            coin.removeFromParent()
            player.money += CGFloat.random(in: 5..<10)
            player.moneyChanged = true
            let sound = SKAction.playSoundFileNamed("coin.wav", waitForCompletion: true)
            self.run(sound)
            
        }
        
        if nodeA.name == "potionTexture" && nodeB.name == "player"{
            
            player.itemList.append(Potion())
            setupItemOrder()
            self.run(SKAction.playSoundFileNamed("bottle.wav", waitForCompletion: true))
            
            movToPopo(node: nodeA)
            
        }
        
        if nodeA.name == "player" && nodeB.name == "potionTexture"{
            
            player.itemList.append(Potion())
            setupItemOrder()
            self.run(SKAction.playSoundFileNamed("bottle.wav", waitForCompletion: true))
            
            movToPopo(node: nodeB)
            
        }
        
        if nodeA.name == "fireBombTexture" && nodeB.name == "player"{
            
            player.itemList.append(FireBomb())
            setupItemOrder()
            self.run(SKAction.playSoundFileNamed("pick.mp3", waitForCompletion: true))
            
            movToPopo(node: nodeA)
            
        }
        
        if nodeA.name == "player" && nodeB.name == "fireBombTexture"{
            
            player.itemList.append(FireBomb())
            setupItemOrder()
            self.run(SKAction.playSoundFileNamed("pick.mp3", waitForCompletion: true))
            
            movToPopo(node: nodeB)
            
        }
        
        if nodeA.name == "appleTexture" && nodeB.name == "player"{
            
            player.itemList.append(Apple())
            setupItemOrder()
            self.run(SKAction.playSoundFileNamed("pick.mp3", waitForCompletion: true))
            
            movToPopo(node: nodeA)
            
        }
        
        if nodeA.name == "player" && nodeB.name == "appleTexture"{
            
            player.itemList.append(Apple())
            setupItemOrder()
            self.run(SKAction.playSoundFileNamed("pick.mp3", waitForCompletion: true))
            
            movToPopo(node: nodeB)
            
        }
        
        if nodeA.name == "cokeTexture" && nodeB.name == "player"{
            
            player.itemList.append(Coke())
            setupItemOrder()
            self.run(SKAction.playSoundFileNamed("pick.mp3", waitForCompletion: true))
            
            movToPopo(node: nodeA)
            
        }
        
        if nodeA.name == "player" && nodeB.name == "cokeTexture"{
            
            player.itemList.append(Coke())
            setupItemOrder()
            self.run(SKAction.playSoundFileNamed("pick.mp3", waitForCompletion: true))
            
            movToPopo(node: nodeB)
            
        }
        
    }
    
    func movToPopo(node: SKNode)  {
        let popoButton = (self.childNode(withName: "popoButton") as! MSButtonNode)
        
        let action = SKAction.move(to: popoButton.position, duration: 0.5)
        action.timingMode = .easeInEaseOut
        node.physicsBody = nil
        node.run(SKAction.sequence([action,SKAction.removeFromParent()]))
        node.run(SKAction.fadeAlpha(to: 0, duration: 0.5))
    }
    
    func setupItemOrder()  {
        if player.itemList.count == 1{
            player.item = player.itemList[0]
        }else{
            player.item = player.itemList[player.itemList.count-1]
            player.inItemListNumber = player.itemList.count-1
        }
        player.itemChanged = true
    }
    
    func setupBulletHit(nodeA: SKNode, nodeB: SKNode)  {
        if nodeA.name == "staffBullet" {
            //print("hit!")
            let bullet = nodeA as! Bullet
            bullet.removeFromParent()
            let bulletHitPoint = BulletHitPoint(scene: self)
            bulletHitPoint.hit()
        }
        if nodeB.name == "staffBullet" {
            
            let bullet = nodeB as! Bullet
            let bulletHitPoint = BulletHitPoint(scene: self)
            bulletHitPoint.position = bullet.position
            addChild(bulletHitPoint)
            bulletHitPoint.hit()
            bullet.removeFromParent()
        }
        
    }
    
    func setupHomeOrKeepGoingPass(nodeA: SKNode, nodeB: SKNode) {
        if nodeA.name == "homeDoor" || nodeB.name == "homeDoor"{
            //print("go home")
            if  let view = self.view as SKView?{
                if let scene = player.roomScene{
                    scene.scaleMode = .aspectFit
                    scene.isBedRoom = true
                    scene.player = self.player
                    scene.player.position = CGPoint(x: 160, y: 250)
                    
                    let fade = SKTransition.fade(withDuration: 1)
                    view.presentScene(scene, transition: fade)
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                    view.ignoresSiblingOrder = true
                    
                }
            }
        }
        
        if nodeA.name == "continueDoor" || nodeB.name == "continueDoor"{
            
            
            player.gameLevel += 1
            //print("\(level)")
            levelChanged = true
            switch player.gameLevel {
            case 2:
                player.inMapNumber = Int.random(in: 0..<Map().map2.count)
                map = Map().map2[player.inMapNumber]
            case 3:
                player.inMapNumber = Int.random(in: 0..<Map().map3.count)
                map = Map().map3[player.inMapNumber]
            default:
                player.inMapNumber = Int.random(in: 0..<Map().map3.count)
                map = Map().map3[player.inMapNumber]
            }
            setupSceneList()
            let bornScene = sceneList[self.bornRoom()]
            player.bornScene = bornScene
            if  let view = self.view as SKView?{
                if let scene = player.bornScene{
                    scene.scaleMode = .aspectFit
                    scene.player = self.player
                    scene.player.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
                    scene.sceneList = sceneList
                    let fade = SKTransition.fade(withDuration: 1)
                    view.presentScene(scene, transition: fade)
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                    view.ignoresSiblingOrder = true
                    
                }
            }
        }
    }
    
    func setupExitDoor(nodeA: SKNode, nodeB: SKNode) {
        if nodeA.name == "exitDoor" || nodeB.name == "exitDoor"{
            
            sceneList.removeAll()
            //print("\(sceneList.count)")
            player.inMapNumber = Int.random(in: 0..<Map().map1.count)
            map = Map().map1[player.inMapNumber]
            setupSceneList()
            let bornScene = sceneList[self.bornRoom()]
            //print("\(sceneList.count)")
            player.bornScene = bornScene
            
            if  let view = self.view as SKView?{
                if let scene = player.bornScene{
                    scene.scaleMode = .aspectFit
                    scene.player = self.player
                    scene.player.position = CGPoint(x: 209, y: 202)
                    scene.player.run(SKAction(named: "playerForward")!)
                    scene.sceneList = sceneList
                    
                    let fade = SKTransition.fade(withDuration: 1)
                    view.presentScene(scene, transition: fade)
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                    view.ignoresSiblingOrder = true
                    
                }
            }
            self.AudioPlayer = try! AVAudioPlayer(contentsOf: self.doorCloseSound as URL)
            self.AudioPlayer.volume = 3
            self.AudioPlayer.prepareToPlay()
            self.AudioPlayer.play()
            
            
            // }
        }
    }
    
    func setupDamage(nodeA: SKNode, nodeB: SKNode) {
        if (nodeA.name == "staffBullet" && nodeB.name == "log"){
            //            let bullet = nodeA as! Bullet
            //            bullet.removeFromParent()
            let log = nodeB as! Log
            log.beingHit()
            
            
        }
        if (nodeA.name == "log" && nodeB.name == "staffBullet"){
            //            let bullet = nodeB as! Bullet
            //            bullet.removeFromParent()
            let log = nodeA as! Log
            log.beingHit()
            
        }
        
        if (nodeA.name == "log" && nodeB.name == "player"){
            
            player.beingHit()
            //let log = nodeA as! Log
            //log.health -= 0.25
            
            
        }
        if (nodeA.name == "player" && nodeB.name == "log"){
            
            player.beingHit()
            //let log = nodeB as! Log
            //log.health -= 0.25
            
        }
        
        
        
    }
    
    func timeControl()  {
        if sinceStart > eachFrame{
            handler.isHidden = false
        }
        if player.popoStart < 6 {popoButton.isHidden = true} else {popoButton.isHidden = false}
        
        //        if player.fireStart < player.weapon.attackSpeed {fireButton.isHidden = true} else{
        //            fireButton.isHidden = false
        //        }
        
        if player.playerIsMoving{
            player.position+=(player.facing * player.moveDistance)
        }
    }
    
    func setupMonster() {
        for _ in 0..<3 {
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
    
    
    
    func setupMap(mapNumber: Int) {
        //clean newroom
        for node in self.children {
            if node.name == "newRoom" {
                node.removeFromParent()
            }
        }
        
        //add newroom
        var map: [[Int]]
        switch mapNumber {
        case 1:
            map = Map().map1[player.inMapNumber]
        case 2:
            map = Map().map2[player.inMapNumber]
        case 3:
            map = Map().map3[player.inMapNumber]
        default:
            map = Map().map1[player.inMapNumber]
        }
        
        for y in 0..<Map().sceneRow{
            for x in 0..<Map().sceneCol{
                //set room for none zero
                if map[y][x] != 0 {
                    let newRoom = SKSpriteNode(color: .white, size: CGSize(width: 20, height: 20))
                    newRoom.name = "newRoom"
                    newRoom.zPosition = 2
                    newRoom.alpha = 0.5
                    //player room
                    
                    
                    //bonus room
                    if map[y][x] == 3 {
                        newRoom.color = .yellow
                    }
                    
                    //monster clean room
                    let scene = getSceneFromMap(y: y,x: x)
                    if map[y][x] == 1 && scene.isDoorSet{
                        newRoom.color = .blue
                    }
                    //cave room
                    if map[y][x] == 5 {
                        newRoom.color = .black
                    }
                    
                    //home room
                    if map[y][x] == 2 {
                        newRoom.color = .purple
                    }
                    
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
    
    func getSceneFromMap(y: Int,x: Int) -> GameScene {
        var resultScene: GameScene!
        
        for scene in sceneList{
            
            if scene.YX.x == x && scene.YX.y == y{
                resultScene = scene
                break
            }
        }
        
        return resultScene
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
                scene?.sceneList = sceneList
                view.presentScene(scene!, transition: fade)
                view.showsFPS = true
                view.showsNodeCount = true
                view.ignoresSiblingOrder = true
                
                self.AudioPlayer = try! AVAudioPlayer(contentsOf: self.portalSound as URL)
                
                self.AudioPlayer.volume = 5
                self.AudioPlayer.prepareToPlay()
                self.AudioPlayer.play()
                
            }
        }
        if (nodeA.name == "leftDoor" && nodeB.name == "player") || (nodeA.name == "player" && nodeB.name == "leftDoor") {
            if  let view = self.view as SKView?{
                let scene = self.left
                scene?.scaleMode = .aspectFit
                scene?.player = player
                scene?.player.position = rightDoor.position + CGPoint(x: -70, y: 0)
                //scene?.handler.position = self.handler.position
                scene?.sceneList = sceneList
                view.presentScene(scene!, transition: fade)
                view.showsFPS = true
                view.showsNodeCount = true
                view.ignoresSiblingOrder = true
                self.AudioPlayer = try! AVAudioPlayer(contentsOf: self.portalSound as URL)
                
                self.AudioPlayer.volume = 5
                self.AudioPlayer.prepareToPlay()
                self.AudioPlayer.play()
                
            }
            
        }
        if (nodeA.name == "topDoor" && nodeB.name == "player") || (nodeA.name == "player" && nodeB.name == "topDoor") {
            if  let view = self.view as SKView?{
                let scene = self.top
                scene?.scaleMode = .aspectFit
                scene?.player = player
                scene?.player.position = bottomDoor.position + CGPoint(x: 0, y: 70)
                //scene?.handler.position = self.handler.position
                scene?.sceneList = sceneList
                view.presentScene(scene!, transition: fade)
                view.showsFPS = true
                view.showsNodeCount = true
                view.ignoresSiblingOrder = true
                
                self.AudioPlayer = try! AVAudioPlayer(contentsOf: self.portalSound as URL)
                
                self.AudioPlayer.volume = 5
                self.AudioPlayer.prepareToPlay()
                self.AudioPlayer.play()
            }
        }
        if (nodeA.name == "bottomDoor" && nodeB.name == "player") || (nodeA.name == "player" && nodeB.name == "bottomDoor") {
            if  let view = self.view as SKView?{
                let scene = self.bototm
                scene?.scaleMode = .aspectFit
                scene?.player = player
                scene?.player.position = topDoor.position + CGPoint(x: 0, y: -70)
                //scene?.handler.position = self.handler.position
                scene?.sceneList = sceneList
                view.presentScene(scene!, transition: fade)
                view.showsFPS = true
                view.showsNodeCount = true
                view.ignoresSiblingOrder = true
                
                self.AudioPlayer = try! AVAudioPlayer(contentsOf: self.portalSound as URL)
                
                self.AudioPlayer.volume = 5
                self.AudioPlayer.prepareToPlay()
                self.AudioPlayer.play()
            }
        }
        
        
        
        //self.setupIsSet = true
    }
    
    func setupHomeOrKeepGoing()  {
        let homeBoard = Board(name: "home")
        let homePosition = (self.childNode(withName: "homePosition") as! SKSpriteNode)
        homeBoard.position = homePosition.position
        homeBoard.selectHandler = {
            let homePortal = Door(position: homeBoard.position + CGPoint(x: 0, y: 50), name: "homeDoor")
            self.addChild(homePortal)
        }
        addChild(homeBoard)
        
        if player.gameLevel == 5 {player.gameLevel = 1;return}
        
        let continueBoard = Board(name: "continue")
        let continuePosition = (self.childNode(withName: "continuePosition") as! SKSpriteNode)
        continueBoard.position = continuePosition.position
        continueBoard.selectHandler = {
            let continuePortal = Door(position: continueBoard.position + CGPoint(x: 0, y: 50), name: "continueDoor")
            
            self.addChild(continuePortal)
        }
        addChild(continueBoard)
        
        
    }
    
    
    func setupDoor() {
        topDoor = (self.childNode(withName: "topDoor") as! SKSpriteNode)
        bottomDoor = (self.childNode(withName: "bottomDoor") as! SKSpriteNode)
        leftDoor = (self.childNode(withName: "leftDoor") as! SKSpriteNode)
        rightDoor = (self.childNode(withName: "rightDoor") as! SKSpriteNode)
        let wait = SKAction.wait(forDuration: 0.5)
        let firstAction = SKAction.run({
            if self.top != nil {
                let door = Door(position: self.topDoor.position,name: "topDoor")
                self.addChild(door)
                
                self.AudioPlayer = try! AVAudioPlayer(contentsOf: self.portalBornSound as URL)
                self.AudioPlayer.volume = 2
                self.AudioPlayer.prepareToPlay()
                self.AudioPlayer.play()
                
            }
        })
        let secondAction = SKAction.run({
            if self.bototm != nil {
                
                let door = Door(position: self.bottomDoor.position,name: "bottomDoor")
                self.addChild(door)
                
                self.AudioPlayer = try! AVAudioPlayer(contentsOf: self.portalBornSound as URL)
                self.AudioPlayer.volume = 2
                self.AudioPlayer.prepareToPlay()
                self.AudioPlayer.play()
                
            }
        })
        
        let thirdAction = SKAction.run({
            if self.left != nil {
                
                let door = Door(position: self.leftDoor.position,name: "leftDoor")
                self.addChild(door)
                
                self.AudioPlayer = try! AVAudioPlayer(contentsOf: self.portalBornSound as URL)
                self.AudioPlayer.volume = 2
                self.AudioPlayer.prepareToPlay()
                self.AudioPlayer.play()
            }
        })
        let fourthAction = SKAction.run({
            if self.right != nil {
                
                let door = Door(position: self.rightDoor.position,name: "rightDoor")
                self.addChild(door)
                
                self.AudioPlayer = try! AVAudioPlayer(contentsOf: self.portalBornSound as URL)
                self.AudioPlayer.volume = 2
                self.AudioPlayer.prepareToPlay()
                self.AudioPlayer.play()
                
            }
        })
        
        self.run(SKAction.sequence([firstAction,wait,secondAction,wait,thirdAction,wait,fourthAction]))
        
        
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
    
    func setupSceneList()  {
        //new scene
        for y in 0..<Map().sceneRow{
            for x in 0..<Map().sceneCol{
                if self.map[y][x] != 0{
                    //print("y: \(y),x: \(x)")
                    
                    if self.map[y][x] == 2 {
                        let gameScene = GameScene.level(2)!
                        gameScene.YX = GridYX(y: y, x: x)
                        gameScene.isBornRoom = true
                        sceneList.append(gameScene)
                    }else if self.map[y][x] == 3 {
                        let gameScene = GameScene.level(3)!
                        gameScene.YX = GridYX(y: y, x: x)
                        gameScene.isBonusRoom = true
                        sceneList.append(gameScene)
                    }
                    else if self.map[y][x] == 1{
                        let gameScene = GameScene.level(1)!
                        gameScene.YX = GridYX(y: y, x: x)
                        gameScene.isMonsterRoom = true
                        sceneList.append(gameScene)
                    }else if self.map[y][x] == 5 {
                        let gameScene = GameScene.level(1)!
                        gameScene.YX = GridYX(y: y, x: x)
                        gameScene.isCaveRoom = true
                        gameScene.isMonsterRoom = true
                        sceneList.append(gameScene)
                    }else if self.map[y][x] == 6 {
                        let gameScene = GameScene.level(6)!
                        gameScene.YX = GridYX(y: y, x: x)
                        gameScene.isBreakRoom = true
                        gameScene.isBornRoom = true
                        sceneList.append(gameScene)
                    }
                }
            }
        }
        
        
        //set relation
        
        for i in 0..<sceneList.count {
            
            let x = sceneList[i].YX.x!
            let y = sceneList[i].YX.y!
            
            //check top
            if y == 0 {sceneList[i].top = nil}
            else{ if map[y-1][x] != 0 {
                for j in 0..<sceneList.count {
                    if sceneList[j].YX.x == x && sceneList[j].YX.y == y-1 {
                        sceneList[i].top = sceneList[j]
                    }
                }
            }}
            
            //check bottom
            if y == 4 {sceneList[i].bototm = nil}
            else{ if map[y+1][x] != 0 {
                for j in 0..<sceneList.count {
                    if sceneList[j].YX.x == x && sceneList[j].YX.y == y+1 {
                        sceneList[i].bototm = sceneList[j]
                    }
                }
            }}
            
            //check left
            if x == 0 {sceneList[i].left = nil}
            else{ if map[y][x-1] != 0 {
                for j in 0..<sceneList.count {
                    if sceneList[j].YX.x == x-1 && sceneList[j].YX.y == y {
                        sceneList[i].left = sceneList[j]
                    }
                }
            }}
            
            //check right
            if x == 6 {sceneList[i].right = nil}
            else{ if map[y][x+1] != 0 {
                for j in 0..<sceneList.count {
                    if sceneList[j].YX.x == x+1 && sceneList[j].YX.y == y {
                        sceneList[i].right = sceneList[j]
                    }
                }
            }}
            
            
        }
    }
    
    func bornRoom() -> Int {
        var room: Int!
        
        for i in 0..<sceneList.count{
            if sceneList[i].isBornRoom{
                room = i
                break
            }
        }
        return room
    }
    
    
    
}


