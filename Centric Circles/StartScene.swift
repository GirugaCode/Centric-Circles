//
//  GameScene.swift
//  Concentric Circles
//
//  Created by Danh Phu Nguyen on 7/11/16.
//  Copyright (c) 2016 Ryan Nguyen. All rights reserved.
//

import SpriteKit




class StartScene: SKScene {
    
    var startPlay : SKSpriteNode!
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        scene?.scaleMode = .AspectFill
        
        startPlay = childNodeWithName("startPlay") as! SKSpriteNode
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        let gameSceneTemp = GameScene(fileNamed: "GameScene")
        
        gameSceneTemp!.scaleMode = .AspectFill
        
        
        self.scene?.view?.presentScene(gameSceneTemp!, transition: SKTransition.fadeWithDuration(1))
        
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
