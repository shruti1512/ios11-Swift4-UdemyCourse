//
//  ImageDetection.swift
//  WhatFlower
//
//  Created by Shruti Sharma on 6/15/18.
//  Copyright © 2018 Shruti Sharma. All rights reserved.
//

import Foundation
import CoreML
import Vision

class ImageDetection {
    
    func detect(image: CIImage, completion: @escaping (String, String, String) ->Void) {
        
        //1. Load CoreMl Model using VNCoreMLModel
        guard let vnCoreMlModel = try? VNCoreMLModel(for: FlowerClassifier().model) else {
            fatalError("Unable to load coreml model")
        }
        
        //2. Create VNCoreMLRequest to classify image
        let request = VNCoreMLRequest(model: vnCoreMlModel) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Request could not be processed")
            }
            
            if let firstResult = results.first {
                
                let flowerName = firstResult.identifier
                
                DataService.service_instance.downloadWikiData(for: flowerName) { flower in
                    completion(flower.title, flower.description, flower.imageURLString)
                }
            }
        }
        
        //3. Create VNImageRequestHandler to process the VNCoreMLRequest request for image
        let requestHandler = VNImageRequestHandler(ciImage: image)
        do {
            try requestHandler.perform([request])
        }
        catch {
            print(error.localizedDescription)
        }
        
    }

}
