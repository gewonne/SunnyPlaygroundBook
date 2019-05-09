import Foundation
import SpriteKit
import SceneKit
import GameKit

class GameScene14: GameScene {
    
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
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        
        guard oldSize != self.size else { return }
        
        drawMainCharacter(scaledBy: 0.3, imageName: "OG_Sunny_noFace")
    }
    
    //// End of Class
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
}

