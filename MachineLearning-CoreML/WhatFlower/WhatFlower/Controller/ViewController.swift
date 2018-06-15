//
//  ViewController.swift
//  WhatFlower
//
//  Created by Shruti Sharma on 6/14/18.
//  Copyright © 2018 Shruti Sharma. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
    }

    @IBAction func cameraBtnTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        dismiss(animated: true, completion: nil)
        
        guard let capturedImage = info[UIImagePickerControllerEditedImage] as? UIImage else {
            fatalError("Could not capture image.")
        }
        
        guard let convertedCIImage = CIImage(image: capturedImage) else {
            fatalError("Unable to covert image to CIImage object")
        }
        
        let imageDetection = ImageDetection()
        imageDetection.detect(image: convertedCIImage) { (name, description, imageURLString) in
            weak var weakSelf = self
            weakSelf?.navigationItem.title = name.capitalized
            weakSelf?.descriptionLbl.text = description
            weakSelf?.imageView.sd_setImage(with: URL(string:imageURLString), completed: nil)
        }
    }
    
    
}

