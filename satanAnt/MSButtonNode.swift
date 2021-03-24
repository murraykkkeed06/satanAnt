//
//  MSButtonNode.swift
//  PeeevedPenguins
//
//  Created by mitchell hudson on 5/23/17.
//  Copyright © 2017 Mitchell Hudson. All rights reserved.
//

import SpriteKit

enum ButtonState {
    case show
    case hide
}

class MSButtonNode: SKSpriteNode {
    
    
    /* Setup a dummy action closure */
    var selectedHandler: () -> Void = { print("No button action set") }
   
    private var _buttonState: ButtonState!
    var buttonState: ButtonState{
        get{
            return _buttonState
        }
        set{
            _buttonState = newValue
        }
    }
    /* Support for NSKeyedArchiver (loading objects from SK Scene Editor */
    required init?(coder aDecoder: NSCoder) {
        
        /* Call parent initializer e.g. SKSpriteNode */
        super.init(coder: aDecoder)
        
        self.buttonState = .show
        
        /* Enable touch on button node */
        self.isUserInteractionEnabled = true
    }
    
    // MARK: - Touch handling
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectedHandler()
        
    }
    
}
