//
//  GameScene.swift
//  Cloud Circles
//
//  Created by Danh Phu Nguyen on 7/22/16.
//  Copyright (c) 2016 Ryan Nguyen. All rights reserved.
//

import SpriteKit

/* Universal Variable */
var highscore = 0
var newscore = 0
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
    var isTouching = true
    var hasRandomizedColor = false
    var innerCircleColor = UIColor.grayColor()
    var outerCircleColor = UIColor.whiteColor()
    
    
    /* Randomizer for the outer circle */
    var randomnum = CGFloat.random() % 0.423 + 0.2
    
    /* Variable for the score system in GameScene */
    var score: Int = highscore {
        didSet {
            scoreLabel.text = String(highscore)
        }
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        

        
        setupCircles()
        
        gameBackground = childNodeWithName("gameBackground") as! SKSpriteNode
        
        /* Code connection for the score label in GameScene */
        scoreLabel = childNodeWithName("scoreLabel") as! SKLabelNode
        
        /* Connects to my highscore string (make sure it was after the scoreLabel code connection) */
        scoreLabel.text = String(highscore)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        state = .Playing
        
        isTouching = true
        
        scaleOut()

        
    }
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        /* Stops the inner circle from moving if there is no touch */
        isTouching = false
        
        innerCircle.removeAllActions()
        
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        /* Retract circle */
        reverseScale()
        
        /* Condidtion of the color relating to score */
        Colorruling()
        
        /* If Statement if the inner circle hits the outer circle in any of it random position */
        if innerCircle.xScale > randomnum - 0.05 && innerCircle.xScale < randomnum + 0.05 {
            if isTouching == false{
                    resetNodes()
            }
        }
        
        else if innerCircle.xScale < 0.058 {
            print("Start")
        }
        
        else {
            if isTouching == false {
                print("Lose")
                transitionToGameOver()
            }
        }
        
    }
    
    func scaleOut() {
        /* Scales out the inner circle to reach the outer circle */
        let scale = SKAction.scaleTo(0.82, duration: 1.5)
        
        /* Initiates the action */
        innerCircle.runAction(scale)
    
    }
    
    
    func reverseScale() {
        /* Retracts the circle if it hits a certain scale of the screen */
        let reverseScale = SKAction.scaleTo(0.057, duration: 2)
        
        if innerCircle.xScale >= 0.75 {
            innerCircle.runAction(reverseScale)
            
        }
    }
    
    func resetNodes() {
        /* Game Score Label */
        highscore += 1
        hasRandomizedColor = false
        scoreLabel.text = String(highscore)
        
        let actionSound = SKAction.playSoundFileNamed("actionSound.mp3", waitForCompletion: false)
        runAction(actionSound)
        
        innerCircle.removeFromParent()
        outerCircle.removeFromParent()
        
        setupCircles()
    
    }
    
    func setupCircles() {
        innerCircle = SKSpriteNode(imageNamed: "insideCircle")
        innerCircle.zPosition = 2
        innerCircle.position = CGPoint(x:161.029,y:283.42)
        innerCircle.setScale(0.054)
        innerCircle.color = innerCircleColor
        innerCircle.colorBlendFactor = 1
        addChild(innerCircle)
        
        outerCircle = SKSpriteNode(imageNamed: "outsideCircle")
        outerCircle.zPosition = 1
        outerCircle.position = CGPoint(x:161.029,y:283.42)
        randomnum = CGFloat.random() % 0.423 + 0.2
        outerCircle.setScale(randomnum)
        outerCircle.color = outerCircleColor
        outerCircle.colorBlendFactor = 1
        
        addChild(outerCircle)
        
    }
    
    func randomColor() -> UIColor {
    
        return UIColor (red:   .random(),
                        green: .random(),
                        blue:  .random(),
                        alpha: 1.0)
        }
    
    
    func Colorruling() {
        if (highscore%10 == 0 && highscore != 1) && !hasRandomizedColor {
            innerCircleColor = randomColor()
            outerCircleColor = randomColor()
            gameBackground.color = randomColor()
            hasRandomizedColor = true
            innerCircle.color = innerCircleColor
            outerCircle.color = outerCircleColor
        }
    }
    
    func transitionToGameOver() {
        /* Transitions into GameOver if fail state happens */
        
        let gameSceneTemp = GameOver(fileNamed: "GameOver")
        gameSceneTemp!.scaleMode = .AspectFill
        self.scene?.view?.presentScene(gameSceneTemp!, transition: SKTransition.crossFadeWithDuration(1))
    
    }
    
}
