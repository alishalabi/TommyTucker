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
        LevelData.currentLevel == 1
        let mainScene = CCBReader.loadAsScene("MainScene")
        CCDirector.sharedDirector().presentScene(mainScene)
    }
    

}
