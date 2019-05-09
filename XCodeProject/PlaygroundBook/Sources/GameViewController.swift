import Foundation
import UIKit
import SpriteKit
import SceneKit
import GameKit
import PlaygroundSupport

class GameViewController: UIViewController, PlaygroundLiveViewMessageHandler {
    
    var skView: SKView!
    var scene: GameScene!
    
    init(scene: GameScene) {
        super.init(nibName: nil, bundle: nil)
        self.scene =  scene
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        skView = SKView.init(frame: self.view.frame)
        self.view = skView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skView.ignoresSiblingOrder = true // For built-in SpriteKit optimizations when rendering
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        //skView.showsFPS = true
        //skView.showsNodeCount = true

    }
    
    public func receive(_ message: PlaygroundValue) {
        // Implement this method to receive messages sent from the process running Contents.swift.
        // This method is *required* by the PlaygroundLiveViewMessageHandler protocol.
        // Use this method to decode any messages sent as PlaygroundValue values and respond accordingly.
        
        let scaler = CGFloat.init(0.3)
        
        switch message {
        case .integer(let data):
            scene.moveNode(to: data)
        case .string(let str):
            switch str {
            case "follow":
                scene.showDragMe()
            case "OG_Sunny_smile_cropped":
                scene.player.removeFromParent()
                scene.drawMainCharacter(scaledBy: scaler, imageName: str)
            case "OG_Sunny_think_cropped":
                scene.player.removeFromParent()
                scene.drawMainCharacter(scaledBy: scaler, imageName: str)
            case "OG_Sunny_grin_cropped":
                scene.player.removeFromParent()
                scene.drawMainCharacter(scaledBy: scaler, imageName: str)
            case "OG_Sunny_sad_cropped":
                scene.player.removeFromParent()
                scene.drawMainCharacter(scaledBy: scaler, imageName: str)
            default:
                scene.sayHi(str)
            }
            
        default:
            return
        }
    }
    
    public func send(_ message: PlaygroundValue) {
        print("hello back!")
    }
    
    /*
     public func liveViewMessageConnectionOpened() {
     // Implement this method to be notified when the live view message connection is opened.
     // The connection will be opened when the process running Contents.swift starts running and listening for messages.
     }
     */
    
    /*
     public func liveViewMessageConnectionClosed() {
     // Implement this method to be notified when the live view message connection is closed.
     // The connection will be closed when the process running Contents.swift exits and is no longer listening for messages.
     // This happens when the user's code naturally finishes running, if the user presses Stop, or if there is a crash.
     }
     */
}


