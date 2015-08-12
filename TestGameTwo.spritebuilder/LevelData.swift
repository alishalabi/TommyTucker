//
//  LevelData.swift
//  TestGameTwo
//
//  Created by Ali Shalabi on 8/12/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

struct LevelData {
    static var currentLevel: Int {
        get {
            let curLevel = NSUserDefaults.standardUserDefaults().integerForKey("currentLevel")
            if curLevel == 0 {
                return 1
            }
            return curLevel
        }
        set {
            NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: "currentLevel")
        }
    }
    
    static var currentScore: Int {
        get {
            let curScore = NSUserDefaults.standardUserDefaults().integerForKey("currentScore")
            return curScore
        }
        set {
            NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: "currentScore")
        }
    }
    
    static var currentLives: Int {
        get {
        let curLives = NSUserDefaults.standardUserDefaults().integerForKey("currentLives")
        return curLives
        }
        set {
            NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: "currentLives")
        }
    }
    
}