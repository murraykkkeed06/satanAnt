//
//  BigDialogue.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/4.
//

import Foundation
import SpriteKit
import AVFoundation

class BigDialogue: SKSpriteNode {
    var AudioPlayer = AVAudioPlayer()
    var typeSound: NSURL!
    var homeScene: GameScene!
    var timer: Timer!
    var num: Int = 0
    var wordList = [SKLabelNode]()
    var isFinish = false
    var selectHandler: ()->Void = {print("big dialogue touch not implemented!")}
    
    init(scene: GameScene){
        typeSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "talking", ofType: "mp3")!)
        AudioPlayer = try! AVAudioPlayer(contentsOf: self.typeSound as URL)
        AudioPlayer.volume = 5
        let texture = SKTexture(imageNamed: "bigDialogue")
        //super.init(texture: texture, color: .clear, size: CGSize(width: 412, height: 124))
        super.init(texture: texture, color: .clear, size: CGSize(width: 20, height: 20))
        //self.position = CGPoint(x: 337, y: 116)
        self.zPosition = 200
        self.name = "bigDialgoue"
        self.homeScene = scene
        self.anchorPoint = CGPoint(x: 0, y: 1)
        self.isUserInteractionEnabled = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func startWord(sentence: String)  {
        
//        let startPoint = self.position + CGPoint(x: 30, y: -30)
        let startPoint = CGPoint(x: 155, y: 160)
        var colNumber = 0
        var rowNumber = 0
//        let newWord = Word()
//        let newWordString = newWord.helloWord
        let newWordString = sentence
        for i in 0..<newWordString.count{
            
            
            let word = SKLabelNode.init(fontNamed: "Chalkduster")
            word.fontSize = 16
            word.fontColor = .black
            word.zPosition = 201
            //word.alpha = 0
            let index = newWordString.index(newWordString.startIndex, offsetBy: i)
            word.text = "\(newWordString[index])"
            
            
            word.position = startPoint + CGPoint(x: colNumber*12, y: -rowNumber*24)
            colNumber+=1
            if colNumber>30{rowNumber+=1;colNumber=0}
            
            //self.homeScene.addChild(word)
            wordList.append(word)
            //word.run(SKAction.fadeAlpha(by: 1, duration: 0.5))
        }
        self.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),SKAction.run(runStart)]))
        //runStart()
    }
    
    func runStart(){
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(addWord), userInfo: nil, repeats: true)
        AudioPlayer.prepareToPlay()
        AudioPlayer.play()
        
    }
    
    @objc func addWord(){
        homeScene.addChild(wordList[num])
        
        num += 1
        if num == wordList.count {timer.invalidate();isFinish = true;AudioPlayer.stop()}
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectHandler()
    }
    
    func justClose()  {
        if isFinish{
            self.removeFromParent()
            for node in wordList{
                node.removeFromParent()
            }
            //tricky way to enable handler
            homeScene.inDialogue = false
            homeScene.popoButton.isUserInteractionEnabled = true
            homeScene.fireButton.isUserInteractionEnabled = true
            //homeScene.dialogue.isHidden = false
        }
    }
}
