//
//  ViewController.swift
//  ArabicUI
//
//  Created by Devika on 02/11/2026.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: Label!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
        
    @IBOutlet weak var enButton: UIButton!
    @IBOutlet weak var arButton: UIButton!
    
    enum Lang: String {
        case en, ar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        if let userLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") {
            enButton.isSelected = userLanguage == Lang.en.rawValue
            enButton.isUserInteractionEnabled = !enButton.isSelected
            arButton.isSelected = userLanguage == Lang.ar.rawValue
            arButton.isUserInteractionEnabled = !arButton.isSelected
        }
        
        //welcomeLabel.text = NSLocalizedString("welcome", comment: "")
        nameLabel.text = String.localizedStringWithFormat(NSLocalizedString("name", comment: ""), "Devika")
        descriptionLabel.text = String.localizedStringWithFormat(NSLocalizedString("description", comment: ""), 1000, 2000)
        
        AVCaptureDevice.requestAccess(for: .video) { _ in }
    }

    @IBAction func enButtonAction(_ sender: Any) {
        reloadApp(lang: .en)
    }
    
    @IBAction func arButtonAction(_ sender: Any) {
        reloadApp(lang: .ar)
    }
    
    private func reloadApp(lang: Lang) {
        UserDefaults.standard.set(lang.rawValue, forKey: "selectedLanguage")
        UserDefaults.standard.set([lang.rawValue], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        // 2. Grab the active window scene
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        let targetAttribute: UISemanticContentAttribute = (lang == .ar) ? .forceRightToLeft : .forceLeftToRight
        window.semanticContentAttribute = targetAttribute

        // 3. Force appearance override for iOS 13+ to ensure UIKit components respect it
        UIView.appearance().semanticContentAttribute = targetAttribute
        
        // 4. Instantiate your Launch Screen storyboard or view controller
        let launchStoryboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        let launchVC = launchStoryboard.instantiateInitialViewController() ?? UIViewController()
        
        // 5. Temporarily show launch screen
        window.rootViewController = launchVC
        window.makeKeyAndVisible()
        
        // 6. After a short delay, load the actual root view controller with the new locale
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = mainStoryboard.instantiateInitialViewController()
            window.rootViewController = rootVC
        }
    }
}
