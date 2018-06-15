//
//  DataService.swift
//  WhatFlower
//
//  Created by Shruti Sharma on 6/14/18.
//  Copyright © 2018 Shruti Sharma. All rights reserved.
//

import Foundation
import Alamofire //to process network requests
import SwiftyJSON //SwiftyJSON is a super-simplified JSON parsing library that gives you clearer syntax than the built-in iOS libraries

class DataService {
    
    static let service_instance = DataService()
    private init() {} //This prevents others from using the default '()' initializer for this class.

    func downloadWikiData(for flower: String, completion: @escaping (Flower) -> Void) {
        
        let parameters : [String:String] = [
            "format" : "json",
            "action" : "query",
            "prop" : "extracts|pageimages",
            "exintro" : "",
            "explaintext" : "",
            "titles" : flower,
            "indexpageids" : "",
            "redirects" : "1",
            "pithumbsize": "500"
        ]
        
        Alamofire.request("https://en.wikipedia.org/w/api.php", method: .get, parameters: parameters).responseJSON { response in
            print("Request: \(String(describing: response.request))") // original url request
            print("Response: \(String(describing: response.result))") // response serialization result
            
            if response.result.value != nil {
                
                let jSONResult = JSON(response.result.value!)
                print("JSON Response using SwiftyJSON: \(jSONResult)") // JSON Response using SwiftyJSON
                
                let pageids = jSONResult["query"]["pageids"][0].stringValue
                print("pageids: \(pageids)")
                
                let flowerDesc = jSONResult["query"]["pages"][pageids]["extract"].stringValue
                print("flower description: \(String(describing: flowerDesc))")
                
                let flowerTitle = jSONResult["query"]["pages"][pageids]["title"].stringValue
                print("flower title: \(String(describing: flowerTitle))")

                let imageSource = jSONResult["query"]["pages"][pageids]["thumbnail"]["source"].stringValue
                print("flower image source: \(String(describing: imageSource))")

                let flower = Flower(flowerID: pageids, title: flowerTitle, description: flowerDesc, imageURLString: imageSource)
                completion(flower)
            }
        }
    }

}
