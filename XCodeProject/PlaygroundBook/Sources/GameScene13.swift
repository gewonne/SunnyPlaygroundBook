import Foundation
import SpriteKit
import SceneKit
import GameKit

class GameScene13: GameScene {
    
    //////////////////////////////////////////////////////////////////////////////////
    //// Initializers & Setup Functions
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        drawMainCharacter(scaledBy: 0.2)
        populateUniverseWithStars()
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        
        guard oldSize != self.size else { return }
        
        drawMainCharacter(scaledBy: 0.2)
        populateUniverseWithStars()
    }
    
    //// End of Class
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
}

