//
//  Label.swift
//  ArabicUI
//
//  Created by Devika on 03/11/2026.
//

import UIKit

@IBDesignable
class Label: UILabel {
    @IBInspectable var localizationKey: String? {
        didSet {
            if let key = localizationKey {
                self.text = NSLocalizedString(key, comment: "")
            }
        }
    }
}
