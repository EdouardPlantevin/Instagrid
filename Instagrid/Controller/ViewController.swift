//
//  ViewController.swift
//  Instagrid
//
//  Created by Edouard PLANTEVIN on 07/05/2019.
//  Copyright © 2019 Edouard PLANTEVIN. All rights reserved.
//

import UIKit

// extension to render UIView to UIImage
extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
}


class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    // ImageView
    
    /* Label swipe + image Up or Left */
    
    @IBOutlet weak var imageSwipe: UIImageView!
    @IBOutlet weak var labelSwipe: UILabel!
    
        
    /* ---- Button LayoutImage ----- */
    
    @IBOutlet weak var btnRectangleUp: UIButton!
    @IBOutlet weak var btnSquareDownLeft: UIButton!
    @IBOutlet weak var btnSquareDownRight: UIButton!
    @IBOutlet weak var btnSquareTopLeft: UIButton!
    @IBOutlet weak var btnSquareTopRight: UIButton!
    @IBOutlet weak var btnRectangleDown: UIButton!
    
    /* Button Layout */
    
    @IBOutlet weak var btnLayout1: UIButton!
    @IBOutlet weak var btnLayout2: UIButton!
    @IBOutlet weak var btnLayout3: UIButton!
    
    /* View to share */
    
    @IBOutlet weak var viewToShare: UIView!
    
    
    //Witch ImageView user click
    var activeButtonView = 0
    // Wtich current Layout , default Layout 2
    var currentLayout = 2
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout2()
        // Do any additional setup after loading the view.
        
    
        // SwipeGesture 
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(shareSwipe(sender:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(shareSwipe(sender:)))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
        
        //$$$$$$$$ ?? disparait sinon ??$$$$$$$$$$
        imageSwipe.image = UIImage(named: "Arrow Up")
        
    }
    
    // Rotation
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            labelSwipe.text = "Swipe left to share"
            imageSwipe.image = UIImage(named: "Arrow Left")

        } else {

            labelSwipe.text = "Swipe up to share"
            imageSwipe.image = UIImage(named: "Arrow Up")
        }
    }


    
    // Share
    
    @objc func shareSwipe(sender: UISwipeGestureRecognizer) {
        let image = UIImage(view: viewToShare)
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    
    // Layout
    
    private func layout1() {
        
        currentLayout = 1
        //layout 1 appaear
        btnRectangleUp.isHidden = false
        btnSquareDownLeft.isHidden = false
        btnSquareDownRight.isHidden = false
        
        //layout 2 hidden
        btnSquareTopLeft.isHidden = true
        btnRectangleDown.isHidden = true
        btnSquareTopRight.isHidden = true
    }
    
    private func layout2() {
        
        currentLayout = 2
        //layout 1 appaear
        btnRectangleUp.isHidden = true
        btnSquareDownLeft.isHidden = true
        btnSquareDownRight.isHidden = true
        
        //layout 2 hidden
        btnSquareTopLeft.isHidden = false
        btnRectangleDown.isHidden = false
        btnSquareTopRight.isHidden = false
    }
    
    private func layout3() {
        
        currentLayout = 3
        // Rectangle disappears
        btnRectangleDown.isHidden = true
        btnRectangleUp.isHidden = true
        
        // Square Appears
        btnSquareDownLeft.isHidden = false
        btnSquareDownRight.isHidden = false
        btnSquareTopRight.isHidden = false
        btnSquareTopLeft.isHidden = false
    }

    // ----- Button -----
    
    @IBAction func btnImageSquareTopLeft(_ sender: Any) {
        activeButtonView = 1
        pickImageToLibrairie()
    }
    @IBAction func btnImageSquareTopRight(_ sender: Any) {
        activeButtonView = 2
        pickImageToLibrairie()
    }
    @IBAction func btnImageRectangleDown(_ sender: Any) {
        activeButtonView = 3
        pickImageToLibrairie()
    }
    @IBAction func btnImageRectangleTop(_ sender: Any) {
        activeButtonView = 4
        pickImageToLibrairie()
    }
    @IBAction func btnImageSquareDownLeft(_ sender: Any) {
        activeButtonView = 5
        pickImageToLibrairie()
    }
    @IBAction func btnImageSquareDownRight(_ sender: Any) {
        activeButtonView = 6
        pickImageToLibrairie()
    }
    
    // Button Layout
    
    @IBAction func btnLayout1(_ sender: Any) {
        btnLayout1.setImage(UIImage(named: "Selected"), for: .normal) // add image "Selected.png"
        btnLayout2.setImage(nil, for: .normal)
        btnLayout3.setImage(nil, for: .normal)
        layout1()
    }
    @IBAction func btnLayout2(_ sender: Any) {
        btnLayout2.setImage(UIImage(named: "Selected"), for: .normal)
        btnLayout1.setImage(nil, for: .normal)
        btnLayout3.setImage(nil, for: .normal)
        layout2()
    }
    @IBAction func btnLayout3(_ sender: Any) {
        btnLayout3.setImage(UIImage(named: "Selected"), for: .normal)
        btnLayout2.setImage(nil, for: .normal)
        btnLayout1.setImage(nil, for: .normal)
        layout3()
    }
        
    //  3 Func to add new photo in a good imageView
    
    private func pickImageToLibrairie() {
        let imagePick = UIImagePickerController()
        imagePick.sourceType = .photoLibrary
        imagePick.delegate = self
        self.present(imagePick, animated: true, completion: nil)
    }
    
    private func witchButton(nb: Int) -> UIButton {
        switch activeButtonView {
        case 1:
            return btnSquareTopLeft
        case 2:
            return btnSquareTopRight
        case 3:
            return btnRectangleDown
        case 4:
            return btnRectangleUp
        case 5:
            return btnSquareDownLeft
        case 6:
            return btnSquareDownRight
        default:
            return btnSquareTopLeft
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagePick = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            witchButton(nb: activeButtonView).setImage(imagePick, for: .normal)
            witchButton(nb: activeButtonView).subviews.first?.contentMode = .scaleAspectFill
            
        }
        self.dismiss(animated: true, completion: nil)
    }
}

