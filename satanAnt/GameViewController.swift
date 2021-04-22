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

    
   
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var startLabel: UILabel!
    
    var imageView: UIImageView!
    var timer: Timer!
    var toggleNum: Int = 3
    var AudioPlayer = AVAudioPlayer()
    
    @IBAction func pressButton(_ sender: Any) {
       
        changeScene()
    }
    
    override func viewDidLoad() {

        //set font style
        self.startLabel.font = UIFont(name: "Chalkduster", size: 20)
        self.startLabel.textColor = .black
        
        //set imageView
        imageView = UIImageView(frame: CGRect(x: 283.5, y: 87.5, width: 100, height: 100))
        let image = UIImage(named: "icon")
        imageView.image = image
        view.addSubview(imageView)
        
        //set animate
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
        

        super.viewDidLoad()
        
        let sound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "startMusic", ofType: "mp3")!)
        AudioPlayer = try! AVAudioPlayer(contentsOf: sound as URL)
        AudioPlayer.prepareToPlay()
        AudioPlayer.numberOfLoops = -1
        AudioPlayer.play()
        
    }
    
    @objc func changeImage()  {
        
        
        switch toggleNum {
        case 1:
            toggleNum = 2
            
            imageView.frame = CGRect(x: 183.5, y: 87.5, width: 300, height: 200)
            //view.addSubview(imageView)
            let animatedImage = UIImage.animatedImageNamed("gifDemo-", duration: 1)
            imageView.image = animatedImage
        case 2:
            toggleNum = 3
            imageView.frame = CGRect(x: 283.5, y: 87.5, width: 100, height: 100)
            
            let image = UIImage(named: "icon")
            
            imageView.image = image
            //view.addSubview(imageView)
        case 3:
            toggleNum = 1
            imageView.frame = CGRect(x: 283.5, y: 87.5, width: 100, height: 100)
            let image = UIImage(named: "newLogo")
            
            imageView.image = image
            //view.addSubview(imageView)
        default:
            break
        }
        
        
    }
    
    
    func changeScene()  {
        
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        
        AudioPlayer.stop()
        timer.invalidate()
        if let view = self.view as! SKView? {
            
            if let scene = StartScene(fileNamed: "StartScene"){
                
                let fade = SKTransition.fade(withDuration: 1)
                
                scene.scaleMode = .aspectFit
                view.presentScene(scene, transition: fade)
                view.ignoresSiblingOrder = true
                view.showsFPS = true
                view.showsNodeCount = true
               
            }
        }
        
        let sound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "rainy", ofType: "mp3")!)
        AudioPlayer = try! AVAudioPlayer(contentsOf: sound as URL)
        AudioPlayer.prepareToPlay()
        AudioPlayer.numberOfLoops = -1
        AudioPlayer.play()
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


