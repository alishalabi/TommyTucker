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
}