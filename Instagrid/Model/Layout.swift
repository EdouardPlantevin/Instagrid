//
//  Layout.swift
//  Instagrid
//
//  Created by Edouard PLANTEVIN on 01/06/2019.
//  Copyright © 2019 Edouard PLANTEVIN. All rights reserved.
//

import Foundation
import UIKit

class Layout {
    
    var arrayButtonImage: [UIButton]
    var arrayButtonLayout: [UIButton]
    
    enum Layout {
        case layout1
        case layout2
        case layout3
        
        static func enumFromString(witchLayout: String) -> Layout {
            switch witchLayout {
            case "layout1":
                return .layout1
            case "layout2":
                return .layout2
            case "layout3":
                return .layout3
            default:
                return .layout2
            }
        }
    }
    
    // Default Layout 2
    var currentLayout: Layout = .layout2
    
    
    init(arrayButtonImage: [UIButton], arrayButtonLayout: [UIButton]) {
        self.arrayButtonImage = arrayButtonImage
        self.arrayButtonLayout = arrayButtonLayout
        changeLayout(witchLayout: "layout2") // default currentLayout = .layout2
    }
    
    private func hiddenAllButtonImage(arrayButtonImage: [UIButton]) {
        for oneButtonImage in arrayButtonImage {
            oneButtonImage.isHidden = true
        }
    }
    
    private func removeAllImageOfButtonLayout(arrayButtonLayout: [UIButton]) {
        for oneButtonLayout in arrayButtonLayout {
            oneButtonLayout.setImage(nil, for: .normal)
        }
    }
    
    func changeLayout(witchLayout: String) {
        hiddenAllButtonImage(arrayButtonImage: arrayButtonImage)
        removeAllImageOfButtonLayout(arrayButtonLayout: arrayButtonLayout)
        
        currentLayout = Layout.enumFromString(witchLayout: witchLayout)
        
        for oneButtonImage in arrayButtonImage {
            switch currentLayout {
            case .layout1:
                if (oneButtonImage.accessibilityIdentifier!.contains("1")) {
                    oneButtonImage.isHidden = false
                    arrayButtonLayout[0].setImage(UIImage(named: "Selected"), for: .normal)
                }
            case .layout2:
                if (oneButtonImage.accessibilityLabel!.contains("2")) {
                    oneButtonImage.isHidden = false
                    arrayButtonLayout[1].setImage(UIImage(named: "Selected"), for: .normal)
                }
            case .layout3:
                if (oneButtonImage.accessibilityIdentifier!.contains("3")) {
                    oneButtonImage.isHidden = false
                    arrayButtonLayout[2].setImage(UIImage(named: "Selected"), for: .normal)
                }
            }
        }
    }
}
