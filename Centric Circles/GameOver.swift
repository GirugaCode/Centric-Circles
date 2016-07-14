//
//  GameScene.swift
//  Concentric Circles
//
//  Created by Danh Phu Nguyen on 7/11/16.
//  Copyright (c) 2016 Ryan Nguyen. All rights reserved.
//

import SpriteKit




class GameOver: SKScene {
    
    var mainMenuButton : MSButtonNode!
    var replayButton : MSButtonNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        scene?.scaleMode = .AspectFill
    
        mainMenuButton = childNodeWithName("mainMenuButton") as! MSButtonNode
        replayButton = childNodeWithName("replayButton") as! MSButtonNode
        
        /* Replay Button to restart the game */
        replayButton.selectedHandler = {
            
            let gameSceneTemp = GameScene(fileNamed: "GameScene")
            
            gameSceneTemp!.scaleMode = .AspectFill
            
            
            self.scene?.view?.presentScene(gameSceneTemp!, transition: SKTransition.fadeWithDuration(1))
        }
        /* Reset the score to zero */
            highscore = 0
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        


        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
