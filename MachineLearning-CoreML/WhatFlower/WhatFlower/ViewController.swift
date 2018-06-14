//
//  ViewController.swift
//  WhatFlower
//
//  Created by Shruti Sharma on 6/14/18.
//  Copyright © 2018 Shruti Sharma. All rights reserved.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
    }

    @IBAction func cameraBtnTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func detect(image: CIImage) {
        
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
                self.navigationItem.title = firstResult.identifier.capitalized
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

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        dismiss(animated: true, completion: nil)
        
        guard let capturedImage = info[UIImagePickerControllerEditedImage] as? UIImage else {
            fatalError("Could not capture image.")
        }
        
        imageView.image = capturedImage
        
        guard let convertedCIImage = CIImage(image: capturedImage) else {
            fatalError("Unable to covert image to CIImage object")
        }
        
        detect(image: convertedCIImage)
        
        
    }
    
    
}

