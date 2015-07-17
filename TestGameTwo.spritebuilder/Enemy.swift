import Foundation

class Enemy : CCNode {
    weak var enemySprite: CCNode!
    
    // Define min/max enemy Y position
    let enemyMinimumPositionY : CGFloat = 50
    let enemyMaximumPositionY : CGFloat = 300

    // Define random Y position
    func setupRandomPosition() {
        let randomCallibration : UInt32 = 100
        let randomStir = CGFloat(arc4random_uniform(randomCallibration)) / CGFloat(randomCallibration)
        let range = enemyMaximumPositionY - enemyMinimumPositionY
        enemySprite.position = ccp(enemySprite.position.x, enemyMinimumPositionY + (randomStir * range))
    }
    
    // Declare didLoadFrom
    func didLoadFromCCB() {
        enemySprite.physicsBody.sensor = true
    }
}