//
//  Player.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/3/24.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    
    var playerIsMoving = false
    
    var timer: Timer!
    
    let moveDistance: CGFloat = 0.02
    
    var timerSet = false
    
    var facing: CGPoint = CGPoint(x: 0, y: 0)
    
    init(){
        let texture = SKTexture(imageNamed: "nakedAnt_2")
        super.init(texture: texture, color: .clear, size: CGSize(width: 50, height: 50))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func walkBy(handlePosition: CGPoint, handleMiddlePosition: CGPoint) {
        //if !playerIsMoving {timer.invalidate(); return}
        if timerSet {timer.invalidate()}
        let vec = handlePosition - handleMiddlePosition
        let vecNormal = vec.normalized()

        timer = Timer.scheduledTimer(timeInterval: -1, target: self, selector: #selector(goingTo), userInfo: vecNormal, repeats: true)
        timerSet = true
    }
    
    @objc func goingTo(timer: Timer) {
        let vecNormal = timer.userInfo as! CGPoint
        
        self.position.x += vecNormal.x * moveDistance
        self.position.y += vecNormal.y * moveDistance
        
    }

    
    func stopWalk()  {
        timer.invalidate()
    }
    
    
}
