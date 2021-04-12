//
//  Box.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/4.
//

import Foundation
import SpriteKit

class Box: SKSpriteNode {
    
    var selectHandler: () -> Void = {print("box touch not implemented!")}
    var isOpen = false
    var boxSize = CGSize(width: 30, height: 20)
    var boxIsSet = false
    init(){
        let texture = SKTexture(imageNamed: "box_1")
        super.init(texture: texture, color: .clear, size: boxSize)
        self.zPosition = 1
        self.isUserInteractionEnabled = true
        self.physicsBody = SKPhysicsBody(rectangleOf: boxSize)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.pinned = true
        self.name = "box"
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func open()  {
        self.run(SKAction(named: "boxOpen")!)
    }
    
    func close()  {
        self.run(SKAction(named: "boxClose")!)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectHandler()
    }
}
