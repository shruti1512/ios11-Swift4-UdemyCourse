//
//  ViewController.swift
//  FatImages
//
//  Created by Fernando Rodriguez on 10/12/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

import UIKit

// MARK: - BigImages: String

// Wondering why we only use https connections?
// It's because of a new iOS feature called App Transport Security.
// From now on, Apps can only access resources through a secure
// connection, using https. You can easily change this default
// behavior. Check this article to find out how:
// http://www.neglectedpotential.com/2015/06/working-with-apples-application-transport-security/
// OTOH, if you have no idea what the difference between an http and
// https connection is, fear not! Everything will be explained in the
// networking section.
// At this point it's not relevant.
enum BigImages: String {
    case whale = "https://lh3.googleusercontent.com/16zRJrj3ae3G4kCDO9CeTHj_dyhCvQsUDU0VF0nZqHPGueg9A9ykdXTc6ds0TkgoE1eaNW-SLKlVrwDDZPE=s0#w=4800&h=3567"
    case shark = "https://lh3.googleusercontent.com/BCoVLCGTcWErtKbD9Nx7vNKlQ0R3RDsBpOa8iA70mGW2XcC76jKS09pDX_Rad6rjyXQCxngEYi3Sy3uJgd99=s0#w=4713&h=3846"
    case seaLion = "https://lh3.googleusercontent.com/ibcT9pm_NEdh9jDiKnq0NGuV2yrl5UkVxu-7LbhMjnzhD84mC6hfaNlb-Ht0phXKH4TtLxi12zheyNEezA=s0#w=4626&h=3701"
}

// MARK: - ViewController: UIViewController

class ViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var photoView: UIImageView!
    
    // MARK: Actions
    
    // This method downloads a huge image, blocking the main queue and
    // the UI.
    // This is for instructional purposes only, never do this.
    @IBAction func synchronousDownload(_ sender: UIBarButtonItem) {
        
        photoView.image = nil
        if let imageURL = URL(string: BigImages.seaLion.rawValue) {
            do {
                let imageData = try Data(contentsOf: imageURL)
                if let image = UIImage(data: imageData){
                    photoView.image = image
                }
            }
            catch (let err){
                print(err)
            }
        }
    }
    
    // This method avoids blocking by creating a new queue that runs
    // in the background, without blocking the UI.
    @IBAction func simpleAsynchronousDownload(_ sender: UIBarButtonItem) {

        photoView.image = nil
        
        //Get the image url
        if let imageURL = URL(string: BigImages.shark.rawValue) {
            
            //Create a background queue
            let downloadQueue = DispatchQueue(label: "download")
            
            // add a closure that encapsulates the blocking operation
            // run it asynchronouslyon the background queue: some time in the near future
            downloadQueue.async() { () -> Void in
                do {
                    //Download image data from the image url
                     let imageData = try Data(contentsOf: imageURL)
                    
                    //Convert the image data to UIImage
                     if let image = UIImage(data: imageData) {
                        
                        //Run the code that updates the UI in the main queue!
                        DispatchQueue.main.async { [weak self] in
                            self?.photoView.image = image
                        }
                    }
                }catch {
                    print(error)
                }
            }
        }
    }
    
    // This code downloads the huge image in a global queue and uses a completion
    // closure.
    @IBAction func asynchronousDownload(_ sender: UIBarButtonItem) {

        photoView.image = nil
        
        withBigImage { [weak self] (image) in
            self?.photoView.image = image
        }
    }
    
    // This method downloads the image in the background once it's
    // finished, it runs the closure it receives as a parameter.
    // This closure is called a completion handler
    // Go download the image, and once you're done, do _this_ (the completion handler)
    
    func withBigImage(completionHandler handler: @escaping (_ image:UIImage)->Void){
        
        // get the url
        // get the NSData
        // turn it into a UIImage

        DispatchQueue.global(qos: .default).async {
            if let imageURL = URL(string: BigImages.whale.rawValue), let imageData = try? Data(contentsOf: imageURL), let image = UIImage(data: imageData) {
                // run the completion block
                // always in the main queue, just in case!
                DispatchQueue.main.async {
                    handler(image)
                }
            }
        }
    }
    
    // Changes the alpha value (transparency of the image). It's only purpose is to show if the
    // UI is blocked or not.
    @IBAction func setTransparencyOfImage(_ sender: UISlider) {
        photoView.alpha = CGFloat(sender.value)
    }
}
