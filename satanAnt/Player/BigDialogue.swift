//
//  BigDialogue.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/4.
//

import Foundation
import SpriteKit

class BigDialogue: SKSpriteNode {
    
    var homeScene: GameScene!
    var timer: Timer!
    var num: Int = 0
    var wordList = [SKLabelNode]()
    var isFinish = false
    
    init(scene: GameScene){
        let texture = SKTexture(imageNamed: "bigDialogue")
        //super.init(texture: texture, color: .clear, size: CGSize(width: 412, height: 124))
        super.init(texture: texture, color: .clear, size: CGSize(width: 20, height: 20))
        //self.position = CGPoint(x: 337, y: 116)
        self.zPosition = 20
        self.name = "bigDialgoue"
        self.homeScene = scene
        self.anchorPoint = CGPoint(x: 0, y: 1)
        self.isUserInteractionEnabled = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func startWord()  {
        
        let startPoint = self.position + CGPoint(x: 30, y: -30)
        var colNumber = 0
        var rowNumber = 0
        let newWord = Word()
        let newWordString = newWord.helloWord
        for i in 0..<newWordString.count{
            
            
            let word = SKLabelNode.init(fontNamed: "Chalkduster")
            word.fontSize = 16
            word.fontColor = .black
            word.zPosition = 21
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
        runStart()
    }
    
    func runStart(){
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(addWord), userInfo: nil, repeats: true)
    }
    
    @objc func addWord(){
        homeScene.addChild(wordList[num])
        num += 1
        if num == wordList.count {timer.invalidate();isFinish = true}
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
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
