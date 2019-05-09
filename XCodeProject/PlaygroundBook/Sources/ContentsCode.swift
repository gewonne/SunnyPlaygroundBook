import Foundation
import UIKit
import PlaygroundSupport

public enum Mood : String {
    case happy      = "OG_Sunny_smile_cropped"
    case superHappy = "OG_Sunny_grin_cropped"
    case thinking   = "OG_Sunny_think_cropped"
    case sad        = "OG_Sunny_sad_cropped"
}
public enum Greeting : String {
    case hello      = "Hello, my name is Sunny."
    case hola       = "Hola, me llamo Sunny."
    case bonjour    = "Bonjour, je m'appele Sunny."
    case hallo      = "Hallo, ik noem Sunny"
    case ciao       = "Ciao, mi chiamo Sunny"
    case gutenTag   = "Guten tag, ich heisse Sunny"
}

public func showPassMessage(message: String) {
    PlaygroundPage.current.assessmentStatus = .pass(message: message)
}

public class Person: PlaygroundLiveViewMessageHandler {
    public init() {}
    
    let name = "Sunny"
    let oldPosition = 2
    let currentPosition = 4
    public var mood: Mood = .happy {
        didSet {
            sendValue(.string(mood.rawValue))
        }
    }
    
    public func followMyFinger() {
        sendValue(.string("follow"))
    }
    public func moveToPosition(_ newPosition: Int) {
        // https://developer.apple.com/documentation/playgroundsupport/playgroundvalue/integer
        sendValue(.integer(newPosition))
    }
    public func sayHi(_ message: Greeting){
        sendValue(.string(message.rawValue))
    }
    public func sayHi(_ message: String){
        sendValue(.string(message))
    }
}
