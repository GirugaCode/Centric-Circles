//
//  GameScene.swift
//  Concentric Circles
//
//  Created by Danh Phu Nguyen on 7/11/16.
//  Copyright (c) 2016 Ryan Nguyen. All rights reserved.
//

import SpriteKit
import GameKit



class GameOver: SKScene, GKGameCenterControllerDelegate {
    
    let gameManager = GameManager.sharedInstance
    
    var mainMenuButton : MSButtonNode!
    var replayButton : MSButtonNode!
    var gameCenterButton : MSButtonNode!
    var endHighscore : SKSpriteNode!
    var highscoreName : SKLabelNode!
    var finalscoreLabel : SKLabelNode!
    var gameBackground : SKSpriteNode!
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        scene?.scaleMode = .AspectFit
    
        mainMenuButton = childNodeWithName("mainMenuButton") as! MSButtonNode
        replayButton = childNodeWithName("replayButton") as! MSButtonNode
        gameCenterButton = childNodeWithName("gameCenterButton") as! MSButtonNode
        endHighscore = childNodeWithName("endHighscore") as! SKSpriteNode
        highscoreName = childNodeWithName("highscoreName") as! SKLabelNode
        finalscoreLabel = childNodeWithName("finalscoreLabel") as! SKLabelNode
        gameBackground = childNodeWithName("gameBackground") as! SKSpriteNode
        
        
        /* Advertisment */
        Chartboost.showInterstitial(CBLocationHomeScreen)
        
        /* Has the functions of the GameOver Buttons and resets the score */
        buttonFunctions()
        


    
        
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
            
            gameSceneTemp!.scaleMode = .AspectFit
            
            
            self.scene?.view?.presentScene(gameSceneTemp!, transition: SKTransition.fadeWithDuration(0.5))
            
        }
        
        mainMenuButton.selectedHandler = {
            /* Reset the score to zero */
            self.gameManager.newscore = 0
            
            
            let gameSceneTemp = StartScene(fileNamed: "StartScene")
            
            gameSceneTemp!.scaleMode = .AspectFit
            
            self.scene?.view?.presentScene(gameSceneTemp!, transition: SKTransition.fadeWithDuration(0.5))
            
            
        }
        gameCenterButton.selectedHandler = {
            self.CallGC()
            self.showLeaderBoard()
        }
    }
    
    func startBackgroundGradient() {
        /* Background radient */
        let gradient = SKTexture(size: size, color1: CIColor(red: 14/255.0, green: 48/255.0, blue: 94/255.0), color2: CIColor(red: 44/255.0, green: 130/255.0, blue: 189/255.0), direction: .up)
        gameBackground.runAction(SKAction.setTexture(gradient))
        
    }
    
    func saveHighscore (number : Int) {
        if GKLocalPlayer.localPlayer().authenticated{
            let scoreReporter = GKScore(leaderboardIdentifier: "CirclesLB")
            
            scoreReporter.value = Int64(number)
            
            let scoreArray : [GKScore] = [scoreReporter]
            
            GKScore.reportScores(scoreArray, withCompletionHandler: nil)
        }
    }
    
    func CallGC() {
        saveHighscore(gameManager.highScore)
        
    }
    
    func showLeaderBoard() {
        let viewController = self.view!.window?.rootViewController
        let gcvc = GKGameCenterViewController()
        
        gcvc.gameCenterDelegate = self
        
        viewController?.presentViewController(gcvc, animated: true, completion: nil)
    
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
