//
//  GameScene.swift
//  Concentric Circles
//
//  Created by Danh Phu Nguyen on 7/11/16.
//  Copyright (c) 2016 Ryan Nguyen. All rights reserved.
//

import SpriteKit




class GameOver: SKScene {
    
    let gameManager = GameManager.sharedInstance
    
    var mainMenuButton : MSButtonNode!
    var replayButton : MSButtonNode!
    var endHighscore : SKLabelNode!
    var highscoreName : SKLabelNode!
    var finalscoreLabel : SKLabelNode!
    var gameBackground : SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        scene?.scaleMode = .AspectFill
    
        mainMenuButton = childNodeWithName("mainMenuButton") as! MSButtonNode
        replayButton = childNodeWithName("replayButton") as! MSButtonNode
        endHighscore = childNodeWithName("endHighscore") as! SKLabelNode
        highscoreName = childNodeWithName("highscoreName") as! SKLabelNode
        finalscoreLabel = childNodeWithName("finalscoreLabel") as! SKLabelNode
        gameBackground = childNodeWithName("gameBackground") as! SKSpriteNode
        
        
        /* Advertisment */
        Chartboost.showInterstitial(CBLocationHomeScreen)
        
        /* Has the functions of the GameOver Buttons and resets the score */
        buttonFunctions()
        
        /* Gardient Background */
        startBackgroundGradient()

    
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        


        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        scoreRuling()
        
    }
    
    
    func scoreRuling() {
        if (gameManager.highScore < gameManager.newscore){
            gameManager.highScore = gameManager.newscore
        }
        
        /* Game Score Label */
        
        highscoreName.text = String(gameManager.newscore)
        
        finalscoreLabel.text = String(gameManager.highScore)
        
        
        }
    
    func buttonFunctions() {
    
        /* Replay Button to restart the game */
        replayButton.selectedHandler = {
            
            /* Reset the score to zero */
            self.gameManager.newscore = 0
            
            let gameSceneTemp = GameScene(fileNamed: "GameScene")
            
            gameSceneTemp!.scaleMode = .AspectFill
            
            
            self.scene?.view?.presentScene(gameSceneTemp!, transition: SKTransition.fadeWithDuration(0.5))
            
        }
        
        mainMenuButton.selectedHandler = {
            /* Reset the score to zero */
            self.gameManager.newscore = 0
            
            
            let gameSceneTemp = StartScene(fileNamed: "StartScene")
            
            gameSceneTemp!.scaleMode = .AspectFill
            
            self.scene?.view?.presentScene(gameSceneTemp!, transition: SKTransition.fadeWithDuration(0.5))
            
            
        }
    }
    
    func startBackgroundGradient() {
        /* Background radient */
        let gradient = SKTexture(size: size, color1: CIColor(red: 14/255.0, green: 48/255.0, blue: 94/255.0), color2: CIColor(red: 44/255.0, green: 130/255.0, blue: 189/255.0), direction: .up)
        gameBackground.runAction(SKAction.setTexture(gradient))
        
    }
    
    
}
