//
//  renderViewtoImage.swift
//  Instagrid
//
//  Created by Edouard PLANTEVIN on 16/05/2019.
//  Copyright © 2019 Edouard PLANTEVIN. All rights reserved.
//

import UIkit


extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
}
