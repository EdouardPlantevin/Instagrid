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
    @IBOutlet var arrayButtonImage: [UIButton]!
    
    /* Button Layout */
    @IBOutlet var arrayButtonLayout: [UIButton]!
    
    /* View to share */
    @IBOutlet weak var viewToShare: UIView!
    
    //Witch button user click, Useful for func 'witchButton()'
    var activeButtonView: UIButton?
    var layout: Layout?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout = Layout(arrayButtonImage: arrayButtonImage, arrayButtonLayout: arrayButtonLayout)
        // Do any additional setup after loading the view.
        

        // SwipeGesture 
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(shareSwipe(sender:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(shareSwipe(sender:)))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
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
        if (UIDevice.current.orientation.isLandscape && sender.direction == .left) || (UIDevice.current.orientation.isPortrait && sender.direction == .up) {  // if landscape && swipe left
            viewToShareGoOut() // Animation go out
                
            let image = UIImage(view: viewToShare) // Tranform View to ImageView
            let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            present(activityController, animated: true, completion: nil)
                
            // When activity controller done
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
            self.viewToShare.alpha = 0
        }
    }
    
    // Use for come back
    private func viewToShareComeback() {
        UIView.animate(withDuration: 0.5) {
            self.viewToShare.transform = .identity
            self.viewToShare.alpha = 1
        }
    }
    
    // ---------- Button ---------- //

    
    // Button Layout
    
    @IBAction func btnLayout(_ sender: Any) {
        let button: UIButton = sender as! UIButton
        layout!.changeLayout(witchLayout: button.accessibilityIdentifier!)
    }
        
    //  All buttonImage call pickImageToLibrairie
    
    @IBAction func pickImageToLibrairie(_ sender: Any) {
        activeButtonView = sender as? UIButton
        let imagePick = UIImagePickerController()
        imagePick.sourceType = .photoLibrary
        imagePick.delegate = self
        self.present(imagePick, animated: true, completion: nil)
    }

    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagePick = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            activeButtonView!.setImage(imagePick, for: .normal)
            activeButtonView!.subviews.first?.contentMode = .scaleAspectFill
        }
        self.dismiss(animated: true, completion: nil)
    }
}

