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
    var endHighscore : SKLabelNode!
    var highscoreName : SKLabelNode!
    var finalscoreLabel : SKLabelNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        scene?.scaleMode = .AspectFill
    
        mainMenuButton = childNodeWithName("mainMenuButton") as! MSButtonNode
        replayButton = childNodeWithName("replayButton") as! MSButtonNode
        endHighscore = childNodeWithName("endHighscore") as! SKLabelNode
        highscoreName = childNodeWithName("highscoreName") as! SKLabelNode
        finalscoreLabel = childNodeWithName("finalscoreLabel") as! SKLabelNode
        
        /* Replay Button to restart the game */
        replayButton.selectedHandler = {
            
            /* Reset the score to zero */
            highscore = 0

            let gameSceneTemp = GameScene(fileNamed: "GameScene")
            
            gameSceneTemp!.scaleMode = .AspectFill
            
            
            self.scene?.view?.presentScene(gameSceneTemp!, transition: SKTransition.fadeWithDuration(0.5))
            
            

       

        }

        
        mainMenuButton.selectedHandler = {
            /* Reset the score to zero */
            highscore = 0

            
            let gameSceneTemp = StartScene(fileNamed: "StartScene")
            
            gameSceneTemp!.scaleMode = .AspectFill
            
            self.scene?.view?.presentScene(gameSceneTemp!, transition: SKTransition.fadeWithDuration(0.5))
            
            
            
            

        }
        
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        


        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        if (highscore > newscore){
            newscore = highscore
        }
        
        /* Game Score Label */
        
        highscoreName.text = String(newscore)
        
        finalscoreLabel.text = String(highscore)
    
    }
}
