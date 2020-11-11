//
//  TranslationViewController.swift
//  LeBaluchon
//
//  Created by ayite  on 20/10/2020.
//

import UIKit

class TranslationViewController: UIViewController {
    
    @IBOutlet weak var textToTranslate: UITextField!
    @IBOutlet weak var translatedTextFeild: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        alertCollection = GTAlertCollection(withHostViewController: self)
//        checkForLanguagesExistence()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        checkForLanguagesExistence()
    }
    
//    deinit {
//        alertCollection = nil
//    }
    
    
    @IBAction func detectedLanguage(_ sender: Any) {
//        print("||----------------------- FONCTION DETECTedLANGUAGE ----------------------||")
//        guard let textToTranslate = textToTranslate.text else {return}
//        if textToTranslate != "" {
//            // Present a "Please wait..." buttonless alert with an activity indicator.
//            TranslationManager.shared.detectLanguage(forText: textToTranslate) { (language) in
//                
//                // Dismiss the buttonless alert.
//                self.alertCollection.dismissAlert(completion: nil)
//                
//                if let language = language {
//                    // Present an alert with the detected language.
//                    print("withTitle: Detect Language, message: The following language was detected:\n\n\(language)")
//                    self.alertCollection.presentSingleButtonAlert(withTitle: "Detect Language", message: "The following language was detected:\n\n\(language)", buttonTitle: "OK", actionHandler: {
//                        
//                    })
//                    
//                } else {
//                    // Present an alert saying that an error occurred.
//                    self.alertCollection.presentSingleButtonAlert(withTitle: "Detect Language", message: "Oops! It seems that something went wrong and language cannot be detected.", buttonTitle: "OK", actionHandler: {
//                        
//                    })
//                }
//            }
//            TranslationManager.shared.textToTranslate = textToTranslate
//            initiateTranslation()
//        }
    }
    
//    func checkForLanguagesExistence() {
//        // Check if supported languages have been fetched by looking at the
//        // number of items in the supported languages collection of the
//        // TranslationManager shared instance.
//        //we fetch them now.
//        if TranslationManager.shared.supportedLanguages.count == 0 {
//            TranslationManager.shared.fetchSupportedLanguages(completion: { (success) in
//                //                     Check if supported languages were fetched successfully or not.
//                if success {
//                    // Display languages in the tableview.
//                    print("==========   SUCCES FETCHSUPPORTEDELANGUAGES     ============")
//                } else {
//                    // Show an alert saying that something went wrong.
//                    self.alertCollection.presentSingleButtonAlert(withTitle: "Supported Languages", message: "Oops! It seems that something went wrong and supported languages cannot be fetched.", buttonTitle: "OK", actionHandler: {
//                        
//                    })
//                }
//            })
//        }
//    }
//    
//    func initiateTranslation() {
//        // Present a "Please wait..." alert.
//        alertCollection.presentActivityAlert(withTitle: "Translation", message: "Your text is being translated...") { (presented) in
//            if presented {
//                
//                TranslationManager.shared.translate(completion: { (translation) in
//                    
//                    // Dismiss the buttonless alert.
//                    self.alertCollection.dismissAlert(completion: nil)
//                    
//                    if let translation = translation {
//                        
//                        DispatchQueue.main.async { [unowned self] in
//                            self.translatedTextFeild.text = translation
//                        }
//                        
//                    } else {
//                        self.alertCollection.presentSingleButtonAlert(withTitle: "Translation", message: "Oops! It seems that something went wrong and translation cannot be done.", buttonTitle: "OK", actionHandler: {
//                            
//                        })
//                    }
//                    
//                })
//                
//            }
//        }
//    }
    
}
