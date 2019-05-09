import Foundation
import SpriteKit
import SceneKit
import GameKit
import PlaygroundSupport

struct PhysicsCategory {
    static let none                 : UInt32 = 0
    static let all                  : UInt32 = UInt32.max
    static let mainCharacter        : UInt32 = 0b1
    static let supportingCharacter  : UInt32 = 0b10
}

struct zPositionOfNodes {
    static let mainCharacter            : CGFloat = 5
    static let supportingCharacter      : CGFloat = 3
    static let story                    : CGFloat = 4
    static let background               : CGFloat = 0
}

class GameScene: SKScene {
    
    var playerImageName = "OG_Sunny_smile_cropped"
    var player : SKSpriteNode!
    var isFirstResize = true
    var resizeCount = 0
    var isPlayerTouched = false
    
    //////////////////////////////////////////////////////////////////////////////////
    //// Initializers & Setup Functions
    
    override init() {
        super.init(size:  UIScreen.main.bounds.size)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Called immediately after a scene is presented by a view.
    override func didMove(to view: SKView) {
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        backgroundColor = SKColor.init(red: 0, green: 0x33/255, blue: 0x66/255, alpha: 1)
        
    }
    override func sceneDidLoad() {
        
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        
        guard oldSize != self.size else { return }
        
        self.enumerateChildNodes(withName: "//*") {
            node, stop in
            
            node.removeFromParent()
            
        }
    }
    
    func setBackgroundColor(_ color: UIColor) {
        backgroundColor = color
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //// Randomizers & Location Generators
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func randomLocation(in area: CGSize) -> CGPoint {
        let x = CGFloat.init(random(min: 0, max: area.width))
        let y = CGFloat.init(random(min: 0, max: area.height))
        
        return CGPoint.init(x: x, y: y)
    }
    // With taking into account the size of the SpriteNode so it isn't drawn outside the view
    func randomLocation(in area: CGSize, for image: SKSpriteNode) -> CGPoint {
        let scaler:CGFloat = 1.5
        let x = CGFloat.init(random(min: 0+image.size.width*scaler, max: area.width-image.size.width*scaler))
        let y = CGFloat.init(random(min: 0+image.size.height*scaler, max: area.height-image.size.height*scaler))
        
        return CGPoint.init(x: x, y: y)
    }
    func randomLocation(in area: CGRect, for image: SKSpriteNode) -> CGPoint {
        let x = CGFloat.init(random(min: 0+image.size.width/2.5, max: area.width-image.size.width/2.5))
        let y = CGFloat.init(random(min: 0+image.size.height/2.5, max: area.height-image.size.height/2.5))
        
        return CGPoint.init(x: x+area.origin.x, y: y+area.origin.y)
    }
    
    func defineSector(number: Int) -> CGRect {
        let sectorNr = CGFloat(number)
        
        var yMultiplier: CGFloat = 1
        var xMultiplier: CGFloat = 1
        
        switch sectorNr {
        case 1: yMultiplier = 1; xMultiplier = 1
        case 2: yMultiplier = 1; xMultiplier = 2
        case 3: yMultiplier = 1; xMultiplier = 3
        case 4: yMultiplier = 2; xMultiplier = 1
        case 5: yMultiplier = 2; xMultiplier = 2
        case 6: yMultiplier = 2; xMultiplier = 3
        case 7: yMultiplier = 3; xMultiplier = 1
        case 8: yMultiplier = 3; xMultiplier = 2
        case 9: yMultiplier = 3; xMultiplier = 3
        default:yMultiplier = 1; xMultiplier = 1
        }
        
        let rWidth = size.width/3
        let rHeight = size.height/3
        
        let xStart = xMultiplier * rWidth - rWidth
        var yStart = yMultiplier * rHeight - rHeight
        
        // To make the recrtangles go from to to bottom
        yStart = size.height - yStart - rHeight
        
        return CGRect(x: xStart, y: yStart, width: rWidth, height: rHeight)
    }
    
    //////////////////////////////////////////////////////////////////////////////////
    //// SpriteNode Functions
    
    func drawMainCharacter(scaledBy factor: CGFloat = 1.0, imageName: String = "OG_Sunny_smile_cropped") {
        
        //previously: view.frame.midY
        let middlePosition = CGPoint(x: self.size.width/2, y: self.size.height/2)
        //let middlePosition = CGPoint(x: view.frame.midX, y: view.frame.midY)
        
        player = SKSpriteNode(imageNamed: imageName)
        player.position = middlePosition
        player.zPosition = zPositionOfNodes.mainCharacter
        player.name = "mainCharacter"
        player.setScale(factor)
        // https://developer.apple.com/documentation/spritekit/sknode/1483126-setscale
        // https://developer.apple.com/documentation/spritekit/skspritenode/resizing_a_sprite_in_nine_parts
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width/2.4)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.categoryBitMask = PhysicsCategory.mainCharacter
        player.physicsBody?.contactTestBitMask = PhysicsCategory.supportingCharacter
        player.physicsBody?.collisionBitMask = PhysicsCategory.none
        player.physicsBody?.usesPreciseCollisionDetection = true
        
        addChild(player)
    }
    
    
    func showStory(from node: StarNode)  {
        
        let text = node.storyOfPerson
        let positionX = node.position.x + node.size.width * 0.6
        let positionY = node.position.y + node.size.height * 0.6
        
        //https://www.hackingwithswift.com/example-code/games/how-to-write-text-using-sklabelnode
        var storyLabelNode: SKLabelNode!
        storyLabelNode = SKLabelNode(fontNamed: "Chalkboard SE")
        storyLabelNode.text = text
        storyLabelNode.horizontalAlignmentMode = .right
        storyLabelNode.position = CGPoint.init(x: positionX, y: positionY)
        storyLabelNode.zPosition = zPositionOfNodes.story
        if #available(iOS 11.0, *) {
            storyLabelNode.numberOfLines = 3
        } else { storyLabelNode.text = "Hey! 😊" }
        
        run(SKAction.sequence([
            SKAction.run({self.addChild(storyLabelNode)}) ,
            SKAction.wait(forDuration: 4),
            SKAction.run { storyLabelNode.removeFromParent() }
            ]))
    }
    
    func populateUniverseWithStars() {
        var star: SKSpriteNode
        let sequence = [1,1,2,3,3,6,7,9,9]
        for nr in sequence {

            star = StarNode.init(startLocation: CGPoint.init(x: 0, y: 0),
                                 name: "Jos Joskens",
                                 story: "Hey! \nYou found me! \nThanks! ♡",
                                 imageName: "OG_Star_cropped") // "star")
            
            star.name = "supportingCharacter"
            star.zPosition = 3
            star.setScale(0.1)
            star.position = randomLocation(in: defineSector(number: nr) , for: star)
            
            star.physicsBody = SKPhysicsBody(circleOfRadius: star.size.width/2)
            star.physicsBody?.isDynamic = true
            star.physicsBody?.categoryBitMask = PhysicsCategory.supportingCharacter
            star.physicsBody?.contactTestBitMask = PhysicsCategory.mainCharacter
            star.physicsBody?.collisionBitMask = PhysicsCategory.mainCharacter
            
            self.addChild(star)
        }
        
    }
    
    func showSectorNumbers() {
        // Closed range
        // https://developer.apple.com/documentation/swift/closedrange
        //let ranges = [1...4, 6...9] //ranges.joined()
        
        for sectorNumber in 1...9 {
            let text = "\(sectorNumber)"
            let sectorRect = defineSector(number: sectorNumber)
            
            let positionX = sectorRect.midX
            let positionY = sectorRect.midY
            
            let numberLabelNode = SKLabelNode(text: text)
            numberLabelNode.fontSize = 150
            numberLabelNode.fontColor = UIColor.init(red: 255, green: 255, blue: 255, alpha: 0.3)
            //        numberLabelNode.toggleBoldface(numberLabelNode)
            //        storyLabelNode.fontName = ""
            numberLabelNode.horizontalAlignmentMode = .center
            numberLabelNode.verticalAlignmentMode = .center
            numberLabelNode.position = CGPoint.init(x: positionX, y: positionY)
            numberLabelNode.zPosition = zPositionOfNodes.story
            
            self.addChild(numberLabelNode)
        }
    }
    
    func showDragMe() {
        let text = "Drag Me \nAround!"
        
        let dragMeNode = SKLabelNode(text: text)
        dragMeNode.fontSize = 40
        dragMeNode.fontColor = UIColor.init(red: 255, green: 255, blue: 255, alpha: 0.8)
        dragMeNode.verticalAlignmentMode = .center
        dragMeNode.zPosition = zPositionOfNodes.story
        if #available(iOS 11.0, *) {
            dragMeNode.numberOfLines = 2
        } else {
            dragMeNode.text = "Drag Me Around!"
            dragMeNode.fontSize = 20
        }
        dragMeNode.horizontalAlignmentMode = .right
        //        numberLabelNode.toggleBoldface(numberLabelNode)
        //        storyLabelNode.fontName = ""

        let middlePosition = CGPoint(x: self.size.width/2, y: self.size.height/2)
        let positionY = middlePosition.y + player.size.height * (19/32)
        dragMeNode.position = CGPoint.init(x: middlePosition.x, y: positionY)
        
        self.addChild(dragMeNode)
    }
    
    func sayHi(_ message: String) {
        
        let positionX = player.position.x + player.size.width * 0.6
        let positionY = player.position.y + player.size.height * 0.5
        
        var storyLabelNode: SKLabelNode!
        storyLabelNode = SKLabelNode(fontNamed: "Chalkboard SE")
        storyLabelNode.text = message
        storyLabelNode.horizontalAlignmentMode = .right
        storyLabelNode.position = CGPoint.init(x: positionX, y: positionY)
        storyLabelNode.zPosition = zPositionOfNodes.story
        storyLabelNode.color = .black
        
        run(SKAction.sequence([
            SKAction.run({self.addChild(storyLabelNode)}) ,
            SKAction.wait(forDuration: 4),
            SKAction.run { storyLabelNode.removeFromParent() }
            ]))
    }
    
    
    //////////////////////////////////////////////////////////////////////////////////
    //// SpriteNode Dynamics
    
    func moveNodeRandomly(node: SKSpriteNode, in area: CGSize) {
        let position = randomLocation(in: area, for: node)
        let move = SKAction.move(to: position, duration: 0.2)
        node.run(move)
    }
    
    func shakeUpNodes(kind nodeName: String) {
        
        // http://spritekitlessons.com/child-basics-in-sprite-kit-adding-removing-finding/
        self.enumerateChildNodes(withName: "//*") {
            node, stop in
            
            if (node.name == nodeName){
                //let sizeTest = self.size
                self.moveNodeRandomly(node: node as! SKSpriteNode, in: self.size)
            }
        }
    }
    
    
    
    func moveNode(to sectorNumber: Int) {
        // declare sector
        var sectorNumber = sectorNumber
        if (sectorNumber<1) || (sectorNumber>9) {sectorNumber = 3}
        let sectorRect = defineSector(number: sectorNumber)
        
        // move to sector
        let actionMove = SKAction.move(to: CGPoint(x: sectorRect.midX, y: sectorRect.midY), duration: 1.5)
        player.run(actionMove)
        
        // if moved: celebration
    }
    
    func nodeCollision(mainCharacter: SKSpriteNode, supportingCharacter: SKSpriteNode) {

        // https://stackoverflow.com/questions/19251337/ios-7-sprite-kit-freeing-up-memory/21541819#21541819
        let texture = SKTexture(imageNamed: "OG_Star_face_cropped")
        let action = SKAction.setTexture(texture, resize: true)
        supportingCharacter.run(action)
        
        showStory(from: supportingCharacter as! StarNode)
    }
    
    // Not yet finished
    func drift(kind nodeName: String) {
        
        self.enumerateChildNodes(withName: "//*") {
            node, stop in
            
            if (node.name == nodeName){
                let newPositionX:CGFloat = node.position.x + self.random(min: 0, max: 10)
                let newPositionY:CGFloat = node.position.y + self.random(min: 0, max: 10)
                let move = SKAction.move(to: CGPoint.init(x: newPositionX, y: newPositionY), duration: 0.2)
                node.run(move)
            }
        }
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /// Touch Controls
    // https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_touches_in_your_view
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        let touchedNode = self.atPoint(touchLocation)
        
        guard let name = touchedNode.name else { return }
        if name == "mainCharacter" {
            isPlayerTouched = true
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        //        let touchedNode = self.atPoint(touchLocation)
        
        if isPlayerTouched {
            let actionMove = SKAction.move(to: CGPoint(x: touchLocation.x, y: touchLocation.y), duration: 0)
            player.run(actionMove)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        isPlayerTouched = false
    }
    
    func isTouched(node: SKSpriteNode, at touch: CGPoint) -> Bool {
        
        if (    touch.x > (node.position.x - node.size.width/2 ))
            && (touch.x < (node.position.x + node.size.width/2))
            && (touch.y > (node.position.x - node.size.height/2))
            && (touch.y < (node.position.x + node.size.height/2))
        {
            return true
        } else {
            return false
        }
    }
    
    //// End of Class
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Extensions

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        // 1
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // 2
        if ((firstBody.categoryBitMask & PhysicsCategory.mainCharacter != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.supportingCharacter != 0)) {
            if let mainCharacter = firstBody.node as? SKSpriteNode,
                let supportingCharacter = secondBody.node as? SKSpriteNode {
                nodeCollision(mainCharacter: mainCharacter, supportingCharacter: supportingCharacter)
            }
        }
    }
}
