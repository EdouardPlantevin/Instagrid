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
    
    /* ---- Layout 1 ----- */
    
    // ImageView
    @IBOutlet weak var imageRectangleUp: UIImageView!
    @IBOutlet weak var imageSquareDownLeft: UIImageView!
    @IBOutlet weak var imageSquareDownRight: UIImageView!
    
    // Button
    @IBOutlet weak var btnRectangleUp: UIButton!
    @IBOutlet weak var btnSquareDownLeft: UIButton!
    @IBOutlet weak var btnSquareDownRight: UIButton!
    
    /* ---- Layout 2 ----- */
    
    // ImageView
    @IBOutlet weak var imageSquareTopLeft: UIImageView!
    @IBOutlet weak var imageSquareTopRight: UIImageView!
    @IBOutlet weak var imageRectangleDown: UIImageView!
    
    // Button
    @IBOutlet weak var btnSquareTopLeft: UIButton!
    @IBOutlet weak var btnSquareTopRight: UIButton!
    @IBOutlet weak var btnRectangleDown: UIButton!
    
    
    //Witch ImageView user click
    var activeImageView = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout2()
        // Do any additional setup after loading the view.
    }
    
    // Layout
    
    private func layout1() {
        
        //layout 1 appaear
        imageRectangleUp.isHidden = false
        imageSquareDownLeft.isHidden = false
        imageSquareDownRight.isHidden = false
        btnRectangleUp.isHidden = false
        btnSquareDownLeft.isHidden = false
        btnSquareDownRight.isHidden = false
        
        //layout 2 hidden
        imageSquareTopLeft.isHidden = true
        imageSquareTopRight.isHidden = true
        imageRectangleDown.isHidden = true
        btnSquareTopLeft.isHidden = true
        btnRectangleDown.isHidden = true
        btnSquareTopRight.isHidden = true
    }
    
    private func layout2() {
        
        //layout 1 appaear
        imageRectangleUp.isHidden = true
        imageSquareDownLeft.isHidden = true
        imageSquareDownRight.isHidden = true
        btnRectangleUp.isHidden = true
        btnSquareDownLeft.isHidden = true
        btnSquareDownRight.isHidden = true
        
        //layout 2 hidden
        imageSquareTopLeft.isHidden = false
        imageSquareTopRight.isHidden = false
        imageRectangleDown.isHidden = false
        btnSquareTopLeft.isHidden = false
        btnRectangleDown.isHidden = false
        btnSquareTopRight.isHidden = false
    }
    
    private func layout3() {
        // Rectangle disappears
        imageRectangleUp.isHidden = true
        imageRectangleDown.isHidden = true
        btnRectangleDown.isHidden = true
        btnRectangleUp.isHidden = true
        
        // Square Appears
        imageSquareDownLeft.isHidden = false
        imageSquareDownRight.isHidden = false
        imageSquareTopLeft.isHidden = false
        imageSquareTopRight.isHidden = false
        btnSquareDownLeft.isHidden = false
        btnSquareDownRight.isHidden = false
        btnSquareTopRight.isHidden = false
        btnSquareTopLeft.isHidden = false
    }

    // ----- Button -----
    
    // Layout 1
    @IBAction func btnImageRectangleTop(_ sender: Any) {
        activeImageView = 4
        pickImageToLibrairie()
    }
    @IBAction func btnImageSquareDownLeft(_ sender: Any) {
        activeImageView = 5
        pickImageToLibrairie()
    }
    @IBAction func btnImageSquareDownRight(_ sender: Any) {
        activeImageView = 6
        pickImageToLibrairie()
    }
    
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
    
    
    // Button Layout
    
    @IBAction func btnLayout1(_ sender: Any) {
        layout1()
    }
    @IBAction func btnLayout2(_ sender: Any) {
        layout2()
    }
    @IBAction func btnLayout3(_ sender: Any) {
        layout3()
    }
    
    
    //  3 Func to add new photo in a good imageView
    
    func pickImageToLibrairie() {
        let imagePick = UIImagePickerController()
        imagePick.sourceType = .photoLibrary
        imagePick.delegate = self
        self.present(imagePick, animated: true, completion: nil)
    }
    
    private func witchImageView(nb: Int) -> UIImageView {
        switch activeImageView {
        case 1:
            return imageSquareTopLeft
        case 2:
            return imageSquareTopRight
        case 3:
            return imageRectangleDown
        case 4:
            return imageRectangleUp
        case 5:
            return imageSquareDownLeft
        case 6:
            return imageSquareDownRight
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

