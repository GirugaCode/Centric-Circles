//
//  GameScene.swift
//  Concentric Circles
//
//  Created by Danh Phu Nguyen on 7/11/16.
//  Copyright (c) 2016 Ryan Nguyen. All rights reserved.
//

import SpriteKit




class StartScene: SKScene{
    
    var startPlay : SKSpriteNode!
    var startBackground : SKSpriteNode!
    var playIcon : SKSpriteNode!
    var startDesign : SKSpriteNode!

    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        scene?.scaleMode = .AspectFit
        
        //startPlay = childNodeWithName("startPlay") as! SKSpriteNode
        startBackground = childNodeWithName("startBackground") as! SKSpriteNode
        playIcon = childNodeWithName("playIcon") as! SKSpriteNode
        startDesign = childNodeWithName("startDesign") as! SKSpriteNode
        
        
        let animateList = SKAction.sequence([SKAction.fadeInWithDuration(0.5), SKAction.waitForDuration(0.2), SKAction.fadeOutWithDuration(0.5)])
        startDesign.runAction(SKAction.repeatActionForever(animateList))
        
    

        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        let gameSceneTemp = GameScene(fileNamed: "GameScene")
        
        gameSceneTemp!.scaleMode = .AspectFit
        
        self.scene?.view?.presentScene(gameSceneTemp!, transition: SKTransition.fadeWithDuration(1))
        
        let startSound = SKAction.playSoundFileNamed("startSound.caf", waitForCompletion: false)
        runAction(startSound)
        
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    
    
}
