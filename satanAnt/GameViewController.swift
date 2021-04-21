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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "rainy", ofType: "mp3")!)
        AudioPlayer = try! AVAudioPlayer(contentsOf: sound as URL)
        AudioPlayer.prepareToPlay()
        AudioPlayer.numberOfLoops = -1
        AudioPlayer.play()
        
        //player = Player()
        
        
        if let view = self.view as! SKView? {
            
            if let scene = StartScene(fileNamed: "StartScene"){
                scene.scaleMode = .aspectFit
                view.presentScene(scene)
                view.ignoresSiblingOrder = true
                view.showsFPS = true
                view.showsNodeCount = true
            }
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


