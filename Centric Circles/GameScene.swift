//
//  GameScene.swift
//  Cloud Circles
//
//  Created by Danh Phu Nguyen on 7/22/16.
//  Copyright (c) 2016 Ryan Nguyen. All rights reserved.
//

import SpriteKit
import UIKit
import AudioToolbox
import ChameleonFramework

/* Game States */
enum GameState{
    case Title, Ready, Playing, Pause, GameOver
}


/* Game management */
var state: GameState = .Title


class GameScene: SKScene {
    
    let gameManager = GameManager.sharedInstance
    
    var gameBackground : SKSpriteNode!
    var innerCircle : SKSpriteNode!
    var outerCircle : SKSpriteNode!
    var instructions: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var isTouching = true
    var hasRandomizedColor = false
    var gameOverRunned = false
    var innerCircleColor = UIColor.grayColor()
    var outerCircleColor = UIColor.whiteColor()
    var challengeLabelOne: SKLabelNode!
    var challengeLabelTwo: SKLabelNode!
    var challengeLabelThree: SKLabelNode!
    
    
    /* Randomizer for the outer circle */
    var randomnum = CGFloat.random() % 0.423 + 0.2
    
    /* Variable for the score system in GameScene */
    var score: Int = 0 {
        didSet {
            scoreLabel.text = String(gameManager.newscore)
        }
    }
    
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        state = .Playing
        
        /* Spawns the two circles */
        setupCircles()
    
        /* Code connects the background */
        gameBackground = childNodeWithName("gameBackground") as! SKSpriteNode
        
        instructions = childNodeWithName("instructions") as! SKSpriteNode
        
        /* Code connection for the score label in GameScene */
        scoreLabel = childNodeWithName("scoreLabel") as! SKLabelNode
        
        /* Connects to my highscore string (make sure it was after the scoreLabel code connection) */
        scoreLabel.text = String(gameManager.newscore)
        
        challengeLabelOne = childNodeWithName("challengeLabelOne") as! SKLabelNode
        challengeLabelTwo = childNodeWithName("challengeLabelTwo") as! SKLabelNode
        challengeLabelThree = childNodeWithName("challengeLabelThree") as! SKLabelNode
        
        /* Instruction animation */
        animations()

        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        if state != .GameOver {
            state = .Playing
            
            isTouching = true
            
            scaleOut()
        }
        
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
        colorRuling()
        
        /* The instructions of the game "Hold and Release" */
        instructionsOfGame()
        
        /* If Statement if the inner circle hits the outer circle in any of it random position */
        if innerCircle.xScale > randomnum - 0.05 && innerCircle.xScale < randomnum + 0.05 {
            if isTouching == false{
                    resetNodes()
                    soundRuling()
            }
        }
        
        else if innerCircle.xScale < 0.058 {
            //print("Start")
        }
        
        else {
            if isTouching == false && gameOverRunned == false {
                print("Lose")
                gameOverSequence()
                gameOverRunned = true
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
        let reverseScale = SKAction.scaleTo(0.057, duration: 1.5)
        
        if innerCircle.xScale >= 0.76 {
            innerCircle.runAction(reverseScale)
            
        }
    }
    
    func resetNodes() {
        /* Game Score Label */
        gameManager.newscore += 1
        
        hasRandomizedColor = false
        scoreLabel.text = String(gameManager.newscore)
        
        innerCircle.removeFromParent()
        outerCircle.removeFromParent()
        
        setupCircles()
        

    
    }
    
    func setupCircles() {
        innerCircle = SKSpriteNode(imageNamed: "insideCircle")
        innerCircle.zPosition = 2
        innerCircle.position = CGPoint(x:0,y:-0)
        innerCircle.setScale(0.054)
        innerCircle.color = innerCircleColor
        innerCircle.anchorPoint = CGPoint((x:CGFloat(0.5), y:CGFloat(0.5)))
        innerCircle.colorBlendFactor = 1
        addChild(innerCircle)
        
        
        outerCircle = SKSpriteNode(imageNamed: "outsideCircle")
        outerCircle.zPosition = 1
        outerCircle.position = CGPoint(x:0,y:-0)
        randomnum = CGFloat.random() % 0.423 + 0.2
        outerCircle.setScale(randomnum)
        outerCircle.color = outerCircleColor
        outerCircle.anchorPoint = CGPoint((x:CGFloat(0.5), y:CGFloat(0.5)))
        outerCircle.colorBlendFactor = 1
        addChild(outerCircle)
        
    }
    
    
    
    func colorRuling() {
        if (gameManager.newscore%10 == 0 && gameManager.newscore != 1) && !hasRandomizedColor {
            
            /* Random flat color generator */
            
            outerCircleColor = RandomFlatColorWithShade(.Light)
            
            innerCircleColor = RandomFlatColorWithShade(.Light)
            
            gameBackground.color = RandomFlatColorWithShade(.Dark)
            //ContrastColorOf(innerCircleColor, returnFlat: true)
            
            if innerCircleColor == outerCircleColor {
                innerCircleColor = RandomFlatColor()
                outerCircleColor = RandomFlatColor()
            }
            
            /* Checking if colors have changed */
            hasRandomizedColor = true
            
            /* Making inner circle and outer circle into .color properties */
            innerCircle.color = innerCircleColor
            outerCircle.color = outerCircleColor

            

            
            
        }
    }

    

    
    func soundRuling() {
        
        
        let arrayCounter = String(gameManager.newscore).characters.map {Int(String($0))!}

        let lastnumber = arrayCounter.last
        
        if lastnumber == 1 {
            let actionSoundOne = SKAction.playSoundFileNamed("soundOne.caf", waitForCompletion: false)
                runAction(actionSoundOne)
            
            let particles = SKEmitterNode(fileNamed:"pointParticle.sks")
            innerCircle.addChild(particles!)

        }
        
        else if lastnumber == 2 {
            let actionSoundTwo = SKAction.playSoundFileNamed("soundTwo.caf", waitForCompletion: false)
                runAction(actionSoundTwo)
            let particles = SKEmitterNode(fileNamed:"pointParticle.sks")
            innerCircle.addChild(particles!)
        }
        
        else if lastnumber == 3 {
            let actionSoundThree = SKAction.playSoundFileNamed("soundThree.caf", waitForCompletion: false)
            runAction(actionSoundThree)
            let particles = SKEmitterNode(fileNamed:"pointParticle.sks")
            innerCircle.addChild(particles!)
        }
        
        else if lastnumber == 4 {
            let actionSoundFour = SKAction.playSoundFileNamed("soundFour.caf", waitForCompletion: false)
            runAction(actionSoundFour)
            let particles = SKEmitterNode(fileNamed:"pointParticle.sks")
            innerCircle.addChild(particles!)
        }
        
        else if lastnumber == 5 {
            let actionSoundFive = SKAction.playSoundFileNamed("soundFive.caf", waitForCompletion: false)
            runAction(actionSoundFive)
            let particles = SKEmitterNode(fileNamed:"pointParticle.sks")
            innerCircle.addChild(particles!)
        }
        
        else if lastnumber == 6 {
            let actionSoundSix = SKAction.playSoundFileNamed("soundSix.caf", waitForCompletion: false)
            runAction(actionSoundSix)
            let particles = SKEmitterNode(fileNamed:"pointParticle.sks")
            innerCircle.addChild(particles!)
        }
        
        else if lastnumber == 7 {
            let actionSoundSeven = SKAction.playSoundFileNamed("soundSeven.caf", waitForCompletion: false)
            runAction(actionSoundSeven)
            let particles = SKEmitterNode(fileNamed:"pointParticle.sks")
            innerCircle.addChild(particles!)
        }
        
        else if lastnumber == 8 {
            let actionSoundEight = SKAction.playSoundFileNamed("soundEight.caf", waitForCompletion: false)
            runAction(actionSoundEight)
            let particles = SKEmitterNode(fileNamed:"pointParticle.sks")
            innerCircle.addChild(particles!)
        }
        
        else if lastnumber == 9 {
            let actionSoundNine = SKAction.playSoundFileNamed("soundNine.caf", waitForCompletion: false)
            runAction(actionSoundNine)
            let particles = SKEmitterNode(fileNamed:"pointParticle.sks")
            innerCircle.addChild(particles!)
        }
        
        else if lastnumber == 0 {
            let actionSoundTen = SKAction.playSoundFileNamed("soundTen.caf", waitForCompletion: false)
            runAction(actionSoundTen)
            
            
            let particles = SKEmitterNode(fileNamed:"scoreParticle.sks")
            
            outerCircle.addChild(particles!)
            

            
        }
    }
    
    func gameOverSequence() {
        

        
        /* remove all action */
        state = .GameOver
        
        /* Change background color Red */
        gameBackground.color = UIColor.redColor()
        
            
        //UIColor(red:204/255, green: 65/255, blue: 101/255, alpha: 1.0)
        
        /* Losing sound */
        let losingSound = SKAction.playSoundFileNamed("overSound.mp3", waitForCompletion: true)
        /* Vibrate */
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        /*Delay this code*/
        let blockCode = SKAction.runBlock({
            self.transitionToGameOver()
        })
        let sequence = SKAction.sequence([losingSound,blockCode])
        self.runAction(sequence)
    
    }
    
    func transitionToGameOver() {
        /* Transitions into GameOver if fail state happens */
        let gameSceneTemp = GameOver(fileNamed: "GameOver")
        gameSceneTemp!.scaleMode = .AspectFit
        self.view!.presentScene(gameSceneTemp!, transition: SKTransition.revealWithDirection(SKTransitionDirection.Left, duration: 0.4))
    
    }
    
    func instructionsOfGame () {
        
        if gameManager.newscore <= 0 {
            instructions.zPosition = 3
        }
        else {
            instructions.zPosition = -2
        }
    }
    
    func animations () {
        
        /* Animations for the instructions at the beginning of the game */
        let animateList = SKAction.sequence([SKAction.fadeInWithDuration(0.5), SKAction.waitForDuration(0.2), SKAction.fadeOutWithDuration(0.5)])
        instructions.runAction(SKAction.repeatActionForever(animateList))
        
    
    }
    
    
}
