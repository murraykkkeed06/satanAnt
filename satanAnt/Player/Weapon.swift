//
//  Weapon.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/3/27.
//

import Foundation
import SpriteKit
import AVFoundation

class Weapon: SKSpriteNode {
    
    var attackPoint: CGFloat!
    var attackSpeed: TimeInterval!
    var AudioPlayer = AVAudioPlayer()
    var AudioPlayer2 = AVAudioPlayer()
    var shootSound: NSURL!
    var swordSound: NSURL!
    var tempTime: TimeInterval = 0.3
    
    init(name: String){
        
        //shootSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "shoot", ofType: "mp3")!)
        swordSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "swordHit", ofType: "wav")!)
        
        
        let texture = SKTexture(imageNamed: name)
        super.init(texture: texture, color: .clear, size: CGSize(width: 40, height: 24))
        self.name = name
        self.zPosition = 6
        
        switch name {
        case "staff":
            attackPoint = 0.25
            attackSpeed = 0.1
        default:
            attackPoint = 0.25
            attackSpeed = 0.5
        }
        
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func rAttack(direction: CGPoint, homeScene: GameScene){
        if self.name == "staff"{
            if let bornPoint = homeScene.weaponOnHand.childNode(withName: "bornPoint"){
                let position = homeScene.weaponOnHand.convert(bornPoint.position, to: homeScene)
                let bullet1 = Bullet(position: position, name: "staffBullet",homeScene: homeScene)
                let bullet2 = Bullet(position: position, name: "staffBullet",homeScene: homeScene)
                let bullet3 = Bullet(position: position, name: "staffBullet",homeScene: homeScene)
                homeScene.addChild(bullet1)
                homeScene.addChild(bullet2)
                homeScene.addChild(bullet3)
                bullet1.flyTo(degree: direction.angle)
                bullet2.flyTo(degree: direction.angle + 20)
                bullet3.flyTo(degree: direction.angle - 20)
                
                //sound
//                self.AudioPlayer2 = try! AVAudioPlayer(contentsOf: self.shootSound as URL)
//
//                self.AudioPlayer2.volume = 1
//                self.AudioPlayer2.prepareToPlay()
                //self.AudioPlayer2.play()
                
                let sound = SKAction.playSoundFileNamed("shoot.mp3", waitForCompletion: false)
                homeScene.run(sound)
                
                
            }
        }
        
    }
    
    
    func attack(direction: CGPoint, homeScene: GameScene){
        
        if homeScene.player.sinceFire < tempTime + homeScene.player.baseBulletSpeed {return}
        
        switch tempTime {
        case 0.3:
            tempTime=0.2
        case 0.2:
            tempTime=0.1
        case 0.1:
            tempTime=0.3
        default:
            break
        }
        
        homeScene.player.sinceFire = 0
        
        var useSword = false
        
        //use sword in distance < 30
        let distance: CGFloat = 60
        for i in 0..<homeScene.logList.count{
            let diff = homeScene.logList[i].position.distanceTo(homeScene.player.position)
            var vec = homeScene.logList[i].position - homeScene.player.position
            if diff<distance && abs(vec.normalize().angle - homeScene.player.facing.angle)<30 && homeScene.logList[i].isAlived{
                let attackPoint = AttackPoint()
                let bornPoint = homeScene.player.position + (homeScene.logList[i].position - homeScene.player.position)/2
                attackPoint.position = bornPoint
                homeScene.addChild(attackPoint)
                attackPoint.startPoint()
                homeScene.logList[i].beingHit()
                useSword = true
                
                //sound
                
                self.AudioPlayer = try! AVAudioPlayer(contentsOf: self.swordSound as URL)
                self.AudioPlayer.volume = 3
                self.AudioPlayer.prepareToPlay()
                self.AudioPlayer.play()
                
                
                
                break
            }
        }
        //print("sword: \(useSword)")
        //use bullet
        if useSword {return}
        if self.name == "staff"{
            if let bornPoint = homeScene.weaponOnHand.childNode(withName: "bornPoint"){
                let position = homeScene.weaponOnHand.convert(bornPoint.position, to: homeScene)
                let bullet = Bullet(position: position, name: "staffBullet",homeScene: homeScene)
                homeScene.addChild(bullet)
                bullet.flyTo(direction: direction)
                
                //sound
//                self.AudioPlayer2 = try! AVAudioPlayer(contentsOf: self.shootSound as URL)
//
//                self.AudioPlayer2.volume = 1
//                self.AudioPlayer2.prepareToPlay()
                //self.AudioPlayer2.play()
                
                let sound = SKAction.playSoundFileNamed("shoot.mp3", waitForCompletion: false)
                homeScene.run(sound)
                
                
            }
        }
        
        
    }
    
    
    
    
    func attack(degree: CGFloat, homeScene: GameScene){
        
        if self.name == "staff"{
            if let bornPoint = homeScene.weaponOnHand.childNode(withName: "bornPoint"){
                let position = homeScene.weaponOnHand.convert(bornPoint.position, to: homeScene)
                let bullet = Bullet(position: position, name: "staffBullet",homeScene: homeScene)
                homeScene.addChild(bullet)
                bullet.flyTo(degree: degree)
            }
            
        }
        
        
    }
    
}
