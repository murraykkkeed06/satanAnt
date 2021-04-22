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
    
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var startLabel: UILabel!
    
  
    @IBAction func pressButton(_ sender: Any) {
       
        print("enter!")
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        changeScene()
        
    
        //changeScene()
    }
    
   
    override func viewDidLoad() {

        //set font style
        self.startLabel.font = UIFont(name: "Chalkduster", size: 20)
        self.startLabel.textColor = .black
        
        
        //set animate
        let imageView = UIImageView(frame: CGRect(x: 168, y: 87.5, width: 300, height: 200))
        view.addSubview(imageView)
        let animatedImage = UIImage.animatedImageNamed("gifDemo-", duration: 1)
        imageView.image = animatedImage
       

        super.viewDidLoad()
        
        let sound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "rainy", ofType: "mp3")!)
        AudioPlayer = try! AVAudioPlayer(contentsOf: sound as URL)
        AudioPlayer.prepareToPlay()
        AudioPlayer.numberOfLoops = -1
        
        
    }
    
    func changeScene()  {
        if let view = self.view as! SKView? {
            
            if let scene = StartScene(fileNamed: "StartScene"){
                
                let fade = SKTransition.fade(withDuration: 5)
                AudioPlayer.play()
                scene.scaleMode = .aspectFit
                view.presentScene(scene, transition: fade)
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


