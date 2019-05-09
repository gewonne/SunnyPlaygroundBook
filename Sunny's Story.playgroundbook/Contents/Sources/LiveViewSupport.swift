import UIKit
import PlaygroundSupport
import SpriteKit
import SceneKit
import GameKit


public func instantiateViewController(for page: String) -> PlaygroundLiveViewable {
    
    switch page {
    case "C1P1":
        return  GameViewController(scene: GameScene11())
    case "C1P2":
        return  GameViewController(scene: GameScene12())
    case "C1P3":
        return  GameViewController(scene: GameScene13())
    case "C1P4":
        return  GameViewController(scene: GameScene14())
    case "C2P1":
        return  GameViewController(scene: GameScene21())
    default:
        return GameViewController(scene: GameScene())
    }
}

// Link: https://developer.apple.com/documentation/playgroundsupport/playgroundliveviewmessagehandler
/*
 // We don't need to declare this, as this is already implemented in the class PlaygroundLiveViewMessageHandler
 extension PlaygroundLiveViewMessageHandler {
    // sends a live view message (as a 'playgroundValue') to a remote object.
    public func send(_ message: PlaygroundValue) {    }
}
*/
public protocol PlaygroundValueConvertible {
    func asPlaygroundValue() -> PlaygroundValue
}

public func sendValue(_ value: PlaygroundValueConvertible) {
    let page = PlaygroundPage.current
    let proxy = page.liveView as! PlaygroundRemoteLiveViewProxy
    proxy.send(value.asPlaygroundValue())
}

public func sendValue(_ value: PlaygroundValue) {
    let page = PlaygroundPage.current
    let proxy = page.liveView as! PlaygroundRemoteLiveViewProxy
    proxy.send(value)
}
