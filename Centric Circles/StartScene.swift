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
    var startBackground : SKSpriteNode!
    var taptoplayLabel : SKLabelNode!

    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        scene?.scaleMode = .AspectFill
        
        //startPlay = childNodeWithName("startPlay") as! SKSpriteNode
        startBackground = childNodeWithName("startBackground") as! SKSpriteNode
        taptoplayLabel = childNodeWithName("taptoplayLabel") as! SKLabelNode
        
        
        startBackgroundGradient()
        
        let animateList = SKAction.sequence([SKAction.fadeInWithDuration(0.5), SKAction.waitForDuration(0.2), SKAction.fadeOutWithDuration(0.5)])
        taptoplayLabel.runAction(SKAction.repeatActionForever(animateList))
        
    

        
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
    
    
    func startBackgroundGradient() {
        /* Background radient */
        let gradient = SKTexture(size: size, color1: CIColor(red: 233/255.0, green: 78/255.0, blue: 119/255.0), color2: CIColor(red: 198/255.0, green: 164/255.0, blue: 154/255.0), direction: .up)
        startBackground.runAction(SKAction.setTexture(gradient))
    
    }
}
