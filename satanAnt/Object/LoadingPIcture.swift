//
//  LoadingPIcture.swift
//  satanAnt
//
//  Created by 劉孟學 on 2021/4/22.
//

import Foundation
import SpriteKit

class LoadingPicture: SKSpriteNode {
    
    var loadScene: SKScene!
    
    
    init(){
        
        let texture = SKTexture(imageNamed: "loadScene")
        super.init(texture: texture, color: .clear, size: CGSize(width: 667, height: 375))
        self.zPosition = 2000
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.position = CGPoint(x: 0, y: 0)
        self.name = "loadingPicture"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func autoRemove()  {
        
    }
}
