import Foundation

class MainScene: CCNode {
    
    // Declare Doc Root Variables for basic scrolling
    weak var champion: CCSprite!
    weak var scrollingPhysicsNode: CCPhysicsNode!
//    weak var mountainNode: CCNode!
    
    // Declare Doc Root Variables for endless scrolling
    weak var lowerFloor1: CCSprite!
    weak var lowerFloor2: CCSprite!
    var lowerFloors = [CCSprite]()
    
    weak var upperFloor1: CCSprite!
    weak var upperFloor2: CCSprite!
    var upperFloors = [CCSprite]()
    
    weak var mountain1: CCSprite!
    weak var mountain2: CCSprite!
    var mountains = [CCSprite]()
    
    // Declare enemy array
    var enemies: [CCNode] = []
    let firstEnemyPosition: CGFloat = 500
    let distanceBetweenEnemies = 300
    
    
    // Declare scroll speed
    var scrollingRate: CGFloat = 700
    
    // Declare didLoadFrom
    func didLoadFromCCB() {
        userInteractionEnabled = true
        
        // Append arrays for endless scrolling
        lowerFloors.append(lowerFloor1)
        lowerFloors.append(lowerFloor2)
        upperFloors.append(upperFloor1)
        upperFloors.append(upperFloor2)
        mountains.append(mountain1)
        mountains.append(mountain2)
    }
    
    // Apply touch impulse
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        champion.physicsBody.applyImpulse(ccp(0, 800))
    }
    
    // Apply enemy generation
    func spawnEnemy () {
        var lastEnemyPos = firstEnemyPosition
        if enemies.count > 0 {
            lastEnemyPos = enemies.last!.position.x
        }
    }
    
    // Update function
    override func update(delta: CCTime) {
        // Update character position
        champion.position = ccp(champion.position.x + scrollingRate * CGFloat(delta), champion.position.y)
        
        // Update scrolling node position
        scrollingPhysicsNode.position = ccp(scrollingPhysicsNode.position.x - scrollingRate * CGFloat(delta), scrollingPhysicsNode.position.y)
//        mountainNode.position = ccp(mountainNode.position.x - scrollingRate * CGFloat(delta), mountainNode.position.y)
        
        // Automatically spawn 3 obstacles
        for i in 0...2 {
            spawnEnemy()
        }
        
        // Append lower floors
//        for floor in lowerFloors {
//            let floorWorldPosition = scrollingPhysicsNode.convertToWorldSpace(floor.position)
//            let floorScreenPosition = convertToNodeSpace(floorWorldPosition)
//            if floorScreenPosition.x <= (-floor.contentSize.width) {
//                floor.position = ccp(floor.position.x + floor.contentSize.width * 2, floor.position.y)
//            }
//        }
//        
//        
//        // Append upper floors
//        for floor in upperFloors {
//            let floorWorldPosition = scrollingPhysicsNode.convertToWorldSpace(floor.position)
//            let floorScreenPosition = convertToNodeSpace(floorWorldPosition)
//            if floorScreenPosition.x <= (-floor.contentSize.width) {
//                floor.position = ccp(floor.position.x + floor.contentSize.width * 2, floor.position.y)
//            }
//        }
        
        upperFloor1.position.x = champion.position.x
        lowerFloor1.position.x = champion.position.x
        
        
        // Append mountains
        for mountain in mountains {
            let mountainWorldPosition = scrollingPhysicsNode.convertToWorldSpace(mountain.position)
            let mountainScreenPosition = convertToNodeSpace(mountainWorldPosition)
            if mountainScreenPosition.x <= (-mountain.contentSize.width) {
                mountain.position = ccp(mountain.position.x + mountain.contentSize.width * 2, mountain.position.y)
            }
            
        }
    }
}