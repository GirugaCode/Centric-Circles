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
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        scene?.scaleMode = .AspectFill
        
        startPlay = childNodeWithName("startPlay") as! SKSpriteNode
        startBackground = childNodeWithName("startBackground") as! SKSpriteNode
        
        startBackgroundGradient()
        

        
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
        let gradient = SKTexture(size: size, color1: CIColor(red: 14/255.0, green: 48/255.0, blue: 94/255.0), color2: CIColor(red: 44/255.0, green: 130/255.0, blue: 189/255.0), direction: .up)
        startBackground.runAction(SKAction.setTexture(gradient))
    
    }
}
