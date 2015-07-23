//
//  TitleScreen.swift
//  TestGameTwo
//
//  Created by Ali Shalabi on 7/23/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class TitleScreen: CCNode {
    
    func newGame() {
        let mainScene = CCBReader.loadAsScene("MainScene")
        CCDirector.sharedDirector().presentScene(mainScene)
    }
    
    func continueGame() {
        let mainScene = CCBReader.loadAsScene("MainScene")
        CCDirector.sharedDirector().presentScene(mainScene)
    }

}
