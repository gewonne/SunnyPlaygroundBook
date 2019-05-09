/*:
 # Properties
 
 We saw how we can use [functions](glossary://Function) to perform actions and what a [string](glossary://String) is. Amazing isn't it?
 Now, we will use properties with which we can store those strings and [integers](glossary://Integer).
 
 Think of properties like characteristics of a person.
 We can say that Sunny has a property of type color, which is yellow.
 Because he is yellow!
 Easy isn't it?
 
 1. Set the `mood` property of Sunny to the mood you think he is in now!
 
 */
//#-hidden-code
/*
 Our adventure with Sunny has come to an end. We discovered the universe together,
 regained confidence and met some great new people. How do you think Sunny is feeling now?
 */
import Foundation
import UIKit
import PlaygroundSupport

var sunny = Person()

var text = "The time has come to say goodbye to our new friend Sunny..."


//#-end-hidden-code
sunny.mood = /*#-editable-code*/.superHappy/*#-end-editable-code*/
//#-hidden-code
PlaygroundPage.current.assessmentStatus = .pass(message: text)
//#-end-hidden-code
/*:
 # The End! ... Or the Beginning?
 
 You succesfully helped Sunny back on his way.
 He feels connected with the world and the people in it again.
 
 Now it's your turn to use what you have learned from this book for your own benefits.
 So the end of this adventure,
 means the beginning of a new one! Either in the real- or virtual world.
 
 If you want to learn more about how this Playground relates to me, head over to the [My Story](@next) page.
 
 See you around!
 ♡
 */
