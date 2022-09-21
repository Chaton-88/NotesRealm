//
//  UIKit + extension.swift
//  Note_Realm
//
//  Created by Valeriya Trofimova on 14.06.2022.
//

import Foundation
import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont, textColor: UIColor) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = textColor
    }
    
    convenience init(text: String, font: UIFont, textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.textAlignment = textAlignment
    }
}
