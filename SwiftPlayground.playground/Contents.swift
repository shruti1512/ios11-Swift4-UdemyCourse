//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//Tuple
let http404Error = (404, "Not Found")
print(http404Error)

//Decomposing a tuple
//Method 1
print("the error code: \(http404Error.0)")
print("the error message: \(http404Error.1)")

//Method 2
let (statusCode, statusMessage) = http404Error
print("the status code is \(statusCode)")
let (justTheStatusCode, _) = http404Error
print("the status code is \(justTheStatusCode)")

//Method 3
let http200Status = (statusCode: 200, description: "Ok")
print("the status code: \(http200Status.statusCode)")
print("the status message: \(http200Status.description)")

//Nil-coalescing operator -- a ?? b
//Short form of a != nil : a! : b

class SurveyQuestion {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestion(text: "How about beets?")
beetsQuestion.ask()
// Prints "How about beets?"
beetsQuestion.response = "I also like beets. (But not with cheese.)"

//Computed properties
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    //center is a computed property with setter and getter
    var center: Point {
        get {
            let centerX = origin.x + (size.width/2)
            let centerY = origin.y + (size.height/2)
            return Point(x: centerX, y: centerY)
        }
        set {
           origin.x = newValue.x - (size.width/2)
           origin.y = newValue.y - (size.height/2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 15.0, height: 15.0))
print("Square Origin is: \(square.origin)")
print("Square Center is: \(square.center)")
square.center = Point(x: 10.0, y: 10.0)
print("Square New Center is: \(square.center)")
print("Square New Origin is: \(square.origin)")

//Closures
var birthYears = [2004, 2011, 2007, 2005, 2002]
var reverseChronologicalYears = birthYears.sorted { (year1, year2) -> Bool in
    year1 > year2
}

//Shorthand Argument Names in Closure Expressions
var soups = ["tomato", "hot and sour", "french onion", "vegetable"]
var sortedSoups = soups.sorted(by: {(soup1: String, soup2: String) -> Bool in
    return soup2 > soup1
})

//1. Closure Expressions parameter and return types can be inferred
var sortedSoups2 = soups.sorted(by: {(soup1, soup2) in
    return soup2 > soup1
})

//2. Since it is a single expression(soup2 > soup1) closure so implicit return types
var sortedSoups3 = soups.sorted(by: {(soup1, soup2) in
     soup2 > soup1
})

//Trailing Closure
sortedSoups3 = soups.sorted() { soup1, soup2 in
    soup2 > soup1
}

//3. Shorthand argument names like $0, $1, $2...
var sortedSoups4 = soups.sorted(by: {$1 > $0})
sortedSoups4

var prices = [1.50, 10.00, 4.99, 2.30, 8.19]
var filteredPrices = prices.filter( {price in
    price > 5.00
})

//Closure is the last paramter in the function argument then you can remove paranthesis
filteredPrices = prices.filter{ price in price > 5.00 }
filteredPrices

var salePrices = prices.map {price -> Double in
    return price * 0.9
}

//Enumerations
//Associated Values
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrcode(String)
}

var productCode = Barcode.upc(2, 3456, 6789, 5)

//Raw Values
enum  ASCIIControlCharacter: Character{
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

protocol FullyNamed {
    var fullName: String { get }
}
class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String?) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
    
    func longAction(completion: () -> ()) {
//        for index in veryLargeArray {
//            // do something with veryLargeArray, which is extremely time-consuming
//        }
        completion() // notify the caller that the longAction is finished
    }
    
}

var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
ncc1701.fullName
ncc1701.longAction(completion: {
    print("work done1")
})
ncc1701.longAction{
    print("work done2")
}

