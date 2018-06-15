//: Playground - to understand closures

import UIKit

func calculator (n1: Int, n2: Int, operation: (Int, Int) -> Int) -> Int {
    return operation(n1, n2)
}

let result = calculator(n1: 2, n2: 3) {$0 + $1}
print(result)

let array = [2, 4, 8, 9]
let newArray = array.map(){$0+1}
print(newArray)

class Firebase {
    func createUser(name: String, passwd: String, completion:(Bool, Int)->Void){
        //does something time consuming
        var isSuccess = true
        var userID = 1234
        completion(isSuccess, userID)
    }
}

class MyApp {
    
    func registerUser() {
        let firebase = Firebase()
        firebase.createUser(name: "Shruti", passwd: "12345") {
            (isSuccess, userID) in
            print("Registration successful: \(isSuccess)")
            print("User ID:\(userID)")
        }
    }
}

let user = MyApp()
user.registerUser()
