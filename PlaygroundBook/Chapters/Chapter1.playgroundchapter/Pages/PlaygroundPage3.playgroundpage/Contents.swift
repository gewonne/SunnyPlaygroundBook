/*:
 # Strings
 
 In the previous pages we saw how to work with [functions](glossary://Function) and giving them [arguments](glossary://Argument).
 
 Arguments can accept different forms of data. On the [previous page](@previous) we used [integers](glossary://Integer).
 In this example we will use a new sort of data called a [string](glossary://String).
 A `string` is used to store text as data.

 1. Drag Sunny around
 2. Look for new friends
 3. Say hello back
 
 */
//#-hidden-code

import Foundation
import UIKit
import PlaygroundSupport

var sunny = Person()

//sunny.sayHi(/*#-editable-code*/<#T##Your Greeting##String# >/*#-end-editable-code*/)
//https://developer.apple.com/documentation/swift_playgrounds/customizing_the_completions_in_the_shortcut_bar

//#-end-hidden-code

sunny.sayHi(/*#-editable-code*/"Hello, I'm Sunny."/*#-end-editable-code*/)

//#-hidden-code
var text = "**Congratulations!** You just used a string as an argument for a function! Do you see how fun and easy it is to make new friends? I'm sure you are now ready for what's [NEXT](@next)."
PlaygroundPage.current.assessmentStatus = .pass(message: text)
//#-end-hidden-code

