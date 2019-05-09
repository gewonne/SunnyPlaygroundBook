import Foundation
import SpriteKit


class StarNode: SKSpriteNode {
    
    var nameOfPerson: String?
    var storyOfPerson: String?

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init(startLocation: CGPoint, name: String, story: String, imageName: String){
        self.init(imageNamed: imageName)
        
        self.nameOfPerson = name
        self.storyOfPerson = story
        self.position = startLocation
        
        //self.addChild(SKSpriteNode.init(imageNamed: imageName)) // This was a bug. I left it in for educational purposes.
    }
}


