//
//  GameManager.swift
//  GameManager
//
//  Created by Martin Walsh on 26/07/2016.
//
//  Make sure to look in AppDelegate.swift

import Foundation

/* Define properties to be stored in NSUserDefaults */
extension DefaultsKeys {
    static let highScore = DefaultsKey<Int>("highScore")
}

class GameManager : CustomStringConvertible {
    
    /* Swift Singleton */
    static let sharedInstance = GameManager()
    
    /* Properties */
    var highScore = 0
    var newscore = 0

    
    /* Debug description */
    var description:String {
        return "High Score: \(highScore)"
    }
    
    private init() {
        /* Load stored data by default */
        print("GameManager: Initialised")
        loadData()

    }
    
    func saveData() {
        /* Store specified property data */
        print("GameManager: saveData")
        
        Defaults[.highScore] = highScore
        
        
        /* Debug */
        print(self)
    }
    
    func loadData() {
        /* Populate specified properties with stored data */
        print("GameManager: loadData")
        
        highScore = Defaults[.highScore]
        
        
        /* Debug */
        print(self)
    }
}