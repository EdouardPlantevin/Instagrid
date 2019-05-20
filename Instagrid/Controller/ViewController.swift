//
//  ViewController.swift
//  Instagrid
//
//  Created by Edouard PLANTEVIN on 07/05/2019.
//  Copyright © 2019 Edouard PLANTEVIN. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    // ---------- OUTLET ---------- //
    
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
    
    //Witch button user click, Useful for func 'witchButton()'
    var activeButtonView = 0
    
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
    
    
    // Rotation, change label + image swipe
    
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
        if UIDevice.current.orientation.isLandscape && sender.direction == .left {  // if landscape && swipe left
            viewToShareGoOut() // Animation go out
                
            let image = UIImage(view: viewToShare) // Tranform View to ImageView
            let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            present(activityController, animated: true, completion: nil)
                
            // When activity controller done
            activityController.completionWithItemsHandler = { activity, success, items, error in
                self.viewToShareComeback() // Animation come back
            }
        } else if UIDevice.current.orientation.isPortrait && sender.direction == .up {  // if portrait && swipe up
            viewToShareGoOut() // Animation go out
                
            let image = UIImage(view: viewToShare) // Tranform View to ImageView
            let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            present(activityController, animated: true, completion: nil)
                
            // When activity controller go away
            activityController.completionWithItemsHandler = { activity, success, items, error in
                self.viewToShareComeback() // Animation come back
            }
        }

    }
    
    // Animation of viewToShare
    
    // Use for go out
    private func viewToShareGoOut() {
        UIView.animate(withDuration: 0.5) {
            self.viewToShare.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
        }
    }
    
    // Use for come back
    private func viewToShareComeback() {
        UIView.animate(withDuration: 0.5) {
            self.viewToShare.transform = .identity
        }
    }
    
    
    // Layout
    
    private func layout1() {
        
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
        
        // Rectangle disappears
        btnRectangleDown.isHidden = true
        btnRectangleUp.isHidden = true
        
        // Square Appears
        btnSquareDownLeft.isHidden = false
        btnSquareDownRight.isHidden = false
        btnSquareTopRight.isHidden = false
        btnSquareTopLeft.isHidden = false
    }

    // ---------- Button ---------- //
    
    // Button pick image
    
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
        btnLayout2.setImage(nil, for: .normal) // delete image "Selected.png"
        btnLayout3.setImage(nil, for: .normal)
        layout1()
    }
    @IBAction func btnLayout2(_ sender: Any) {
        btnLayout1.setImage(nil, for: .normal)
        btnLayout2.setImage(UIImage(named: "Selected"), for: .normal)
        btnLayout3.setImage(nil, for: .normal)
        layout2()
    }
    @IBAction func btnLayout3(_ sender: Any) {
        btnLayout2.setImage(nil, for: .normal)
        btnLayout1.setImage(nil, for: .normal)
        btnLayout3.setImage(UIImage(named: "Selected"), for: .normal)
        layout3()
    }
        
    //  3 Func to add new photo in a good button
    
    private func pickImageToLibrairie() {
        let imagePick = UIImagePickerController()
        imagePick.sourceType = .photoLibrary
        imagePick.delegate = self
        self.present(imagePick, animated: true, completion: nil)
    }
    
    private func witchButton() -> UIButton {
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
            witchButton().setImage(imagePick, for: .normal)
            witchButton().subviews.first?.contentMode = .scaleAspectFill
        }
        self.dismiss(animated: true, completion: nil)
    }
}

