//
//  ViewController.swift
//  Instagrid
//
//  Created by Edouard PLANTEVIN on 07/05/2019.
//  Copyright © 2019 Edouard PLANTEVIN. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    // ImageView
    
    // Layout 2
    @IBOutlet weak var imageSquareTopLeft: UIImageView!
    @IBOutlet weak var imageSquareTopRight: UIImageView!
    @IBOutlet weak var imageRectangleDown: UIImageView!
    
    //Witch ImageView user click
    var activeImageView = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // ----- Button -----
    
    // Layout 2
    @IBAction func btnImageSquareTopLeft(_ sender: Any) {
        activeImageView = 1
        pickImageToLibrairie()
    }
    @IBAction func btnImageSquareTopRight(_ sender: Any) {
        activeImageView = 2
        pickImageToLibrairie()
    }
    
    @IBAction func btnImageRectangleDown(_ sender: Any) {
        activeImageView = 3
        pickImageToLibrairie()
    }
    
    //  3 Func to add new photo in a good imageView
    
    func pickImageToLibrairie() {
        let imagePick = UIImagePickerController()
        imagePick.sourceType = .photoLibrary
        imagePick.delegate = self
        self.present(imagePick, animated: true, completion: nil)
    }
    
    func witchImageView(nb: Int) -> UIImageView {
        switch activeImageView {
        case 1:
            return imageSquareTopLeft
        case 2:
            return imageSquareTopRight
        case 3:
            return imageRectangleDown
        default:
            return imageSquareTopLeft
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagePick = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            witchImageView(nb: activeImageView).image = imagePick
        }
        self.dismiss(animated: true, completion: nil)
    }
}

