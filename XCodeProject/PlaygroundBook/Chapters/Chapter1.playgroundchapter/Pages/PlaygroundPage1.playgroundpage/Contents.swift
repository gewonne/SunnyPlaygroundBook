//#-hidden-code
import Foundation
import UIKit
import PlaygroundSupport

let sunny = Person()
//#-end-hidden-code
/*:
 
 # Functions
 
 
 - Note:
 The world can sometimes look like a big and scary place.
 But, if we take one step at a time, it will turn out a wonderful place.
 \
 Now we will use the power of code to guide Sunny through our world full of challenges!
 
 In Swift we use [functions](glossary://Function) to get something done.
 The function `followMyFinger()` will make an [object](glossary://Object) follow our finger as we drag it over the screen.
 In our case the object is our friend Sunny. In swift this becomes: `object.function()`.
 
 1. Run the code
 2. Show Sunny around
 */
sunny.followMyFinger()

//#-hidden-code
PlaygroundPage.current.assessmentStatus = .pass(message: "**Good Job**! You executed your first function. Now Sunny can be dragged around the screen.")
//#-end-hidden-code
