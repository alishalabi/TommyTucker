import Foundation

class MainScene: CCNode, CCPhysicsCollisionDelegate {
    
    // Declare Doc Root Variables for basic scrolling
    weak var champion: CCSprite!
    weak var scrollingPhysicsNode: CCPhysicsNode!
    
    // Declare Doc Root Variables for endless scrolling
    weak var lowerFloor: CCSprite!
    var lowerFloors = [CCSprite]()
    
    weak var upperFloor: CCSprite!
    var upperFloors = [CCSprite]()
    
    weak var mountain1: CCSprite!
    weak var mountain2: CCSprite!
    var mountains = [CCSprite]()
    
    // Declare Doc Root Variables for restart
    weak var restartButton : CCButton!
    var gameOver = false
    
    // Declare enemy array
    var enemies: [CCNode] = []
    let firstEnemyPosition: CGFloat = 300
    let distanceBetweenEnemies: CGFloat = 800
    
    // Declare coin array
    var coins : [CCNode] = []
    let firstCoinPosition : CGFloat = 140
    let distanceBetweenCoins : CGFloat = 100
    
    // Declare score array
    var scoreTotal: NSInteger = 0
    weak var scoreTally: CCLabelTTF!
    
    
    // Declare touch handler Boolean
    var isTouching = false
    
    
    // Declare scroll speed
    var scrollingRate: CGFloat = 160
    
    // Declare didLoadFrom
    func didLoadFromCCB() {
        // Allow user interaction
        userInteractionEnabled = true
        
        // Append arrays for endless scrolling
        mountains.append(mountain1)
        mountains.append(mountain2)
        
        // Assign collision delegate class
        scrollingPhysicsNode.collisionDelegate = self
        
        // Automatically spawn 3 obstacles
        for i in 0...2 {
            spawnEnemy()
        }
        
        // Automaticall spawn 10 coins
        for i in 0...9 {
            spawnCoin()
        }
    }
    
    // Implement collision handler method with enemy, make restart visible
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, champion: CCNode!, gameOver: CCNode!) -> Bool {
        endGame()
        return true
    }
    
    //    // Implement collision with Boundary Box
    //    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, champion: CCNode!, scrollingPhysicsNode: CCNode!) -> Bool {
    //        isTouching == false
    //        return true
    //    }
    
    // Implement collision handler method with coin
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, champion: CCNode!, score: CCNode!) -> Bool {
        
        // Remove coin (included: debug feature)
        if score != nil && score.parent != nil {
            score.removeFromParent()
        }
        
        // Increase score by 1, show new score
        scoreTotal++
        scoreTally.string = String(scoreTotal)
        return true
    }
    
    // Apply touch vector handler
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        if (gameOver == false) {
            isTouching = true
        }
    }
    
    
    // Remove touch vector
    override func touchEnded(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        isTouching = false
    }
    override func touchCancelled(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        isTouching = false
    }
    
    
    
    // Apply enemy generation
    func spawnEnemy() {
        var lastEnemyPos = firstEnemyPosition
        if enemies.count > 0 {
            lastEnemyPos = enemies.last!.position.x
        }
        let enemy = CCBReader.load("Enemy") as! Enemy
        enemy.position = ccp(lastEnemyPos + distanceBetweenEnemies, 0)
        enemy.setupRandomPosition()
        scrollingPhysicsNode.addChild(enemy)
        enemies.append(enemy)
        
    }
    
    // Apply coin generation
    func spawnCoin() {
        var lastCoinPos = firstCoinPosition
        if coins.count > 0 {
            lastCoinPos = coins.last!.position.x
        }
        let coin = CCBReader.load("Coin") as! Coin
        coin.position = ccp(lastCoinPos + distanceBetweenCoins, 0)
        coin.setupRandomPosition()
        scrollingPhysicsNode.addChild(coin)
        coins.append(coin)
        
    }
    
    // Apply restart method
    func restart() {
        let openingScene = CCBReader.loadAsScene("MainScene")
        CCDirector.sharedDirector().presentScene(openingScene)
    }
    
    // Trigger restart method
    func endGame() {
        if (gameOver == false) {
            gameOver = true
            restartButton.visible = true
            scrollingRate = 0
            
            // Emergency termination
            champion.stopAllActions()
            
            let move = CCActionEaseBounceOut(action: CCActionMoveBy(duration: 0.2, position: ccp(0, 4)))
            let moveBack = CCActionEaseBounceOut(action: move.reverse())
            let shakeSequence = CCActionSequence(array: [move, moveBack])
            runAction(shakeSequence)
        }
    }
    
    // Update function
    override func update(delta: CCTime) {
        
        
        // Create maximimum Y boundary
        let newYPosition = Float(champion.position.y)
        let boundingY = Float(scrollingPhysicsNode.boundingBox().height - 20)
        //        let y = CGFloat(clampf(newYPosition, Float(20), boundingY))
        
        // Update character position
        champion.position = ccp(champion.position.x + scrollingRate * CGFloat(delta), champion.position.y)
        
        champion.physicsBody.velocity.x = 0
        
        // While touching screen, apply steady impulse to champion  (no change in x, positive change in y direction)
        if isTouching {
            champion.physicsBody.applyImpulse(ccp(0, 50))
        }
        
        // Update scrolling node position
        scrollingPhysicsNode.position = ccp(scrollingPhysicsNode.position.x - scrollingRate * CGFloat(delta), scrollingPhysicsNode.position.y)
        
        // Update upper & lower boundary positions (scrolling effect)
        upperFloor.position.x = champion.position.x
        lowerFloor.position.x = champion.position.x
        
        
        
        // Append mountains
        for mountain in mountains {
            let mountainWorldPosition = scrollingPhysicsNode.convertToWorldSpace(mountain.position)
            let mountainScreenPosition = convertToNodeSpace(mountainWorldPosition)
            if mountainScreenPosition.x <= (-mountain.contentSize.width) {
                mountain.position = ccp(mountain.position.x + mountain.contentSize.width * 2, mountain.position.y)
            }
            
        }
        
        // Spawn endless coins
        for coin in coins.reverse() {
            let coinWorldPosition = scrollingPhysicsNode.convertToWorldSpace(coin.position)
            let coinScreenPosition = convertToNodeSpace(coinWorldPosition)
            
            // obstacle moved past left side of screen?
            if coinScreenPosition.x < (-coin.contentSize.width) {
                coin.removeFromParent()
                coins.removeAtIndex(find(coins, coin)!)
                
                // for each removed obstacle, add a new one
                spawnCoin()
            }
        }
        
        // Spawn endless enemies
        for enemy in enemies.reverse() {
            let enemyWorldPosition = scrollingPhysicsNode.convertToWorldSpace(enemy.position)
            let enemyScreenPosition = convertToNodeSpace(enemyWorldPosition)
            
            // obstacle moved past left side of screen?
            if enemyScreenPosition.x < (-enemy.contentSize.width) {
                enemy.removeFromParent()
                enemies.removeAtIndex(find(enemies, enemy)!)
                
                // for each removed obstacle, add a new one
                spawnEnemy()
            }
        }
        
    }
}