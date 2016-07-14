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
    
    var gameBackground : SKSpriteNode!
    var innerCircle : SKSpriteNode!
    var outerCircle : SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var isTouching  = true
    /* Randomizer for the outer circle */
    let randomnum = CGFloat.random() % 0.423 + 0.2
    
    /* Variable for the score system in GameScene */
    var score: Int = highscore {
        didSet {
            scoreLabel.text = String(highscore)
        }
    }
    
    override func didMoveToView(view: SKView) {
        
        /* Setup your scene here */
        
        /* Code connection for the background in GameScene */
        gameBackground = childNodeWithName("gameBackground") as! SKSpriteNode
        /* Code connection for the inner circle in GameScene */
        innerCircle = childNodeWithName("innerCircle") as! SKSpriteNode
        
        /* Code connection for the outer circle in GameScene */
        outerCircle = childNodeWithName("outerCircle") as! SKSpriteNode
        
        /* Code connection for the score label in GameScene */
        scoreLabel = childNodeWithName("scoreLabel") as! SKLabelNode
        
        /* Connects to my highscore string (make sure it was after the scoreLabel code connection) */
        scoreLabel.text = String(highscore)
        
        
        
        /* Randomizes the scale of the outerCircle */
        outerCircle.xScale = randomnum
        outerCircle.yScale = randomnum

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        
        isTouching = true
        /* Scales out the inner circle to reach the outer circle */
        
        let scale = SKAction.scaleTo(0.82, duration: 2)
        
        /* Initiates the action */
        innerCircle.runAction(scale)
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        /* Stops the inner circle from moving if there is no touch */
        isTouching = false
        

        
        innerCircle.removeAllActions()
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        
        /* Retracts the circle if it hits a certain scale of the screen */
        let reverseScale = SKAction.scaleTo(0.057, duration: 2)
        
        if innerCircle.xScale >= 0.75 {
            innerCircle.runAction(reverseScale)
            
        }
        
        /* If Statement if the inner circle hits the outer circle in any of it random position */
        if innerCircle.xScale > randomnum - 0.05 && innerCircle.xScale < randomnum + 0.05{
            
            scoreLabel.text = String(highscore)
            if isTouching == false {
                print("Win")

                print("Score +1")
                
                /* Game Score Label */
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
            /* The start position of the inner circle */
        else if innerCircle.xScale < 0.058{
            print("Start")
            
        }
            /* if the inner circle hits any other area, this will be the fail state */
        else {
            if isTouching == false {
                print("Lose")
                
                /* Load the shake action resource */
                let shakeScene:SKAction = SKAction.init(named: "Shake")!
                
                /* Loop through all nodes  */
                for node in self.children {
                    
                    /* Apply effect each ground node */
                    node.runAction(shakeScene)
                
                }
                
                
                removeAllActions()
                
                /* Transitions into GameOver if fail state happens */
                
                let gameSceneTemp = GameOver(fileNamed: "GameOver")
                
                gameSceneTemp!.scaleMode = .AspectFill
                
                
                self.scene?.view?.presentScene(gameSceneTemp!, transition: SKTransition.crossFadeWithDuration(1.2))
                
               
                
                
                
//                /* Grab reference to the SpriteKit view */
//                let skView = self.view as SKView!
//                
//                /* Load Game scene */
//                let scene = GameScene(fileNamed:"GameScene") as GameScene!
//                
//                /* Ensure correct aspect mode */
//                scene.scaleMode = .AspectFill
//                
//                /* Restart GameScene */
//                skView.presentScene(scene)
                

            }
            
        }
    }
    
    
}
