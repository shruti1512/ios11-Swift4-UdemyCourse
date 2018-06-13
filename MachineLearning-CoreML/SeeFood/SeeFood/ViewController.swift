//
//  ViewController.swift
//  SeeFood
//
//  Created by Shruti Sharma on 6/12/18.
//  Copyright © 2018 Shruti Sharma. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
    }

    @IBAction func cameraBtnTapped(_ sender: Any) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func detectImage(image: CIImage) {
        
        //1. Load a VNCoreMLModel using CoreML(Inceptionv3) model
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Loading CoreML model failed.")
        }
        
        //2. Create a VNCoreMLRequest using the model to classify the data
        let request = VNCoreMLRequest(model: model) { (request, error) in
            //Once the request gets complete then this callback gets trigerred where we get back observation results or error
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image")
            }
            print(results)
            
            //The first Reslt is the one with highest confidence ratio so we check the identifeir for our search string
            if let firstResult = results.first {
                if(firstResult.identifier.contains("hotdog")) {
                    self.navigationItem.title = "Hotdog!"
                }
                else {
                    self.navigationItem.title = "Not Hotdog!"
                }
            }

        }

        //3. Create a VNImageRequestHandler handler to process the VNCoreMLRequest request for the image data
        let requestHandler = VNImageRequestHandler(ciImage: image)

        //4. Perform the request for classifying the image using the request handler
        do {
            try requestHandler.perform([request])
        }
        catch {
            print(error.localizedDescription)
        }
        
    }
    
}

extension ViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Image not selected")
        }
        
        imageView.image = selectedImage

        //Convert image to CCImage to be used for classification by CoreML Model
        guard let ciimage = CIImage(image: selectedImage) else {
            fatalError("Image unable to convert to CIImage")
        }
        
        detectImage(image: ciimage)
        
    }
}

