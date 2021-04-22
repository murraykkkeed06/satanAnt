//
//  GameScene.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/3/24.
//

import SpriteKit
import GameplayKit
import AVFoundation
import SwiftyJSON

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    
    let portalsound = SKAction.playSoundFileNamed("portal.mp3", waitForCompletion: false)
    let portalBornSound = SKAction.playSoundFileNamed("portalBorn.wav", waitForCompletion: false)
    let stopSound = SKAction.playSoundFileNamed("stop.mp3", waitForCompletion: false)
    let helloSound = SKAction.playSoundFileNamed("hello.mp3", waitForCompletion: false)
    let pickSound = SKAction.playSoundFileNamed("pick.mp3", waitForCompletion: false)
    let bottleSound = SKAction.playSoundFileNamed("bottle.wav", waitForCompletion: false)
    let doorSound = SKAction.playSoundFileNamed("door.mp3", waitForCompletion: false)
    let errorSound = SKAction.playSoundFileNamed("error.mp3", waitForCompletion: false)
    let slideSound = SKAction.playSoundFileNamed("slide.wav", waitForCompletion: false)
    let startSound = SKAction.playSoundFileNamed("start.wav", waitForCompletion: false)
    let barkSound = SKAction.playSoundFileNamed("bark.wav", waitForCompletion: false)
    let openChestSound = SKAction.playSoundFileNamed("openChest.wav", waitForCompletion: false)
    let wearSound = SKAction.playSoundFileNamed("wear.wav", waitForCompletion: false)
    let landSound = SKAction.playSoundFileNamed("land.wav", waitForCompletion: false)
    let chickenSound = SKAction.playSoundFileNamed("chickenSound.mp3", waitForCompletion: false)
    let meowSound = SKAction.playSoundFileNamed("meow.wav", waitForCompletion: false)
    let plantDogScreamSound = SKAction.playSoundFileNamed("plantDogScream.wav", waitForCompletion: false)
    let canonFireSound = SKAction.playSoundFileNamed("canonFire.mp3", waitForCompletion: false)
    let birdSound = SKAction.playSoundFileNamed("bird.wav", waitForCompletion: false)
    let bornSound = SKAction.playSoundFileNamed("bornSound.wav", waitForCompletion: false)
    let fireHitSound = SKAction.playSoundFileNamed("fireHit.mp3", waitForCompletion: false)
    let monsterShowSound = SKAction.playSoundFileNamed("monsterShow.mp3", waitForCompletion: false)
    let shootSound = SKAction.playSoundFileNamed("shoot.mp3", waitForCompletion: false)
    let healSound = SKAction.playSoundFileNamed("heal.mp3", waitForCompletion: false)
    let candyBarAttackSound = SKAction.playSoundFileNamed("candyBarAttack.wav", waitForCompletion: false)
    let windSound = SKAction.playSoundFileNamed("wind.wav", waitForCompletion: false)
    let swordHitSound = SKAction.playSoundFileNamed("swordHit.wav", waitForCompletion: false)
    let throwSound = SKAction.playSoundFileNamed("throw.wav", waitForCompletion: false)
    let explosionSound = SKAction.playSoundFileNamed("explosion.wav", waitForCompletion: false)
    let biggerSound = SKAction.playSoundFileNamed("bigger.wav", waitForCompletion: false)
    let eatSound = SKAction.playSoundFileNamed("eat.mp3", waitForCompletion: false)
    let coinSound = SKAction.playSoundFileNamed("coin.wav", waitForCompletion: false)
    let pressSound = SKAction.playSoundFileNamed("press.mp3", waitForCompletion: false)
    let transferSound = SKAction.playSoundFileNamed("transfer.mp3", waitForCompletion: true)
    let logDieSound = SKAction.playSoundFileNamed("logDie.wav", waitForCompletion: false)
    let slimeJumpSound = SKAction.playSoundFileNamed("slimeJump.mp3", waitForCompletion: false)
    let slimeDieSound = SKAction.playSoundFileNamed("slimeDie.wav", waitForCompletion: false)
    let ghostAttackSound = SKAction.playSoundFileNamed("ghostAttack.mp3", waitForCompletion: false)
    let ghostDieSound = SKAction.playSoundFileNamed("ghostDie.wav", waitForCompletion: false)
    let logHurtSound = SKAction.playSoundFileNamed("logHurt.mp3", waitForCompletion: false)
    let playerHurtSound = SKAction.playSoundFileNamed("playerHurt.wav", waitForCompletion: false)
    
    
    
    
    var sceneList = [GameScene]()
    
    var map = [[Int]]()
    
    
    var levelChanged = true
    
    var monsterList = [Monster]()
    
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
    
    var birdBornStart: TimeInterval = 0
    
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
    var isSecretRoom = false
    var isBackFromSecretRoom = false
    var isChallengeRoom = false
    var isVillageRoom = false
    var isStoneRoom = false
    var isFishRoom = false
    var isMonsterBonusRoom = false
    var isFarmRoom = false
    var isGameRoom = false
    var isStartRoom = false
    
    var YX: GridYX!
    
    var isClean = false
    
    var statueIsMoving = false
    
    var isDoorSet = false
    var dialogueIsSet = false
    var farmBarDialogueIsSet = false
    var dialogue: Dialogue!
    var farmDialogue: Dialogue!
    var loveDialogueIsSet = false
    var girlDialogue: Dialogue!
    var girlDialogueIsSet = false
    var statueDialogue: Dialogue!
    var statueDialogueIsSet = false
    var makerDialogue: Dialogue!
    var makerDialogueIsSet = false
    var scientistDialogue: Dialogue!
    var scientistDialogueIsSet = false
    var vendingMachineDialogue: Dialogue!
    var vendingMachineDialogueIsSet = false
    var weaponOnHand: SKSpriteNode!
    var npcBornPoint = CGPoint(x: 350, y: 220)
    var inDialogue = false
    
    var book: Book!
    
    var soilder: Soilder!
    
    var cave: Cave!
    
    var levelNumber: Num!
    
    var bigDialogue: BigDialogue!
    var storeDialogue: StoreDialogue!
    var transferDialogue: TransferDialogue!
    
    var bornEffect: BornEffect!
    
    var popo: Popo!
    
    var npc: Npc!
    var villageGirl: VillageGirl!
    var scientist: Scientist!
    
    var collectionBorn: SKNode!
    var eggBorn: SKNode!
    var powerBorn: SKNode!
    
    var powerTextureBorn: SKNode!
    var selectionArrow: SKNode!
    var selectionWord: SKLabelNode!
    var lastSelectionNode: SKNode!
    
    var fishGot: Fish!
    
    /* Make a Class method to load levels */
    class func level(_ levelNumber: Int) -> GameScene? {
        
        if levelNumber == 1 {
            let randomMap = Int.random(in: 0..<6)
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
        
        
        
        if !self.setupIsSet {
            setupIsSet = true
            eachRoomSetting()
            
            
        }
        
        eachEnterSetting()
        
        
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        
        setupPowerSelection(location: location)
        
        if inDialogue {return}
       
        if location.x > self.frame.width/2{
            mount.position = location
            handler.position = location
        }
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
        
        player.state = .idle
        handleHandler(phase: "ended", location: location)
        player.playerIsMoving = false
       
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        if sinceStart > eachFrame{
            handler.isHidden = false
        }
        if player.playerIsMoving{
            player.position+=(player.movingDirection * player.moveDistance)
        }
        

        playerSetupHud()
        checkSoilderAround()
        checkGirlAround()
        checkStatueAround()
        checkMakerAround()
        checkScientistAround()
        checkVendingMachineAround()
        checkBoxAround()
        checkFarmBarAround()
        checkNpcAround()
        checkFoxAround()
        canonDetect()
        monsterAutoAttackDetect()
        //setupZPosition()
        setupLevelClean()
        setupBirdInBackground()
        setupPlayerAttack()
        setupPositionFollow()
        setupSinceStartCounting()
        setupPowerRemove()
        setupFishChangeAnchorPoint()
        setupFishingRod()
        setupSlotMachine()
        
  
        
        
    }
    
    
    
    //update end
    
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
                setupMonsterGetHeartDrop(nodeA: nodeA, nodeB: nodeB)
                setupHitBreak(nodeA: nodeA, nodeB: nodeB)
                setupHoleEnter(nodeA: nodeA, nodeB: nodeB)
                setupFarmRoomTransport(nodeA: nodeA, nodeB: nodeB)
                setupGameRoomEnterAndBack(nodeA: nodeA, nodeB: nodeB)
            }
        }
        
    }
    
    
    
    
    func setupCanon()  {
        if isMonsterRoom{
            for _ in 0..<Int.random(in: 0..<4){
                
                var canon: Canon!
                
                var newX = CGFloat.random(in: 50..<self.frame.width-50)
                var newY = CGFloat.random(in: 50..<self.frame.height-50)
                
                while atPoint(CGPoint(x: newX, y: newY)).physicsBody != nil {
                    newX = CGFloat.random(in: 50..<self.frame.width-50)
                    newY = CGFloat.random(in: 50..<self.frame.height-50)
                }
                
                if newX > self.frame.width/2 {
                    canon = Canon(canonDirection: .left, scene: self)
                }else {
                    canon = Canon(canonDirection: .right, scene: self)
                }
                canon.position = CGPoint(x: newX, y: newY)
                
                addChild(canon)
                
            }
        }
        
    }
    
    func monsterAutoAttackDetect() {
        for monster in monsterList{
            if monster.position.distanceTo(player.position) < 140 && monster.isAlived && player.playerIsMoving{
                
                player.monsterInAutoDetectRange = true
                let vec = monster.position - player.position
                player.facing = vec.normalized()
                break
            }
            player.monsterInAutoDetectRange = false
        }
    }
    
    
    func canonDetect() {
        
        for node in self.children{
            if node.isMember(of: Canon.self){
                
                let canon = (node as! Canon)
                canon.sinceStart += eachFrame
                
                var fireAllowed = false
                
                switch canon.canonDirection {
                case .left:
                    for monster in monsterList{
                        if abs( monster.position.y-canon.position.y) < 20 && monster.position.x < canon.position.x{
                            fireAllowed = true
                            break
                        }
                    }
                    
                    if abs(player.position.y - canon.position.y) < 20 && player.position.x < canon.position.x{
                        fireAllowed = true
                    }
                case .right:
                    for monster in monsterList{
                        if abs( monster.position.y-canon.position.y) < 20 && monster.position.x > canon.position.x{
                            fireAllowed = true
                            break
                        }
                    }
                    
                    if abs(player.position.y - canon.position.y) < 20 && player.position.x > canon.position.x{
                        fireAllowed = true
                    }
                default:
                    break
                    
                }
                
                
                
                
                //print("\(player.position.y) , \(canon.position.y)")
                
                if canon.sinceStart > 3 && fireAllowed{
                    switch canon.canonDirection {
                    case .right:
                        canon.fireRight()
                    case .left:
                        canon.fireLeft()
                    default:
                        break
                    }
                    canon.run(canonFireSound)
                    canon.sinceStart = 0
                }
                
            }
        }
        
    }
    
    func setupCharacter() {
        if villageGirl == nil && isMonsterRoom{
            if Int.random(in: 0..<10)<2{
                villageGirl = VillageGirl()
                
                var newX = CGFloat.random(in: 50..<self.frame.width-50)
                var newY = CGFloat.random(in: 50..<self.frame.height-50)
                
                while atPoint(CGPoint(x: newX, y: newY)).physicsBody != nil {
                    newX = CGFloat.random(in: 50..<self.frame.width-50)
                    newY = CGFloat.random(in: 50..<self.frame.height-50)
                }
                
                villageGirl.position = CGPoint(x: newX, y: newY)
                addChild(villageGirl)
                
                for scene in sceneList{
                    scene.villageGirl = villageGirl
                }
                
            }
        }
        
        if scientist == nil  && isMonsterRoom{
            if Int.random(in: 0..<10)<1{
                scientist = Scientist()
                
                var newX = CGFloat.random(in: 50..<self.frame.width-50)
                var newY = CGFloat.random(in: 50..<self.frame.height-50)
                
                while atPoint(CGPoint(x: newX, y: newY)).physicsBody != nil {
                    newX = CGFloat.random(in: 50..<self.frame.width-50)
                    newY = CGFloat.random(in: 50..<self.frame.height-50)
                }
                
                scientist.position = CGPoint(x: newX, y: newY)
                addChild(scientist)
                
                for scene in sceneList{
                    scene.scientist = scientist
                }
                
            }
        }
    }
    
    func setupBornEffect()  {
        bornEffect = BornEffect(scene: self)
        //bornEffect.position = player.position - CGPoint(x: 0, y: 10)
        addChild(bornEffect)
    }
    
    func setupPowerSelection(location: CGPoint)  {
        
        
        
        
        let powerSelectionNode: SKNode!
        //print("\(atPoint(location).name)")
        let name = atPoint(location).name
        if name == "flyingBirdTexture" || name == "healthGainerTexture" || name == "halfMonsterTexture"{
            powerSelectionNode = atPoint(location)
            
            if lastSelectionNode != nil && lastSelectionNode == powerSelectionNode{
                
                selectionArrow.removeFromParent()
                selectionWord.removeFromParent()
                
                switch powerSelectionNode.name {
                case "flyingBirdTexture":
                    player.powerList.append(fromType(type: PowerType.flyingBird))
                    
                case "healthGainerTexture":
                    player.powerList.append(fromType(type: PowerType.healthGainer))
                    
                case "halfMonsterTexture":
                    player.powerList.append(fromType(type: PowerType.halfMonster))
                    
                default:
                    break
                }
                //powerTextureBorn.isHidden = tr
                powerSelectionNode.run(SKAction.scale(to: CGSize(width: 20, height: 20), duration: 0.5))
                let position  = self.convert(powerBorn.position + CGPoint(x: 0, y: 30) + CGPoint(x: 0, y: -30 * player.powerList.count), to: powerTextureBorn)
                powerSelectionNode.run(SKAction.move(to: position, duration: 0.5))
                
                let wait = SKAction.wait(forDuration: 0.5)
                
                let removeAction = SKAction.run({
                    self.player.powerChanged = true
                    powerSelectionNode.removeFromParent()
                    self.powerTextureBorn.removeAllChildren()
                    self.powerTextureBorn.removeFromParent()
                })
                powerSelectionNode.run(SKAction.sequence([wait,removeAction]))
                
                inDialogue = false
                return
            }
            
            
            
            lastSelectionNode = powerSelectionNode
            if selectionArrow != nil{
                selectionArrow.removeFromParent()
            }
            selectionArrow = SKSpriteNode(texture: SKTexture(imageNamed: "powerSelection"), color: .clear, size: CGSize(width: 50, height: 70))
            selectionArrow.position = powerTextureBorn.convert(powerSelectionNode!.position, to: self) + CGPoint(x: 0, y: 80)
            selectionArrow.zPosition = 500
            addChild(selectionArrow)
            selectionArrow.run(SKAction(named: "idle")!)
            
            if selectionWord != nil{
                selectionWord.removeFromParent()
            }
            selectionWord = SKLabelNode(fontNamed: "Chalkduster")
            switch name {
            case "flyingBirdTexture":
                selectionWord.text = Word().flyingBirdWord
            case "healthGainerTexture":
                selectionWord.text = Word().healthGainerWord
            case "halfMonsterTexture":
                selectionWord.text = Word().halfMonsterWord
            default:
                break
            }
            
            selectionWord.zPosition = 500
            selectionWord.fontSize = 20
            selectionWord.fontColor = SKColor.white
            selectionWord.position = powerTextureBorn.convert(powerSelectionNode!.position, to: self) + CGPoint(x: 0, y: -80)
            addChild(selectionWord)
        }
    }
    
    func eachRoomSetting()  {
        mount = (self.childNode(withName: "//mount") as! SKSpriteNode)
        handler = (self.childNode(withName: "//handler") as! SKSpriteNode)
        handlerBackground = (self.childNode(withName: "//handlerBackground") as! SKSpriteNode)
        fireButton = (self.childNode(withName: "fireButton") as! MSButtonNode)
        fireButton.touchStartHandler = {self.player.isFiring = true}
        fireButton.selectedHandler = {self.player.isFiring = false}
        popoButton = (self.childNode(withName: "popoButton") as! MSButtonNode)
        popoButton.selectedHandler = {
            
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
        rButton = (self.childNode(withName: "rHandler") as! MSButtonNode)
        //setupDoor()
        leftButton = (self.childNode(withName: "left") as! MSButtonNode)
        leftButton.selectedHandler = {
            if self.player.itemList.count < 2 || self.player.inItemListNumber == 0{
                self.run(self.errorSound)
                return
            }
            self.run(self.slideSound)
            self.player.item = self.player.itemList[self.player.inItemListNumber-1]
            self.player.inItemListNumber -= 1
            self.player.itemChanged = true
            
        }
        rightButton = (self.childNode(withName: "right") as! MSButtonNode)
        rightButton.selectedHandler = {
            if self.player.itemList.count < 2 || self.player.inItemListNumber == self.player.itemList.count-1{
                self.rightButton.run(self.errorSound)
                return
            }

            self.rightButton.run(self.slideSound)
            self.player.item = self.player.itemList[self.player.inItemListNumber+1]
            self.player.inItemListNumber += 1
            self.player.itemChanged = true
            
        }
        
        if isMonsterRoom {
            let wait = SKAction.wait(forDuration: 1)
            self.run(SKAction.sequence([wait,SKAction.run({
                self.setupMonster(num: Int.random(in: 5..<10))
            })]))
            
            bornBreak(num: Int.random(in: 5..<10), homeScene: self)
        }
        
        if isBedRoom{
            setupBedRoom()
            self.run(startSound)
        }
        
        if isCaveRoom{
            print("enter!")
            setupCave()
        }
        
        if isBedRoom{
            for node in self.children{
                if node.name == "recordBorn"{
                    let record = Record(scene: self)
                    record.position = node.position
                    addChild(record)
                }
            }
            
        }
        
        
        
        
        for node in self.children{
            if node.name == "boxBorn"{
                let box = Box()
                box.position = node.position
                addChild(box)
            }
            if node.name == "fishBoxBorn"{
                let box = Box()
                box.name = "fishBox"
                box.position = node.position
                addChild(box)
            }
            if node.name == "scarecrowBorn"{
                let scarecrow = Scarecrow(scene: self)
                scarecrow.position = node.position
                addChild(scarecrow)
                monsterList.append(scarecrow)
            }
            if node.name == "breakBorn"{
                let item = fromType(type: BreakType.random())
                item.position = node.position
                addChild(item)
            }
            if node.name == "npcBorn"{
                npc = Npc()
                npc.position = node.position
                addChild(npc)
                
                for scene in sceneList{
                    scene.npc = npc
                }
            }
            if node.name == "chickenBorn"{
                for animal in player.farmList{
                    animal.position = node.position
                    animal.setup(scene: self)
                    animal.move(toParent: self)
                    
                }
                
            }
            if node.name == "fishBorn"{
                let fish = Fish()
                fish.position = node.position
                addChild(fish)
            }
        }
        
        setupCharacter()
        setupCanon()
    }
    
    func eachEnterSetting()  {
        
        for node in player.weapon.children{
            if node.name == "fishingLine"{
                node.removeFromParent()
                let weapon = player.weapon as! FishingRod
                weapon.isFishing = false
            }
        }
        
        if isBackFromSecretRoom && !isDoorSet{
            setupMonster(num: 5)
            isBackFromSecretRoom = false
        }
        
        if isEnterCaveRoom{
            setupCaveMonster(level: player.gameLevel)
        }
        
        if !isEnterCaveRoom && !isBedRoom && !isSecretRoom && !isGameRoom{
            mapPosition = (self.childNode(withName: "map") as! SKSpriteNode)
            setupMap(mapNumber: player.gameLevel)
        }
        
        if isBedRoom{
            player.health = player.bornHealth + player.baseHealth
            player.healthChanged = true
            player.setupPhysics()
   
        }
        
        if isBedRoom || isBreakRoom{
            setupBornEffect()
        }
        
        if isGameRoom{
            for node in children{
                if node.name == "slotBar"{
                    node.removeFromParent()
                }
            }
            let slotbar = SlotBar(scene: self)
            addChild(slotbar)
        }
        
        self.view?.isUserInteractionEnabled = true
        sinceStart = 0
        mount.position = handlerBackground.position
        handler.position = handlerBackground.position
        physicsWorld.contactDelegate = self
        
        player.move(toParent: self)
        player.isHidden = false
        player.playerIsMoving = false
        player.state = .idle
        player.homeScene = self
        player.healthChanged = true
        player.levelChanged = true
        player.expChanged = true
        player.moneyChanged = true
        player.weaponChanged = true
        player.itemChanged = true
        player.hatChanged = true
        player.petChanged = true
        player.eggChanged = true
        player.powerChanged = true
        player.collectionChanged = true
        player.isAlived = true
        player.isFiring = false
        levelChanged = true
        

        //power start to work when enter each room
        for power in player.powerList{
            power.homeScene = self
            if !power.start{
                power.start = true
            }
        }
        
        
        
        let debugButton = DebugButton(scene: self)
        addChild(debugButton)
    }
    
    func setupCaveMonster(level: Int)  {
        
        switch level {
        case 1:
            let start = SKAction.wait(forDuration: 1)
            let wait = SKAction.wait(forDuration: 10)
            let born = SKAction.run({
                self.bornSlime(num: Int.random(in: 15..<20))
            })
            self.run(SKAction.sequence([start,born,wait,born,wait,born]))
            
        case 2:
            let start = SKAction.wait(forDuration: 1)
            let wait = SKAction.wait(forDuration: 10)
            let born = SKAction.run({
                self.bornSlime(num: Int.random(in: 15..<20))
            })
            self.run(SKAction.sequence([start,born,wait,born,wait,born]))
        default:
            break
        }
        
        
    }
    
    func bornSlime(num: Int)  {
        for _ in 0..<num {
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
            //let newLog = Log(scene: self)
            
            let monster = Slime(scene: self, color: SlimeColor.random())
            monster.position = CGPoint(x: bornX, y: bornY)
            //            if Int.random(in: 0..<10)<2{
            //                monster.bigger(scale: CGFloat.random(in: 1..<4))
            //            }
            
            //addChild(monster)
            monsterFall(monster: monster)
            monsterList.append(monster)
            //ogList.append(newLog)
            
        }
        
        
    }
    
    
    func setupPlayerAttack()  {
        if player.isFiring{
            self.player.weapon.attack(direction: self.player.facing,homeScene: self)
            
        }else {player.weapon.reset()}
        
        if player.rStart > 5 {
            player.rStart = 5
            rButton.selectedHandler = {
                self.player.rStart = 0
                self.player.weapon.rAttack(direction: self.player.facing, homeScene: self)
            }
        }else {
            let white = (rButton.childNode(withName: "white") as! SKSpriteNode)
            white.yScale = CGFloat(player.rStart)/5
            rButton.selectedHandler = {}
        }
    }
    
    func setupPositionFollow()  {
        for node in self.children{
            if node.name == "heal"{
                node.position = player.position
            }
            if node.name == "umbrella"{
                node.position = player.position + CGPoint(x: 0, y: 50)
            }
        }

        if bornEffect != nil{
            if sinceStart<0.1{
                bornEffect.position = player.position - CGPoint(x: 0, y: 10)
            }
            if sinceStart > 1{
                bornEffect.removeFromParent()
            }
        }
    }
    
    func setupLevelClean() {
        if isBornRoom || isBonusRoom || isFishRoom || isVillageRoom || isStoneRoom || isFarmRoom {if !isDoorSet{setupDoor();isDoorSet=true}
        }else if isEnterCaveRoom {
        
            switch player.gameLevel {
            case 1:
                if sinceStart>30{
                    for i in 0..<monsterList.count{
                        if monsterList[i].isAlived{break}
                        if i == monsterList.count - 1 && !isDoorSet{
                            setupHomeOrKeepGoing()
                            isDoorSet=true
                        }
                    }
                }
            case 2:
                if sinceStart>30{
                    for i in 0..<monsterList.count{
                        if monsterList[i].isAlived{break}
                        if i == monsterList.count - 1 && !isDoorSet{
                            setupHomeOrKeepGoing()
                            isDoorSet=true
                        }
                    }
                }
            default:
                break
            }
            
            
        }
        else {
            for i in 0..<monsterList.count{
                if monsterList[i].isAlived{break}
                if i == monsterList.count - 1 && !isDoorSet{
                    setupDoor()
                    isDoorSet=true
                    
                }
            }
        }
    }
    
    func setupBirdInBackground()  {
        if isMonsterRoom || isBornRoom{
            if birdBornStart > 6{
                if Int.random(in: 0..<100) < 5 {
                    let bird = Bird(scene: self)
                    bird.position = CGPoint(x: CGFloat.random(in: 700..<800), y: CGFloat.random(in: 200..<360))
                    addChild(bird)
                }
                birdBornStart = 0
            }
        }
    }
    
    func monsterFall(monster: SKNode) {
        let fallPosition = monster.position
        let texture = SKTexture(imageNamed: "shadow")
        let shadow = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 30, height: 20))
        shadow.position = fallPosition
        shadow.zPosition = 1
        addChild(shadow)
        let wait = SKAction.wait(forDuration: 4)
        shadow.run(SKAction.sequence([wait,SKAction.removeFromParent()]))
        
        let start = SKAction.wait(forDuration: 1)
        monster.position = CGPoint(x: fallPosition.x, y: 800)
        let fallAction = SKAction.move(to: fallPosition, duration: 1)
        fallAction.timingMode = .easeIn
        
        addChild(monster)
        monster.run(SKAction.sequence([start,fallAction]))
        
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
            
            self.run(self.openChestSound)
        }
        addChild(book)
        
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
        
        for node in self.children{
            if node.name == "soilder"{
                let dist = player.position.distanceTo(node.position)
                if dist < 50 {
                    if !dialogueIsSet {
                        dialogueIsSet = true
                        //sound
                        
                        self.run(stopSound)
                        
                        dialogue = Dialogue(dialogueType: "...")
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
        }
    }
    
    func checkVendingMachineAround()  {
        for node in self.children{
            if node.name == "vendingMachine"{
                let vendingMachine = node as SKNode
                let dist = player.position.distanceTo(vendingMachine.position)
                if dist < 100 {
                    if !vendingMachineDialogueIsSet {
                        vendingMachineDialogueIsSet = true
                        //sound
                        
                        self.run(helloSound)
                        
                        vendingMachineDialogue = Dialogue(dialogueType: "surprise")
                        vendingMachineDialogue.position = vendingMachine.position + CGPoint(x: 5, y: 20)
                        vendingMachineDialogue.selectHandler = {
                            
                            self.storeDialogue = StoreDialogue(scene: self)
                            self.storeDialogue.position = self.vendingMachineDialogue.position
                            self.addChild(self.storeDialogue)
                            self.storeDialogue.run(SKAction.move(to: CGPoint(x: 194, y: 320), duration: 0.5))
                            //                            self.storeDialogue.run(SKAction.scale(to: CGSize(width: 228, height: 227), duration: 0.5))
                            
                            //tricky way to disable handler
                            self.inDialogue = true
                            self.popoButton.isUserInteractionEnabled = false
                            self.fireButton.isUserInteractionEnabled = false
                            self.vendingMachineDialogue.removeFromParent()
                            
                            //self.storeDialogue.startWord(sentence: Word().scientistWod)
                            
                            //                            self.run(SKAction.sequence([SKAction.wait(forDuration: 2),SKAction.run({self.addbuyButton(money: CGFloat.random(in: 50..<100))})]))
                            
                        }
                        
                        addChild(vendingMachineDialogue)
                        vendingMachineDialogue.start()
                        
                    }
                }else{
                    if vendingMachineDialogue != nil {
                        vendingMachineDialogue.removeFromParent()
                        vendingMachineDialogueIsSet = false
                    }
                }
            }
            
        }
        
        
        
    }
    
    func checkMakerAround()  {
        for node in self.children{
            if node.name == "maker"{
                let dist = player.position.distanceTo(node.position)
                if dist < 80 {
                    if !makerDialogueIsSet {
                        makerDialogueIsSet = true
                        //sound
                        // self.run(SKAction.playSoundFileNamed("hello.wav", waitForCompletion: true))
                        
                        makerDialogue = Dialogue(dialogueType: "...")
                        makerDialogue.position = node.position + CGPoint(x: 0, y: 30)
                        makerDialogue.selectHandler = {
                            
                            self.transferDialogue = TransferDialogue(scene: self)
                            self.transferDialogue.position = self.makerDialogue.position
                            self.addChild(self.transferDialogue)
                            self.transferDialogue.run(SKAction.move(to: CGPoint(x: 235, y: 235), duration: 0.5))
                            
                            //tricky way to disable handler
                            self.inDialogue = true
                            self.popoButton.isUserInteractionEnabled = false
                            self.fireButton.isUserInteractionEnabled = false
                            self.makerDialogue.removeFromParent()
                            
                            
                            
                        }
                        
                        addChild(makerDialogue)
                        makerDialogue.start()
                        
                    }
                }else{
                    if makerDialogue != nil {
                        makerDialogue.removeFromParent()
                        makerDialogueIsSet = false
                    }
                }
            }
            
        }
    }
    
    
    func checkScientistAround()  {
        for node in self.children{
            if node.name == "scientist"{
                let scientist = node as! Scientist
                let dist = player.position.distanceTo(scientist.position)
                if dist < 50 {
                    if !scientistDialogueIsSet {
                        scientistDialogueIsSet = true
                        //sound
                        //                        self.run(SKAction.playSoundFileNamed("hello.wav", waitForCompletion: true))
                        
                        scientistDialogue = Dialogue(dialogueType: "...")
                        scientistDialogue.position = scientist.position + CGPoint(x: 0, y: 30)
                        scientistDialogue.selectHandler = {
                            
                            self.bigDialogue = BigDialogue(scene: self)
                            self.bigDialogue.position = self.scientistDialogue.position
                            self.addChild(self.bigDialogue)
                            self.bigDialogue.run(SKAction.move(to: CGPoint(x: 131, y: 187), duration: 0.5))
                            self.bigDialogue.run(SKAction.scale(to: CGSize(width: 412, height: 124), duration: 0.5))
                            
                            //tricky way to disable handler
                            self.inDialogue = true
                            self.popoButton.isUserInteractionEnabled = false
                            self.fireButton.isUserInteractionEnabled = false
                            self.scientistDialogue.removeFromParent()
                            
                            self.bigDialogue.startWord(sentence: Word().scientistWod)
                            self.run(SKAction.sequence([SKAction.wait(forDuration: 2),SKAction.run({self.addbuyButton(money: CGFloat.random(in: 50..<100),characterName: "scientist",buttonName: "buy")})]))
                            
                        }
                        
                        addChild(scientistDialogue)
                        scientistDialogue.start()
                        
                    }
                }else{
                    if scientistDialogue != nil {
                        scientistDialogue.removeFromParent()
                        scientistDialogueIsSet = false
                    }
                }
            }
            
        }
    }
    
    func checkStatueAround()  {
        for node in self.children{
            if node.name == "statue"{
                let dist = player.position.distanceTo(node.position)
                if dist < 80 {
                    if !statueDialogueIsSet {
                        statueDialogueIsSet = true
                        //sound
                        //                        self.run(SKAction.playSoundFileNamed("hello.wav", waitForCompletion: true))
                        
                        statueDialogue = Dialogue(dialogueType: "...")
                        statueDialogue.position = node.position + CGPoint(x: 10, y: 50)
                        statueDialogue.selectHandler = {
                            
                            self.bigDialogue = BigDialogue(scene: self)
                            self.bigDialogue.position = self.statueDialogue.position
                            self.addChild(self.bigDialogue)
                            self.bigDialogue.run(SKAction.move(to: CGPoint(x: 131, y: 187), duration: 0.5))
                            self.bigDialogue.run(SKAction.scale(to: CGSize(width: 412, height: 124), duration: 0.5))
                            
                            //tricky way to disable handler
                            self.inDialogue = true
                            self.popoButton.isUserInteractionEnabled = false
                            self.fireButton.isUserInteractionEnabled = false
                            self.statueDialogue.removeFromParent()
                            
                            self.bigDialogue.startWord(sentence: Word().statueWord)
                            self.run(SKAction.sequence([SKAction.wait(forDuration: 2),SKAction.run({self.addbuyButton(money: CGFloat.random(in: 30..<50),characterName: "statue",buttonName: "give")})]))
                            //self.bigDialogue.selectHandler = {self.bigDialogue.justClose()}
                            
                        }
                        
                        addChild(statueDialogue)
                        statueDialogue.start()
                        
                    }
                }else{
                    if statueDialogue != nil {
                        statueDialogue.removeFromParent()
                        statueDialogueIsSet = false
                    }
                }
            }
            
        }
    }
    
    
    func checkGirlAround()  {
        
        for node in self.children{
            if node.name == "villageGirl"{
                let girl = node as! VillageGirl
                let dist = player.position.distanceTo(girl.position)
                if dist < 50 {
                    if !girlDialogueIsSet {
                        girlDialogueIsSet = true
                        //sound
                        
                        self.run(helloSound)
                        
                        girlDialogue = Dialogue(dialogueType: "...")
                        girlDialogue.position = girl.position + CGPoint(x: 0, y: 30)
                        girlDialogue.selectHandler = {
                            
                            self.bigDialogue = BigDialogue(scene: self)
                            self.bigDialogue.position = self.girlDialogue.position
                            self.addChild(self.bigDialogue)
                            self.bigDialogue.run(SKAction.move(to: CGPoint(x: 131, y: 187), duration: 0.5))
                            self.bigDialogue.run(SKAction.scale(to: CGSize(width: 412, height: 124), duration: 0.5))
                            
                            //tricky way to disable handler
                            self.inDialogue = true
                            self.popoButton.isUserInteractionEnabled = false
                            self.fireButton.isUserInteractionEnabled = false
                            self.girlDialogue.removeFromParent()
                            
                            self.bigDialogue.startWord(sentence: Word().buyWord)
                            self.run(SKAction.sequence([SKAction.wait(forDuration: 2),SKAction.run({self.addbuyButton(money: 20,characterName: "villageGirl",buttonName: "buy")})]))
                            
                        }
                        
                        addChild(girlDialogue)
                        girlDialogue.start()
                        
                    }
                }else{
                    if girlDialogue != nil {
                        girlDialogue.removeFromParent()
                        girlDialogueIsSet = false
                    }
                }
            }
            
        }
        
    }
    
    func addbuyButton(money: CGFloat, characterName: String, buttonName: String)  {
        let buyButton = WordButton(name: buttonName)
        buyButton.position = CGPoint(x: 450, y: 100)
        self.addChild(buyButton)
        
        buyButton.selectHandler = {
            if self.bigDialogue.isFinish{
                self.bigDialogue.removeFromParent()
                for node in self.bigDialogue.wordList{
                    node.removeFromParent()
                }
                //tricky way to enable handler
                self.inDialogue = false
                self.popoButton.isUserInteractionEnabled = true
                self.fireButton.isUserInteractionEnabled = true
                buyButton.removeFromParent()
                
                if self.player.money > money{
                    self.player.money -= money
                    self.player.moneyChanged = true
                    
                    switch characterName {
                    case "villageGirl":
                        bornItemTexture(num: 1, position: self.villageGirl.position, homeScene: self)
                        if Int.random(in: 0..<10)<3{
                            bornPetEggTexture(num: 1, position: self.villageGirl.position, homeScene: self)
                        }
                    case "scientist":
                        bornItemTexture(num: 1, position: self.scientist.position, homeScene: self)
                    case "statue":
                        self.player.health += 0.25
                        self.player.healthChanged = true
                    default:
                        break
                    }
                    
                    
                }
                
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
                
                
                if  let view = self.view as SKView?{
                    if let scene = GameScene.level(5){
                        // Set the scale mode to scale to fit the window
                        scene.isEnterCaveRoom = true
                        //scene.isMonsterRoom = true
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
    
    func checkFoxAround() {
        for node in self.children{
            if node.name == "fox"{
                if node.position.distanceTo(player.position) < 60 {
                    if !loveDialogueIsSet{
                        loveDialogueIsSet = true
                        let loveDialogue = LoveDialogue()
                        loveDialogue.position = node.position + CGPoint(x: 5, y: 30)
                        addChild(loveDialogue)
                        loveDialogue.start()
                        
                        self.run(barkSound)
                    }
                    
                    
                } else {
                    loveDialogueIsSet = false
                    for node in self.children{
                        if node.name == "loveDialogue"{
                            node.removeFromParent()
                        }
                    }
                }
            }
        }
    }
    
    func setupFishChangeAnchorPoint()  {
        for node in self.children{
            if node.name == "fish"{
                for anchorPoint in self.children{
                    if anchorPoint.name == "anchorPoint"{
                        if node.frame.contains(anchorPoint.position){
                            anchorPoint.position = node.position
                            let fish = node as! Fish
                            fishGot = fish
                        }
                    }
                }
            }
        }
    }
    
    func setupSlotMachine()  {
        if isGameRoom{
            for node in self.children{
                if node.name == "firstHead"{
                    for icon in node.children{
                        let position = node.convert(icon.position, to: self)
                        if position.y > 265 {
                            icon.isHidden = true
                        }else{
                            icon.isHidden = false
                        }
                        if position.y < 233{
                            icon.removeFromParent()
                        }
                    }
                }
                if node.name == "secondHead"{
                    for icon in node.children{
                        let position = node.convert(icon.position, to: self)
                        if position.y > 265 {
                            icon.isHidden = true
                        }else{
                            icon.isHidden = false
                        }
                        if position.y < 233{
                            icon.removeFromParent()
                        }
                    }
                }
                if node.name == "thirdHead"{
                    for icon in node.children{
                        let position = node.convert(icon.position, to: self)
                        if position.y > 265 {
                            icon.isHidden = true
                        }else{
                            icon.isHidden = false
                        }
                        if position.y < 233{
                            icon.removeFromParent()
                        }
                    }
                }
            }
            
            
            
        }
    }
    
    
    func setupFishingRod()  {
        if player.weapon.weaponType == .fishingRod{
            for anchorPoint in self.children{
                if anchorPoint.name == "anchorPoint"{
                    
                    for node in player.weapon.children{
                        if node.name == "fishingLine"{
                            
                            let line = node as! SKShapeNode
                            let path =  CGMutablePath()
                            let position = self.convert(anchorPoint.position, to: player.weapon)
                            if let bornPoint = weaponOnHand.childNode(withName: "bornPoint"){
                                path.move(to: bornPoint.position)
                                path.addLine(to: position)
                                line.path = path
                            }
                           
                        }
                    }
                    
                }
            }
            
            
        }
    }
    
    
    func setupPowerRemove()  {
        for i in 0..<player.powerList.count{
            
            if player.powerList[i].useNumber == 0{
                player.powerList.remove(at: i)
                player.powerChanged = true
                break
            }
        }
    }
    
    func setupSinceStartCounting() {
        player.sinceFire += eachFrame
        player.rStart += eachFrame
        sinceStart += eachFrame
        birdBornStart += eachFrame
        for monster in monsterList{
            monster.sinceStart += eachFrame
        }
        for power in player.powerList{
            power.sinceStart += eachFrame
        }
        for scene in sceneList{
            for node in scene.children{
                if node.name == "chicken"{
                    let chicken = node as! Chicken
                    chicken.sinceStart += eachFrame
                }
                if node.name == "cat"{
                    let cat = node as! Cat
                    cat.sinceStart += eachFrame
                }
                if node.name == "fish"{
                    let fish = node as! Fish
                    fish.sinceStart += eachFrame
                }
            }
        }
     
        
        for node in self.children{
            if node.name == "panda"{
                let panda = node as! Panda
                panda.sinceStart += eachFrame
            }
            if node.name == "npc"{
                let npc = node as! Npc
                npc.sinceBorn += eachFrame
            }
        }

        for node in player.children{
            if node.name == "plantDog"{
                let plantDog = node as! PlantDog
                plantDog.sinceStart += eachFrame
            }
        }
        
        for node in self.children{
            if node.isMember(of: Bird.self) {
                let bird = node as! Bird
                bird.sinceStart += eachFrame
                bird.forRemove += eachFrame
                if bird.forRemove > 10{
                    bird.removeFromParent()
                }
            }
        }
        
    }
    
    func checkBoxAround() {
        
        for node in self.children{
            if node.name == "box"{
                let box = node as! Box
                let dist = player.position.distanceTo(box.position)
                if !box.boxIsSet{
                    if dist < 50 && !box.isOpen{
                        box.boxIsSet = true
                        box.open()
                        box.isOpen = true
                        //pop some item
                        bornItemTexture(num: 3, position: box.position, homeScene: self)
                        bornWeaponTexture(num: 1, position: box.position, homeScene: self)
                        //bornPetEggTexture(num: 1, position: box.position, homeScene: self)
                        
                    }
                }
                
            }
            
            if node.name == "fishBox"{
                let box = node as! Box
                let dist = player.position.distanceTo(box.position)
                if !box.boxIsSet{
                    if dist < 50 && !box.isOpen{
                        box.boxIsSet = true
                        box.open()
                        box.isOpen = true
                        
                        bornWeaponTexture(num: 1, position: box.position, homeScene: self, type: .fishingRod)
                        
                    }
                }
                
            }
            
        }
    }
    
    func setupZPosition()  {
        for node in self.children{
            if node.name == "scarecrow" && player.position.distanceTo(node.position)<50{
                if player.position.y < node.position.y{
                    player.zPosition = node.zPosition + 1
                }else{
                    player.zPosition = 1
                }
            }
            if node.name == "statue" && player.position.distanceTo(node.position)<50{
                if player.position.y < node.position.y{
                    player.zPosition = node.zPosition + 1
                }else{
                    player.zPosition = 1
                }
            }
        }
    }
    
    func checkFarmBarAround()  {
        for node in self.children{
            if node.name == "farmBar"{
                let dist = player.position.distanceTo(node.position)
                if dist < 100 {
                    if !farmBarDialogueIsSet {
                        farmBarDialogueIsSet = true
                        farmDialogue = Dialogue(dialogueType: "...")
                        farmDialogue.position = node.position + CGPoint(x: 0, y: 30)
                        
                        farmDialogue.selectHandler = {
                            
                            let bigDialogue = BigDialogue(scene: self)
                            bigDialogue.position = self.farmDialogue.position
                            self.addChild(bigDialogue)
                            bigDialogue.run(SKAction.move(to: CGPoint(x: 131, y: 187), duration: 0.5))
                            bigDialogue.run(SKAction.scale(to: CGSize(width: 412, height: 124), duration: 0.5))
                            
                            //tricky way to disable handler
                            self.inDialogue = true
                            self.popoButton.isUserInteractionEnabled = false
                            self.fireButton.isUserInteractionEnabled = false
                            self.farmDialogue.removeFromParent()
                            if self.player.eggTextureList.count > 0{
                                bigDialogue.startWord(sentence: Word().farmHasWord)
                            }else{
                                bigDialogue.startWord(sentence: Word().farmWord)
                            }
                            bigDialogue.selectHandler = {
                                bigDialogue.justClose()
                                if self.player.eggTextureList.count >= 0{
                                    self.bornEgg()
                                }
                            }
                            
                        }
                        
                        addChild(farmDialogue)
                        farmDialogue.start()
                        
                    }
                    npc.state = .idle
                    npc.sinceBorn = 0
                }else{
                    if farmDialogue != nil {
                        farmDialogue.removeFromParent()
                        farmBarDialogueIsSet = false
                    }
                }
            }
        }
        
        
    }
    
    func bornEgg() {
        for animal in player.eggTextureList{
            
            switch animal.name {
            case "chickenEggTexture":
                let chicken = Chicken()
                let pos = self.childNode(withName: "chickenBorn")!.position
                chicken.position = pos
                chicken.setup(scene: self)
                addChild(chicken)
                player.farmList.append(chicken)
            case "catEggTexture":
                let cat = Cat()
                let pos = self.childNode(withName: "chickenBorn")!.position
                cat.position = pos
                cat.setup(scene: self)
                addChild(cat)
                player.farmList.append(cat)
            default:
                break
            }
            
        }
        
        player.eggTextureList = [SKNode]()
        player.eggChanged = true
    }
    
    
    
    
    func checkNpcAround() {
        
        for node in self.children{
            if node.name == "npc"{
                let dist = player.position.distanceTo(npc.position)
                if dist < 60 {
                    if !dialogueIsSet {
                        dialogueIsSet = true
                        dialogue = Dialogue(dialogueType: "...")
                        dialogue.position = npc.position + CGPoint(x: 0, y: 30)
                        //set hello
                        
                        self.run(helloSound)
                        
                        
                        
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
        }

    }
    
    
    
    func playerSetupHud() {
        
        
        if player.collectionChanged{
            
            if collectionBorn == nil{
                collectionBorn = SKSpriteNode(color: .red, size: CGSize(width: 1, height: 1))
                collectionBorn.position = CGPoint(x: 650, y: 300)
                collectionBorn.zPosition = 100
                addChild(collectionBorn)
            }
            
            for node in collectionBorn.children{
                node.removeFromParent()
            }
            var action = [SKAction]()
            let wait = SKAction.wait(forDuration: 0.5)
            for i in 0..<player.collectionList.count{
                let node = player.collectionList[i].copy() as! SKNode
                node.position = CGPoint(x: 0, y: -30 * i)
                node.zPosition = 1
                action.append(SKAction.run({node.run(SKAction(named: "idle")!)}))
                action.append(wait)
                collectionBorn.addChild(node)
            }
            self.run(SKAction.sequence(action))
            player.collectionChanged = false
        }
        
        if player.powerChanged{
            
            if powerBorn == nil{
                powerBorn = SKSpriteNode(color: .red, size: CGSize(width: 1, height: 1))
                powerBorn.position = CGPoint(x: 20, y: 300)
                powerBorn.zPosition = 100
                addChild(powerBorn)
            }
            
            for node in powerBorn.children{
                node.removeFromParent()
            }
            
            var action = [SKAction]()
            let wait = SKAction.wait(forDuration: 0.5)
            for i in 0..<player.powerList.count{
                let node = player.powerList[i].copy() as! SKNode
                node.position = CGPoint(x: 0, y: -30 * i)
                node.zPosition = 1
                action.append(SKAction.run({node.run(SKAction(named: "coinPop")!)}))
                action.append(wait)
                
                let num = player.powerList[i].useNumber!
                //print("\(num)")
                let numNode = SKLabelNode(fontNamed: "Chalkduster")
                numNode.text = String(num)
                numNode.zPosition = 2
                numNode.fontSize = 20
                numNode.fontColor = SKColor.white
                numNode.position = node.position + CGPoint(x: 15, y: 0)
                powerBorn.addChild(numNode)
                powerBorn.addChild(node)
            }
            self.run(SKAction.sequence(action))
            player.powerChanged = false
        }
        
        
        
        
        //set egglist
        if player.eggChanged{
            
            
            if eggBorn == nil{
                eggBorn = SKSpriteNode(color: .red, size: CGSize(width: 1, height: 1))
                eggBorn.position = CGPoint(x: 191, y: 22)
                eggBorn.zPosition = 5
                addChild(eggBorn)
            }
            
            
            for node in eggBorn.children{
                node.removeFromParent()
            }
            
            for i in 0..<player.eggTextureList.count{
                
                var eggTexture: SKSpriteNode!
                
                switch player.eggTextureList[i].name {
                case "chickenEggTexture":
                    let texture = SKTexture(imageNamed: "egg")
                    eggTexture = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 20, height: 26))
                    eggTexture.name = "chickenEggOnPocket"
                case "catEggTexture":
                    let texture = SKTexture(imageNamed: "catEgg")
                    eggTexture = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 20, height: 26))
                    eggTexture.name = "catEggOnPocket"
                default:
                    break
                }
                eggTexture.zPosition = 1
                eggTexture.position =   CGPoint(x: -30 * i, y: 0 )
                eggBorn.addChild(eggTexture)
            }
            player.eggChanged = false
        }
        
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
        //set pet
        
        if player.petChanged {
            for node in self.children{
                if node.name == "panda"{
                    node.removeFromParent()
                }
            }
            
            if let pet = player.pet {
                pet.setup(scene: self)
                pet.position = player.position.randomPointInDistamce(distance: 50)
                pet.move(toParent: self)
            }
            
            player.petChanged = false
        }
        
        
        //set exp
        if player.expChanged{
            let expBar = (self.childNode(withName: "//expBar") as! SKSpriteNode)
            expBar.xScale = player.exp/100
            player.expChanged = false
        }
        
        //set health
        if player.healthChanged {
            
            if player.health < 0 || player.health > 6{player.healthChanged = false;return}
            
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
            
            if player.level>99{player.levelChanged = false;return}
            
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
            
            if player.money > 999 {player.moneyChanged = false;return}
            
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
        if player.weaponChanged || player.hatChanged{
            
            let weaponBorn = (self.childNode(withName: "//weaponBorn") as! SKSpriteNode)
            weaponBorn.removeAllChildren()
            
            let newWeapon = fromTypeTexture(type: player.weapon.weaponType)
            newWeapon.physicsBody = nil
            newWeapon.name = " "
            newWeapon.position = CGPoint(x: 0, y: 0)
            weaponBorn.addChild(newWeapon)
            
            player.removeAllChildren()
            weaponOnHand = player.weapon!
            weaponOnHand.name = "weaponOnHand"
            weaponOnHand.physicsBody = nil
            weaponOnHand.position = CGPoint(x: 10, y: -8)
            weaponOnHand.anchorPoint = CGPoint(x: 0.2, y: 0.3)
            
            let bornPoint = SKSpriteNode(color: .red, size: CGSize(width: 1, height: 1))
            bornPoint.position = CGPoint(x: 28.4, y: 3.3)
            bornPoint.name = "bornPoint"
            weaponOnHand.addChild(bornPoint)
            player.addChild(weaponOnHand)
            
            if let hatOnHead = player.hat {
                hatOnHead.setup(scene: self)
                hatOnHead.position = CGPoint(x: 0, y: 30)
                hatOnHead.zPosition = 1
                player.addChild(hatOnHead)
            }
            
            
            player.hatChanged = false
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
        if nodeA.name == "panda" {
            
            let node = nodeA as! Panda
            node.bump()
            
            
        }
        if nodeB.name == "panda" {
            
            let node = nodeB as! Panda
            node.bump()
            
            
        }
        
        if nodeA.name == "npc" {
            
            let node = nodeA as! Npc
            node.bump()
            
            
        }
        if nodeB.name == "npc" {
            
            let node = nodeB as! Npc
            node.bump()
            
            
        }
        
        if nodeA.name == "chicken" {
            
            let node = nodeA as! Chicken
            node.bump()
            
            
        }
        if nodeB.name == "chicken" {
            
            let node = nodeB as! Chicken
            node.bump()
            
            
        }
        if nodeA.name == "cat" {
            
            let node = nodeA as! Cat
            node.bump()
            
            
        }
        if nodeB.name == "cat" {
            
            let node = nodeB as! Cat
            node.bump()
            
            
        }
        
        
    }
    
    
    func setupMonsterGetHeartDrop(nodeA: SKNode, nodeB: SKNode){
        
        var slime: Slime!
        var drop: Drop!
        var itemTexture: SKNode!
        
        switch nodeA.name {
        case "slime":
            slime = (nodeA as! Slime)
        case "heart":
            drop = (nodeA as! Drop)
        case "coin":
            drop = (nodeA as! Drop)
        case "appleTexture":
            itemTexture = nodeA
        case "potionTexture":
            itemTexture = nodeA
        case "fireBombTexture":
            itemTexture = nodeA
        case "cokeTexture":
            itemTexture = nodeA
        default:
            break
        }
        
        switch nodeB.name {
        case "slime":
            slime = (nodeB as! Slime)
        case "heart":
            drop = (nodeB as! Drop)
        case "coin":
            drop = (nodeB as! Drop)
        case "appleTexture":
            itemTexture = nodeB
        case "potionTexture":
            itemTexture = nodeB
        case "fireBombTexture":
            itemTexture = nodeB
        case "cokeTexture":
            itemTexture = nodeB
        default:
            break
        }
        
        if slime != nil && drop != nil {
            drop.removeFromParent()
            slime.bigger(scale: 1.2)
        }
        
        if slime != nil && itemTexture != nil {
            itemTexture.removeFromParent()
            slime.bigger(scale: 1.2)
        }
        
        
    }
    
    func setupGameRoomEnterAndBack(nodeA: SKNode, nodeB: SKNode)  {
        
        var gameRoomPoint: SKNode!
        var playerNode: Player!
        
        switch nodeA.name {
        case "gameRoomEnterPoint":
            gameRoomPoint = nodeA
        case "gameRoomBackPoint":
            gameRoomPoint = nodeA
        case "player":
            playerNode = player
        default:
            break
        }
        
        switch nodeB.name {
        case "gameRoomEnterPoint":
            gameRoomPoint = nodeB
        case "gameRoomBackPoint":
            gameRoomPoint = nodeB
        case "player":
            playerNode = player
        default:
            break
        }
        
        
        if playerNode != nil && gameRoomPoint != nil {
            if gameRoomPoint.name == "gameRoomEnterPoint"{
                if  let view = self.view as SKView?{
                    if let scene = GameScene.level(8){
                        scene.scaleMode = .aspectFit
                        scene.isGameRoom = true
                        scene.player = player
                        scene.player.position = CGPoint(x: 350, y: 70)
                        scene.run(doorSound)
                        scene.sceneList = sceneList
                        view.presentScene(scene, transition: SKTransition.fade(withDuration: 1))
                        view.showsFPS = true
                        view.showsNodeCount = true
                        view.ignoresSiblingOrder = true
                        
                    }
                }
            }
            if gameRoomPoint.name == "gameRoomBackPoint"{
                if  let view = self.view as SKView?{
                    if let scene = player.villageRoom{
                        scene.scaleMode = .aspectFit
                        scene.player = player
                        scene.player.position = CGPoint(x: 175, y: 188)
                        scene.run(doorSound)
                        scene.sceneList = sceneList
                        view.presentScene(scene, transition: SKTransition.fade(withDuration: 1))
                        view.showsFPS = true
                        view.showsNodeCount = true
                        view.ignoresSiblingOrder = true
                        
                    }
                }
            }
            
        }
        
        
    }
    
    
    
    func setupFarmRoomTransport(nodeA: SKNode, nodeB: SKNode)  {
        
        var transportNode: SKNode!
        var playerNode: Player!
        
        switch nodeA.name {
        case "fishRoomTransport":
            transportNode = nodeA
        case "bornRoomTransport":
            transportNode = nodeA
        case "villageRoomTransport":
            transportNode = nodeA
        case "bonusRoomTransport":
            transportNode = nodeA
        case "player":
            playerNode = player
        default:
            break
        }
        
        switch nodeB.name {
        case "fishRoomTransport":
            transportNode = nodeB
        case "bornRoomTransport":
            transportNode = nodeB
        case "villageRoomTransport":
            transportNode = nodeB
        case "bonusRoomTransport":
            transportNode = nodeB
        case "player":
            playerNode = player
        default:
            break
        }
        
        if playerNode != nil && transportNode != nil{
            
            var transportScene: GameScene!
            
            switch transportNode.name {
            case "fishRoomTransport":
                transportScene = player.fishRoom
            case "bornRoomTransport":
                transportScene = player.bornScene
            case "villageRoomTransport":
                transportScene = player.villageRoom
            case "bonusRoomTransport":
                transportScene = player.bonusRoom
                
            default:
                break
            }
            if  let view = self.view as SKView?{
                if let scene = transportScene{
                    scene.scaleMode = .aspectFit
                    
                    scene.player = player
                    scene.player.position = CGPoint(x: 333, y: 100)
                    
                    scene.run(portalsound)
                    scene.sceneList = sceneList
                    view.presentScene(scene, transition: SKTransition.fade(withDuration: 1))
                    view.showsFPS = true
                    view.showsNodeCount = true
                    view.ignoresSiblingOrder = true
                 
                    print("\(player.position)")
                }
            }
        }
    }
    
    func setupHoleEnter(nodeA: SKNode, nodeB: SKNode)  {
        if nodeA.name == "hole" && nodeB.name == "player"{
            for monster in monsterList{
                monster.removeFromParent()
            }
            monsterList = []
            nodeA.removeFromParent()
            player.enterSecretRoomScene = self
            if  let view = self.view as SKView?{
                if  let scene = GameScene.level(7){
                    scene.scaleMode = .aspectFit
                    scene.isSecretRoom = true
                    scene.player = player
                    scene.player.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
                    
                    scene.run(portalsound)
                    scene.sceneList = sceneList
                    view.presentScene(scene, transition: SKTransition.fade(withDuration: 1))
                    view.showsFPS = true
                    view.showsNodeCount = true
                    view.ignoresSiblingOrder = true
                }
                
            }
            
        }
        
        if nodeA.name == "player" && nodeB.name == "hole"{
            for monster in monsterList{
                monster.removeFromParent()
            }
            monsterList = []
            nodeB.removeFromParent()
            player.enterSecretRoomScene = self
            if  let view = self.view as SKView?{
                if  let scene = GameScene.level(7){
                    scene.scaleMode = .aspectFit
                    scene.isSecretRoom = true
                    scene.player = player
                    scene.player.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
                    
                    scene.run(portalsound)
                    scene.sceneList = sceneList
                    view.presentScene(scene, transition: SKTransition.fade(withDuration: 1))
                    view.showsFPS = true
                    view.showsNodeCount = true
                    view.ignoresSiblingOrder = true
                }
                
            }
        }
        if nodeA.name == "backHole" && nodeB.name == "player"{
            
            if  let view = self.view as SKView?{
                let scene = player.enterSecretRoomScene
                scene?.scaleMode = .aspectFit
                scene?.isSecretRoom = true
                scene?.player = player
                scene?.player.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
                scene?.isBackFromSecretRoom = true
                scene?.run(portalsound)
                scene?.sceneList = sceneList
                view.presentScene(scene!, transition: SKTransition.fade(withDuration: 1))
                view.showsFPS = true
                view.showsNodeCount = true
                view.ignoresSiblingOrder = true
                
            }
            
        }
        
        if nodeA.name == "player" && nodeB.name == "backHole"{
            
            if  let view = self.view as SKView?{
                let scene = player.enterSecretRoomScene
                scene?.scaleMode = .aspectFit
                scene?.isSecretRoom = true
                scene?.player = player
                scene?.player.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
                scene?.isBackFromSecretRoom = true
                scene?.run(portalsound)
                scene?.sceneList = sceneList
                view.presentScene(scene!, transition: SKTransition.fade(withDuration: 1))
                view.showsFPS = true
                view.showsNodeCount = true
                view.ignoresSiblingOrder = true
                
            }
        }
    }
    
    func setupHitBreak(nodeA: SKNode, nodeB: SKNode)  {
        var stuff: Break!
        var ammo: Ammo!
        
        switch nodeA.name {
        case "stone":
            stuff = nodeA as! Stone
        case "bucket":
            stuff = nodeA as! Bucket
        case "van":
            stuff = nodeA as! Van
        case "stock":
            stuff = nodeA as! Stock
        case "staffBullet":
            ammo = nodeA as! Bullet
        case "candy":
            ammo = nodeA as! Candy
        case "egg":
            ammo = nodeA as! Egg
        case "canonBall":
            ammo  = nodeA as! CanonBall
            
        default:
            break
        }
        
        switch nodeB.name {
        case "stone":
            stuff = nodeB as! Stone
        case "bucket":
            stuff = nodeB as! Bucket
        case "van":
            stuff = nodeB as! Van
        case "stock":
            stuff = nodeB as! Stock
        case "staffBullet":
            ammo = nodeB as! Bullet
        case "candy":
            ammo = nodeB as! Candy
        case "egg":
            ammo = nodeB as! Egg
        case "canonBall":
            ammo  = nodeB as! CanonBall
            
        default:
            break
        }
        
        if ammo != nil && stuff != nil{
            stuff.beingHit(scene: self)
            
        }
        
        
        
        
    }
    
    
    func setupPickUp(nodeA: SKNode, nodeB: SKNode)  {
        
        
        var drop: Drop!
        var itemTexture: SKNode!
        var weaponTexture: SKNode!
        var eggTexture: SKNode!
        var playerNode: Player!
        var pet: Pet!
        var collection: Collection!
        
        switch nodeA.name {
        case "player":
            playerNode = player
        case "heart":
            drop = (nodeA as! Drop)
        case "coin":
            drop = (nodeA as! Drop)
        case "potionTexture":
            itemTexture = nodeA
        case "fireBombTexture":
            itemTexture = nodeA
        case "appleTexture":
            itemTexture = nodeA
        case "cokeTexture":
            itemTexture = nodeA
        case "chickenEggTexture":
            eggTexture = nodeA
        case "catEggTexture":
            eggTexture = nodeA
        case "staffTexture":
            weaponTexture = nodeA
        case "candyBarTexture":
            weaponTexture = nodeA
        case "swordTexture":
            weaponTexture = nodeA
        case "fishingRodTexture":
            weaponTexture = nodeA
        case "panda":
            pet = (nodeA as! Panda)
        case "poop":
            collection = (nodeA as! Collection)
        case "truffle":
            collection = (nodeA as! Truffle)
        case "ducky":
            collection = (nodeA as! Ducky)
        default:
            break
        }
        
        switch nodeB.name {
        case "player":
            playerNode = player
        case "heart":
            drop = (nodeB as! Drop)
        case "coin":
            drop = (nodeB as! Drop)
        case "potionTexture":
            itemTexture = nodeB
        case "fireBombTexture":
            itemTexture = nodeB
        case "appleTexture":
            itemTexture = nodeB
        case "cokeTexture":
            itemTexture = nodeB
        case "chickenEggTexture":
            eggTexture = nodeB
        case "catEggTexture":
            eggTexture = nodeB
        case "staffTexture":
            weaponTexture = nodeB
        case "candyBarTexture":
            weaponTexture = nodeB
        case "swordTexture":
            weaponTexture = nodeB
        case "fishingRodTexture":
            weaponTexture = nodeB
        case "panda":
            pet = (nodeB as! Panda)
        case "poop":
            collection = (nodeB as! Collection)
        case "truffle":
            collection = (nodeB as! Truffle)
        case "ducky":
            collection = (nodeB as! Ducky)
        default:
            break
        }
        
        if playerNode != nil && collection != nil{
            let add = SKAction.run({
                self.player.collectionList.append(fromType(type: collection.type))
                self.player.collectionChanged = true
            })
            let action = SKAction.move(to: collectionBorn.position + CGPoint(x: 0, y: -30 * player.collectionList.count), duration: 0.5)
            collection.physicsBody = nil
            collection.run(SKAction.sequence([action,SKAction.removeFromParent(),add]))
        }
        
        
        if drop != nil && playerNode != nil {
            drop.pickUpEffect(homeScene: self)
            drop.removeFromParent()
        }
        
        if eggTexture != nil && playerNode != nil{
            let render = SKAction.run({
                self.player.eggTextureList.append(eggTexture)
                self.player.eggChanged = true
            })
            //print("enter!")
            eggTexture.physicsBody = nil
            let moveAction = SKAction.move(to: CGPoint(x: 191, y: 22) +  CGPoint(x: -30 * player.eggTextureList.count, y:  0 ), duration: 0.5)
            
            self.run(pickSound)
            eggTexture.run(SKAction.sequence([moveAction,SKAction.removeFromParent(),render]))
            
            
        }
        
        
        if playerNode != nil  && itemTexture != nil{
            switch itemTexture.name {
            case "potionTexture":
                player.itemList.append(Potion())
                
                self.run(bottleSound)
            case "fireBombTexture":
                player.itemList.append(FireBomb())
                
                self.run(pickSound)
            case "appleTexture":
                player.itemList.append(Apple())
                
                self.run(pickSound)
            case "cokeTexture":
                player.itemList.append(Coke())
                
                self.run(pickSound)
            default:
                print("break")
            }
            setupItemOrder()
            movToPopo(node: itemTexture)
        }
        
        if pet != nil  && itemTexture != nil{
            if pet.name == "panda"{
                
                let panda = pet as! Panda
                panda.targetNode = nil
                
                switch itemTexture.name {
                case "potionTexture":
                    player.itemList.append(Potion())
                    
                    self.run(bottleSound)
                case "fireBombTexture":
                    player.itemList.append(FireBomb())
                    
                    self.run(pickSound)
                case "appleTexture":
                    player.itemList.append(Apple())
                    
                    self.run(pickSound)
                case "cokeTexture":
                    player.itemList.append(Coke())
                    
                    self.run(pickSound)
                default:
                    print("break")
                }
                setupItemOrder()
                movToPopo(node: itemTexture)
            }
        }
        
        
        
        
        //pick up weapon
        if playerNode != nil && weaponTexture != nil {
            
            //make a reload sound
            
            self.run(wearSound)
            let node = fromTypeTexture(type: player.weapon.weaponType)
            node.position = player.position  +  player.facing * 50
            self.addChild(node)
            shootWithDirection(node: node, homeScene: self)
            
            player.rStart = 0
            
            switch weaponTexture.name {
            case "staffTexture":
                player.weapon = fromType(type: .staff)
                player.weaponChanged = true
            case "candyBarTexture":
                player.weapon = fromType(type: .candyBar)
                player.weaponChanged = true
            case "swordTexture":
                player.weapon = fromType(type: .sword)
                player.weaponChanged = true
            case "fishingRodTexture":
                player.weapon = fromType(type: .fishingRod)
                player.weaponChanged = true
                
            default:
                break
            }
            
            weaponTexture.removeFromParent()
            
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
            player.inItemListNumber = 0
        }else{
            //print("\(player.itemList.count)")
            player.item = player.itemList[player.itemList.count-1]
            player.inItemListNumber = player.itemList.count-1
        }
        player.itemChanged = true
    }
    
    func setupBulletHit(nodeA: SKNode, nodeB: SKNode)  {
        
        var ammo: Ammo!
        
        switch nodeA.name {
        case "staffBullet":
            ammo = (nodeA as! Ammo)
        case "candy":
            ammo = (nodeA as! Ammo)
        case "canonBall":
            ammo = (nodeA as! Ammo)
        case "egg":
            ammo = (nodeA as! Ammo)
        default:
            break
        }
        switch nodeB.name {
        case "staffBullet":
            ammo = (nodeB as! Ammo)
        case "candy":
            ammo = (nodeB as! Ammo)
        case "canonBall":
            ammo = (nodeB as! Ammo)
        case "egg":
            ammo = (nodeB as! Ammo)
        default:
            break
        }
        
        if ammo != nil {
            
            let bulletHitPoint = BulletHitPoint(scene: self)
            bulletHitPoint.position = ammo.position
            addChild(bulletHitPoint)
            bulletHitPoint.hit()
            ammo.removeFromParent()
        }
        
        //        if nodeA.name == "staffBullet" {
        //            //print("hit!")
        //
        //            let bulletHitPoint = BulletHitPoint(scene: self)
        //            bulletHitPoint.position = nodeA.position
        //            addChild(bulletHitPoint)
        //            bulletHitPoint.hit()
        //            nodeA.removeFromParent()
        //        }
        //        if nodeB.name == "staffBullet" {
        //
        //
        //            let bulletHitPoint = BulletHitPoint(scene: self)
        //            bulletHitPoint.position = nodeB.position
        //            addChild(bulletHitPoint)
        //            bulletHitPoint.hit()
        //            nodeB.removeFromParent()
        //
        //        }
        
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
//            let bornScene = sceneList[self.bornRoom()]
//            player.bornScene = bornScene
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
            //self.run(SKAction.playSoundFileNamed("door.mp3", waitForCompletion: true))
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
                    
                    scene.run(doorSound)
                    let fade = SKTransition.fade(withDuration: 1)
                    view.presentScene(scene, transition: fade)
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                    view.ignoresSiblingOrder = true
                    
                }
            }
            
            
            
            // }
        }
    }
    
    func setupDamage(nodeA: SKNode, nodeB: SKNode) {
        
        //bullet and monster
        var monster: Monster!
        var ammo: Ammo!
        var playerNode: Player!
        
        
        switch nodeA.name {
        case "log":
            monster = (nodeA as! Monster)
        case "slime":
            monster = (nodeA as! Monster)
        case "ghost":
            monster = (nodeA as! Monster)
        case "scarecrow":
            monster = (nodeA as! Monster)
        case "staffBullet":
            ammo = (nodeA as! Ammo)
        case "candy":
            ammo = (nodeA as! Ammo)
        case "canonBall":
            ammo = (nodeA as! Ammo)
        case "egg":
            ammo = (nodeA as! Ammo)
        case "player":
            playerNode = player
            
        default:
            break
        }
        
        switch nodeB.name {
        case "log":
            monster = (nodeB as! Monster)
        case "slime":
            monster = (nodeB as! Monster)
        case "ghost":
            monster = (nodeB as! Monster)
        case "scarecrow":
            monster = (nodeB as! Monster)
        case "staffBullet":
            ammo = (nodeB as! Ammo)
        case "candy":
            ammo = (nodeB as! Ammo)
        case "canonBall":
            ammo = (nodeB as! Ammo)
        case "egg":
            ammo = (nodeB as! Ammo)
        case "player":
            playerNode = player
            
        default:
            break
        }
        
        if monster != nil && ammo != nil {
            
            if ammo.name == "canonBall" || ammo.name == "egg"{
                monster.beingHit(homeScene: self, damage: 0.25)
            }else{
                monster.beingHit(homeScene: self)
            }
        }
        
        
        
        if monster != nil && playerNode != nil{
            if monster.name == "scarecrow"{return}
            player.beingHit()
        }
        
        if playerNode != nil && ammo != nil {
            if ammo.name == "canonBall"{
                player.beingHit(damage: 1)
            }else{
                player.beingHit()
            }
        }
        
        
    }
    
    
    
    func setupMonster(num: Int) {
        
        for _ in 0..<num {
 //           var borned = false
//            var check = 0
//            var bornX = CGFloat.random(in: 50..<self.frame.width-50)
//            var bornY = CGFloat.random(in: 50..<self.frame.height-50)
//            while !borned {
//                for node in self.children {
//                    if node.physicsBody != nil && node.frame.contains(CGPoint(x: bornX, y: bornY)) {
//                        bornX = CGFloat.random(in: 50..<self.frame.width-50)
//                        bornY = CGFloat.random(in: 50..<self.frame.height-50)
//                        break
//                    }else {
//                        check += 1
//                        if check == self.children.count {borned = true}
//                    }
//                }
//            }
            
            var bornX = CGFloat.random(in: 50..<self.frame.width-50)
            var bornY = CGFloat.random(in: 50..<self.frame.height-50)
            while atPoint(CGPoint(x: bornX, y: bornY)).physicsBody != nil{
                bornX = CGFloat.random(in: 50..<self.frame.width-50)
                bornY = CGFloat.random(in: 50..<self.frame.height-50)
            }
            
            //let newLog = Log(scene: self)
            
            let wait = SKAction.wait(forDuration: TimeInterval.random(in: 0..<2))
            
            let born = SKAction.run({
                let monster = fromType(type: MonsterType.random(), homeScene: self)
                monster.position = CGPoint(x: bornX, y: bornY)
                //self.addChild(monster)
                self.monsterBorn(monster: monster)
                self.monsterList.append(monster)
            })
            
            self.run(SKAction.sequence([wait,born]))
        }
        
    }
    
    func resetMonster(monsterList: [Monster]) {
        for monster in monsterList{
            var bornX = CGFloat.random(in: 50..<self.frame.width-50)
            var bornY = CGFloat.random(in: 50..<self.frame.height-50)
            while atPoint(CGPoint(x: bornX, y: bornY)).physicsBody != nil{
                bornX = CGFloat.random(in: 50..<self.frame.width-50)
                bornY = CGFloat.random(in: 50..<self.frame.height-50)
            }
            monster.position = CGPoint(x: bornX, y: bornY)
            monster.move(toParent: self)
        }
    }
    
    func monsterBorn(monster: SKNode)  {
        let bornEffect = MonsterBornEffect(scene: self)
        bornEffect.position = monster.position
        addChild(bornEffect)
        
        let wait = SKAction.wait(forDuration: 1)
        
        let born = SKAction.run({
            self.addChild(monster)
            
        })
        
        self.run(SKAction.sequence([SKAction.run(bornEffect.start),wait,born]))
        
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
                    newRoom.zPosition = 100
                    newRoom.alpha = 0.5
                    newRoom.position = mapPosition.position + CGPoint(x: 20*x, y: -20*y)
                 
                    
                    //monster room
                    let scene = getSceneFromMap(y: y,x: x)

                    if map[y][x] == 1 && !scene.isDoorSet{
                        let texture = SKTexture(imageNamed: "monsterAliveLogo")
                        let node = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 15, height: 15))
                        node.name = "newRoom"
                        node.position = newRoom.position
                        node.zPosition = 101
                        addChild(node)
                    }
                    else if map[y][x] == 1 && scene.isDoorSet{
                        //newRoom.color = .blue
                        let texture = SKTexture(imageNamed: "monsterDieLogo")
                        let node = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 15, height: 15))
                        node.name = "newRoom"
                        node.position = newRoom.position
                        node.zPosition = 101
                        addChild(node)
                    }
                    //cave room
                    if map[y][x] == 5 {
//                        newRoom.color = .black
                        let texture = SKTexture(imageNamed: "caveLogo")
                        let node = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 15, height: 15))
                        node.name = "newRoom"
                        node.position = newRoom.position
                        node.zPosition = 101
                        addChild(node)
                    }
                    
                    //fish room
                    if map[y][x] == 10 {
                        let texture = SKTexture(imageNamed: "fishRIght")
                        let node = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 15, height: 15))
                        node.name = "newRoom"
                        node.position = newRoom.position
                        node.zPosition = 101
                        addChild(node)
                    }
                   
                    
                    //home room && break room
                    if map[y][x] == 2 || map[y][x] == 6{
//                        newRoom.color = .purple
                        let texture = SKTexture(imageNamed: "homeLogo")
                        let node = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 15, height: 15))
                        node.name = "newRoom"
                        node.position = newRoom.position
                        node.zPosition = 101
                        addChild(node)
                    }
                    
                    //farmRoom
                    if map[y][x] == 12 {
                        let texture = SKTexture(imageNamed: "farmLogo")
                        let node = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 15, height: 15))
                        node.name = "newRoom"
                        node.position = newRoom.position
                        node.zPosition = 101
                        addChild(node)
                    }
                    
                    //stoneRoom
                    if map[y][x] == 9 {
                        let texture = SKTexture(imageNamed: "stoneLogo")
                        let node = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 15, height: 15))
                        node.name = "newRoom"
                        node.position = newRoom.position
                        node.zPosition = 101
                        addChild(node)
                    }
                    
                    //challenge
                    if map[y][x] == 7 {
                        let texture = SKTexture(imageNamed: "canonLogo")
                        let node = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 15, height: 15))
                        node.name = "newRoom"
                        node.position = newRoom.position
                        node.zPosition = 101
                        addChild(node)
                    }
                    
                    //monster bonus room
                    if map[y][x] == 11 {
                        let texture = SKTexture(imageNamed: "treasureLogo")
                        let node = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 15, height: 15))
                        node.name = "newRoom"
                        node.position = newRoom.position
                        node.zPosition = 101
                        addChild(node)
                    }
                    
                    //village bonus break room
                    if map[y][x] == 8 || map[y][x] == 3 || map[y][x] == 6 {
                        let texture = SKTexture(imageNamed: "bedLogo")
                        let node = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 15, height: 15))
                        node.name = "newRoom"
                        node.position = newRoom.position
                        node.zPosition = 101
                        addChild(node)
                    }
                    
                    
                    
                    //player room
                    if x == YX.x && y == YX.y {
                        newRoom.color = .red
                    }
                    
                    
                    
                    
                    
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
                if  let scene = self.right{
                    scene.scaleMode = .aspectFit
                    scene.player = player
                    if scene.isDoorSet{
                        scene.player.position = scene.leftDoor.position + CGPoint(x: -30, y:0)
                    }else {
                        scene.player.position = scene.leftDoor.position
                    }
                    //scene?.handler.position = self.handler.position
                    
                    scene.run(portalsound)
                    scene.sceneList = sceneList
                    view.presentScene(scene, transition: fade)
                    view.showsFPS = true
                    view.showsNodeCount = true
                    view.ignoresSiblingOrder = true
                }
                
                
            }
        }
        if (nodeA.name == "leftDoor" && nodeB.name == "player") || (nodeA.name == "player" && nodeB.name == "leftDoor") {
            if  let view = self.view as SKView?{
                if let scene = self.left{
                    scene.scaleMode = .aspectFit
                    scene.player = player
                    if scene.isDoorSet{
                        scene.player.position = scene.rightDoor.position + CGPoint(x: 30, y: 0)
                    }else{
                        scene.player.position = scene.rightDoor.position + CGPoint(x: 0, y: 0)
                    }
                    //scene?.handler.position = self.handler.position
                    
                    scene.run(portalsound)
                    scene.sceneList = sceneList
                    view.presentScene(scene, transition: fade)
                    view.showsFPS = true
                    view.showsNodeCount = true
                    view.ignoresSiblingOrder = true
                
                }
            }
            
        }
        if (nodeA.name == "topDoor" && nodeB.name == "player") || (nodeA.name == "player" && nodeB.name == "topDoor") {
            if  let view = self.view as SKView?{
                if let scene = self.top{
                    scene.scaleMode = .aspectFit
                    scene.player = player
                    if scene.isDoorSet{
                        scene.player.position = scene.bottomDoor.position + CGPoint(x: 0, y: -30)
                    }else{
                        scene.player.position = scene.bottomDoor.position + CGPoint(x: 0, y: 0)
                    }
                    scene.run(portalsound)
                    //scene?.handler.position = self.handler.position
                    scene.sceneList = sceneList
                    view.presentScene(scene, transition: fade)
                    view.showsFPS = true
                    view.showsNodeCount = true
                    view.ignoresSiblingOrder = true
                }
            }
        }
        if (nodeA.name == "bottomDoor" && nodeB.name == "player") || (nodeA.name == "player" && nodeB.name == "bottomDoor") {
            if  let view = self.view as SKView?{
                if let scene = self.bototm{
                    scene.scaleMode = .aspectFit
                    scene.player = player
                    if scene.isDoorSet{
                        scene.player.position = scene.topDoor.position + CGPoint(x: 0, y: 30)
                    }else{
                        scene.player.position = scene.topDoor.position + CGPoint(x: 0, y: 0)
                    }
                    scene.run(portalsound)
                    //scene?.handler.position = self.handler.position
                    scene.sceneList = sceneList
                    view.presentScene(scene, transition: fade)
                    view.showsFPS = true
                    view.showsNodeCount = true
                    view.ignoresSiblingOrder = true
                }
            }
        }
        
        
        
        //self.setupIsSet = true
    }
    
    func setupHomeOrKeepGoing()  {
        let homeBoard = Board(name: "home")
        let homePosition = (self.childNode(withName: "homePosition") as! SKSpriteNode)
        homeBoard.position = homePosition.position
        homeBoard.selectHandler = {
            //let homePortal = Door(position: homeBoard.position + CGPoint(x: 0, y: 50), name: "homeDoor", doorDirection: .up)
            let homePortal = Portal(position: homeBoard.position + CGPoint(x: 0, y: 50), name: "homeDoor")
            self.addChild(homePortal)
        }
        addChild(homeBoard)
        
        if player.gameLevel == 5 {player.gameLevel = 1;return}
        
        let continueBoard = Board(name: "continue")
        let continuePosition = (self.childNode(withName: "continuePosition") as! SKSpriteNode)
        continueBoard.position = continuePosition.position
        continueBoard.selectHandler = {
            //let continuePortal = Door(position: continueBoard.position + CGPoint(x: 0, y: 50), name: "continueDoor", doorDirection: .up)
            let continuePortal = Portal(position: continueBoard.position + CGPoint(x: 0, y: 50), name: "continueDoor")
            
            self.addChild(continuePortal)
        }
        addChild(continueBoard)
        
        
    }
    
    
    func setupDoor() {
//        topDoor = (self.childNode(withName: "topDoor") as! SKSpriteNode)
//        bottomDoor = (self.childNode(withName: "bottomDoor") as! SKSpriteNode)
//        leftDoor = (self.childNode(withName: "leftDoor") as! SKSpriteNode)
//        rightDoor = (self.childNode(withName: "rightDoor") as! SKSpriteNode)
        let wait = SKAction.wait(forDuration: 0.5)
        let firstAction = SKAction.run({
            if self.top != nil {
                let door = Door(position: self.topDoor.position + CGPoint(x: 0, y: 80), name: "topDoor", doorDirection: .up)
                self.addChild(door)
                door.alpha = 0
                door.run(SKAction.fadeAlpha(to: 1, duration: 1))
                
                self.run(self.portalBornSound)
                
                for node in self.children{
                    if node.name == "topGate"{
                        node.removeFromParent()
                    }
                }
            }
  
        })
        let secondAction = SKAction.run({
            if self.bototm != nil {
                
                let door = Door(position: self.bottomDoor.position + CGPoint(x: 0, y: -80),name: "bottomDoor", doorDirection: .down)
                self.addChild(door)
                door.alpha = 0
                door.run(SKAction.fadeAlpha(to: 1, duration: 1))
                
                self.run(self.portalBornSound)
                
                for node in self.children{
                    if node.name == "bottomGate"{
                        node.removeFromParent()
                    }
                }
            }
            
        })
        
        let thirdAction = SKAction.run({
            if self.left != nil {
                
                let door = Door(position: self.leftDoor.position + CGPoint(x: -80, y: 0),name: "leftDoor",doorDirection: .left)
                self.addChild(door)
                door.alpha = 0
                door.run(SKAction.fadeAlpha(to: 1, duration: 1))
                
                self.run(self.portalBornSound)
                for node in self.children{
                    if node.name == "leftGate"{
                        node.removeFromParent()
                    }
                }
            }
            
        })
        let fourthAction = SKAction.run({
            if self.right != nil {
                
                let door = Door(position: self.rightDoor.position + CGPoint(x: 80, y: 0),name: "rightDoor",doorDirection: .right)
                self.addChild(door)
                door.alpha = 0
                door.run(SKAction.fadeAlpha(to: 1, duration: 1))
                
                self.run(self.portalBornSound)
                
                for node in self.children{
                    if node.name == "rightGate"{
                        node.removeFromParent()
                    }
                }
            }
            
        })
        
        self.run(SKAction.sequence([firstAction,wait,secondAction,wait,thirdAction,wait,fourthAction]))
        
        //set power
        if isMonsterRoom || isEnterCaveRoom{
        
            //born box
            if Int.random(in: 0..<10)<3{
                let box = Box()
                box.physicsBody?.pinned = false
                let middlePoint = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
                let position = middlePoint.randomPointInDistamce(distance: 50)
                box.position = position + CGPoint(x: 0, y: 400)
                addChild(box)
                let action = SKAction.move(to: position, duration: 1)
                action.timingMode = .easeIn
                box.run(SKAction.sequence([action,SKAction.run({box.physicsBody?.pinned=true})]))
            }
            
            
            // power selection
            if Int.random(in: 0..<10)<1{
                
                if powerTextureBorn == nil{
                    powerTextureBorn = SKSpriteNode(color: .red, size: CGSize(width: 1, height: 1))
                    powerTextureBorn.position = CGPoint(x: 334, y: 192)
                    powerTextureBorn.zPosition = 1
                }
                
                let firstTexture = fromTypeTexture(type: PowerType.random())
                firstTexture.zPosition = 100
                firstTexture.position = CGPoint(x: -153, y: 0)
                firstTexture.alpha = 0
                let secondTexture = fromTypeTexture(type: PowerType.random())
                secondTexture.zPosition = 100
                secondTexture.position = CGPoint(x: 0, y: 0)
                secondTexture.alpha = 0
                let thirdTexture = fromTypeTexture(type: PowerType.random())
                thirdTexture.zPosition = 100
                thirdTexture.position = CGPoint(x: 153, y: 0)
                thirdTexture.alpha = 0
                addChild(powerTextureBorn)
                
                powerTextureBorn.addChild(firstTexture)
                powerTextureBorn.addChild(secondTexture)
                powerTextureBorn.addChild(thirdTexture)
                
                firstTexture.run(SKAction.fadeAlpha(to: 1, duration: 1))
                secondTexture.run(SKAction.fadeAlpha(to: 1, duration: 1))
                thirdTexture.run(SKAction.fadeAlpha(to: 1, duration: 1))
                
                firstTexture.run(SKAction(named: "idle")!)
                secondTexture.run(SKAction(named: "idle")!)
                thirdTexture.run(SKAction(named: "idle")!)
                
                self.inDialogue = true
            }
            
        }
        
        
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
            if !player.monsterInAutoDetectRange{
                player.facing = vec.normalized()
            }
            player.movingDirection = vec.normalized()
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
                        player.bornScene = gameScene
                    }else if self.map[y][x] == 3 {
                        let gameScene = GameScene.level(3)!
                        gameScene.YX = GridYX(y: y, x: x)
                        gameScene.isBonusRoom = true
                        sceneList.append(gameScene)
                        player.bonusRoom = gameScene
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
                    else if self.map[y][x] == 7 {
                        let gameScene = GameScene.level(13)!
                        gameScene.YX = GridYX(y: y, x: x)
                        gameScene.isChallengeRoom = true
                        gameScene.isMonsterRoom = true
                        sceneList.append(gameScene)
                    }
                    else if self.map[y][x] == 8 {
                        let gameScene = GameScene.level(12)!
                        gameScene.YX = GridYX(y: y, x: x)
                        gameScene.isVillageRoom = true
                        sceneList.append(gameScene)
                        player.villageRoom = gameScene
                    }
                    else if self.map[y][x] == 9 {
                        let gameScene = GameScene.level(11)!
                        gameScene.YX = GridYX(y: y, x: x)
                        gameScene.isStoneRoom = true
                        sceneList.append(gameScene)
                    }
                    else if self.map[y][x] == 10 {
                        let gameScene = GameScene.level(10)!
                        gameScene.YX = GridYX(y: y, x: x)
                        gameScene.isFishRoom = true
                        sceneList.append(gameScene)
                        player.fishRoom = gameScene
                    }
                    else if self.map[y][x] == 11 {
                        let gameScene = GameScene.level(9)!
                        gameScene.YX = GridYX(y: y, x: x)
                        gameScene.isMonsterBonusRoom = true
                        gameScene.isMonsterRoom = true
                        sceneList.append(gameScene)
                    }
                    else if self.map[y][x] == 12 {
                        let gameScene = GameScene.level(14)!
                        gameScene.YX = GridYX(y: y, x: x)
                        gameScene.isFarmRoom = true
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
        
        
        //get left right top bottom door
        for scene in sceneList{
            for node in scene.children{
                if node.name == "leftDoor"{scene.leftDoor = (node as! SKSpriteNode)}
                if node.name == "rightDoor"{scene.rightDoor = (node as! SKSpriteNode)}
                if node.name == "topDoor"{scene.topDoor = (node as! SKSpriteNode)}
                if node.name == "bottomDoor"{scene.bottomDoor = (node as! SKSpriteNode)}
            }
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


