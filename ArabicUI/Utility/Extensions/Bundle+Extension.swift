//
//  Bundle+Extension.swift
//  ArabicUI
//
//  Created by Devika on 10/11/2026.
//

import UIKit

extension Bundle {
    static var localized: Bundle {
        struct Static {
            static let instance: Bundle = {
                // Swap main bundle class dynamically
                object_setClass(Bundle.main, LocalizedBundleManager.self)
                return Bundle.main
            }()
        }
        return Static.instance
    }
}
