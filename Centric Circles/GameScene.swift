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
    var invisibleCircle : SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var isTouching = true
    var hasRandomizedColor = false
    var gameOverRunned = false
    var innerCircleColor = UIColor.grayColor()
    var outerCircleColor = UIColor.whiteColor()
    
    
    
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
        setupCircles()
        
        gameBackground = childNodeWithName("gameBackground") as! SKSpriteNode
        
        /* Code connection for the score label in GameScene */
        scoreLabel = childNodeWithName("scoreLabel") as! SKLabelNode
        
        /* Connects to my highscore string (make sure it was after the scoreLabel code connection) */
        scoreLabel.text = String(gameManager.newscore)
        
        
        
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
        
        if innerCircle.xScale >= 0.75 {
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
    
    
    func colorRuling() {
        if (gameManager.newscore%10 == 0 && gameManager.newscore != 1) && !hasRandomizedColor {
            innerCircleColor = randomColor()
            outerCircleColor = randomColor()
            gameBackground.color = randomColor()
            hasRandomizedColor = true
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
//            let stopParticles = SKAction.removeFromParent()
//            particles?.runAction(stopParticles)
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
        gameBackground.color = .redColor()
        
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
        gameSceneTemp!.scaleMode = .AspectFill
        self.view!.presentScene(gameSceneTemp!, transition: SKTransition.crossFadeWithDuration(1))
    
    }
    
}
