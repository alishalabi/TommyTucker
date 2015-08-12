//
//  TransitionScreen.swift
//  TestGameTwo
//
//  Created by Ali Shalabi on 8/12/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class TransitionScreen: CCNode {
    
    func transition() {
        let mainScene = CCBReader.loadAsScene("MainScene")
        CCDirector.sharedDirector().presentScene(mainScene)
    }
    
    
}