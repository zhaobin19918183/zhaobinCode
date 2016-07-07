//: Playground - noun: a place where people can play

import UIKit


//let aMirror = Mirror(reflecting: #line)
let closure = { (a: Int) -> Int in return a * 2 }
let aMirror = Mirror(reflecting: closure)