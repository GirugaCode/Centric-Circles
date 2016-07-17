//
//  GameScene.swift
//  testerrr
//
//  Created by Danh Phu Nguyen on 7/7/16.
//  Copyright (c) 2016 Ryan Nguyen. All rights reserved.
//

import SpriteKit

class colors {
    var gameBackgroundColor : UIColor! = UIColor.blackColor()
    var innerCircleColor : UIColor! = UIColor.whiteColor()
    var outerCircleColor : UIColor! = UIColor.redColor()
    static var color = colors()
    
    func changecolors(){
        gameBackgroundColor = randomColor()
        innerCircleColor = randomColor()
        outerCircleColor = randomColor()
    }
    
    func randomColor() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
        
    }
}

class ColorChange: SKScene {
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
    
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        
        
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
