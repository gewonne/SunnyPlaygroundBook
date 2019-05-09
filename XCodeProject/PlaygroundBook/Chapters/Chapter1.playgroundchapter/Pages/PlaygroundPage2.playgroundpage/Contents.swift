/*:
 # Parameters
 
 * Note:
 In the [previous page](@previous) we helped Sunny around.
 But sometimes we need to be able to do things on our own.
 Now, let's make Sunny move independently.
 
 To do this we need to give extra information to the function when it is being [executed](glossary://Execution).
 
 The structure to write this is: `object.function("extra information")`.
 We call this extra information a [parameter](glossary://Parameter).
 
 1. Type a number corresponding to a location
 2. Watch what happens.
 */
//#-hidden-code
import Foundation
import UIKit
import PlaygroundSupport

let sunny = Person()

//<#T##Choose your Location##Int# >
//#-end-hidden-code

sunny.moveToPosition(/*#-editable-code*/3/*#-end-editable-code*/)

//#-hidden-code
var text = "Great! You helped Sunny to move on his own again! \nWith guidance or without, the important thing is that we  always try to move! Now, let's move on to the [Next Page](@next)!"
PlaygroundPage.current.assessmentStatus = .pass(message: text)
//#-end-hidden-code
