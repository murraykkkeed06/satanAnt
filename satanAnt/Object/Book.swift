//
//  Book.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/4.
//

import Foundation
import SpriteKit

class Book: SKSpriteNode {
    
    var selectHandler: ()->Void = {print("book touch not implemented!")}
    
    init(){
        let texture = SKTexture(imageNamed: "book_1")
        super.init(texture: texture, color: .clear, size: CGSize(width: 20, height: 30))
        self.isUserInteractionEnabled = true
        self.zPosition = 2
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func open()  {
        self.run(SKAction(named: "bookOpen")!)
        self.run(SKAction.resize(toWidth: 40, duration: 1))
    }
    func close()  {
        self.run(SKAction(named: "bookClose")!)
        self.run(SKAction.resize(toWidth: 20, duration: 1))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectHandler()
    }
}
