import Foundation
   
class Coin : CCNode {
    weak var coin: CCNode!
    
    // Define min/max coin Y position
    let coinMinimumPositionY : CGFloat = 50
    let coinMaximumPositionY : CGFloat = 300
    let coinDistance : CGFloat = 50
    
    // Define random Y position
    func setupRandomPosition() {
        let randomCallibration : UInt32 = 100
        let randomStir = CGFloat(arc4random_uniform(randomCallibration)) / CGFloat(randomCallibration)
        let range = coinMaximumPositionY - coinMinimumPositionY
        coin.position = ccp(coin.position.x, coinMinimumPositionY + (randomStir * range))
    }
    
    // Declare didLoadFrom
    func didLoadFromCCB() {
        coin.physicsBody.sensor = true
    }
}
