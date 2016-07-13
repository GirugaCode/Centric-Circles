//
//  GameScene.swift
//  Centric Circles
//
//  Created by Danh Phu Nguyen on 7/11/16.
//  Copyright (c) 2016 Ryan Nguyen. All rights reserved.
//

import SpriteKit

/* Universal Variable */
var highscore = 0

/* Game States */
enum GameState{
    case Title, Ready, Playing, Pause, GameOver
}

/* Game management */
var state: GameState = .Title

class GameScene: SKScene {
    
    var innerCircle : SKSpriteNode!
    var outerCircle : SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var isTouching  = true
    var index = 0
    
    var score: Int = highscore {
        didSet {
            scoreLabel.text = String(highscore)
        }
    }
    
    override func didMoveToView(view: SKView) {
        
        /* Setup your scene here */
        
        /* Code connection for the inner circle in GameScene */
        innerCircle = childNodeWithName("innerCircle") as! SKSpriteNode
        
        /* Code connection for the outer circle in GameScene */
        outerCircle = childNodeWithName("outerCircle") as! SKSpriteNode
        
        /* Code connection for the score label in GameScene */
        scoreLabel = childNodeWithName("scoreLabel") as! SKLabelNode
        
        scoreLabel.text = String(highscore)

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        isTouching = true
        let scale = SKAction.scaleTo(0.857, duration: 2)
    
        
        innerCircle.runAction(scale)
        

        
        
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        isTouching = false
        innerCircle.removeAllActions()
        
        
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        let reverseScale = SKAction.scaleTo(0.057, duration: 2)
        
        if innerCircle.xScale >= 0.82 {
            innerCircle.runAction(reverseScale)
            
        }
        
        /* If Statement for the condition of circle */
        if innerCircle.xScale > 0.61 && innerCircle.xScale < 0.725{
            
            scoreLabel.text = String(highscore)
            if isTouching == false {
                print("Win")

                print("Score +1")
                
                /* Game Score Label */
                
                score += 1
                highscore += 1
                
                
                /* Grab reference to the SpriteKit view */
                let skView = self.view as SKView!
                
                /* Load Game scene */
                let scene = GameScene(fileNamed:"GameScene") as GameScene!
                
                /* Ensure correct aspect mode */
                scene.scaleMode = .AspectFill
                
                /* Restart GameScene */
                skView.presentScene(scene)
                

            }
        }
        
        else if innerCircle.xScale < 0.058{
            print("Start")
            
        }
        
        else {
            if isTouching == false {
                print("Lose")
                
                /* Grab reference to the SpriteKit view */
                let skView = self.view as SKView!
                
                /* Load Game scene */
                let scene = GameScene(fileNamed:"GameScene") as GameScene!
                
                /* Ensure correct aspect mode */
                scene.scaleMode = .AspectFill
                
                /* Restart GameScene */
                skView.presentScene(scene)
                

            }
            
        }
    }
    
    
}
