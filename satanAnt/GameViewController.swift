//
//  GameViewController.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/3/24.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation
import SwiftyJSON

class GameViewController: UIViewController {

    var AudioPlayer = AVAudioPlayer()
    
    //5 * 7
    var sceneList = [GameScene]()
    
    
    var map = [[Int]]()
    var player: Player!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "rainy", ofType: "mp3")!)
        AudioPlayer = try! AVAudioPlayer(contentsOf: sound as URL)
        AudioPlayer.prepareToPlay()
        AudioPlayer.numberOfLoops = -1
        AudioPlayer.play()
        
        player = Player()
        
//        player.inMapNumber = Int.random(in: 0..<Map().map.count)
//        map = Map().map[player.inMapNumber]
//        setupSceneList()
//        let bornScene = sceneList[self.bornRoom()]
//        player.bornScene = bornScene
        
        readData()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            
            
            if let scene = GameScene.level(4) {
                player.roomScene = scene
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                scene.isBedRoom = true
                //scene.isMonsterRoom = false
                //setupButton(scene: scene)
                
                
                player.position = CGPoint(x: 160, y: 250)
                
                scene.player = player
                
                    // Present the scene
                view.presentScene(scene)
                
                
                view.ignoresSiblingOrder = true
                
                view.showsFPS = true
                view.showsNodeCount = true
            }
        }
    }
    
    func readData()  {
        

        do {
            
            let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let path = URL(fileURLWithPath: "playerData", relativeTo: directoryURL)

            let savedData = try Data(contentsOf: path)
            let json = try JSON(data: savedData)
            //print("\(json.count)")
            if let savingTime = json["savingTime"].int {
                player.savingTime = savingTime
            }
            
            if let attackPoint = json["attackPoint"].int {
                player.baseAttackPoint = CGFloat(attackPoint)
            }
            
            if let bulletSpeedPoint = json["bulletSpeedPoint"].int {
                player.baseBulletSpeedPoint = TimeInterval(bulletSpeedPoint)
            }
            if let healthPoint = json["healthPoint"].int {
                player.baseHealthPoint = CGFloat(healthPoint)
            }
            if let rangePoint = json["rangePoint"].int {
                player.baseBulletRangePoint = CGFloat(rangePoint)
            }
            
            print("able to read file!")
        } catch {
            // Catch any errors
            print("Unable to read the file")
        }
        
        
        
        
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}


