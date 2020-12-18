//
//  TranslateViewController.swift
//  LeBaluchon
//
//  Created by ayite  on 28/10/2020.
//

import UIKit

class TranslateViewController: UIViewController, DisplayViewControllerDelegate, UITextFieldDelegate {
    
    // MARK: - Properties
    
    var translation :  TranslateString?
    let translateService =  TranslateService()
    var languages :  Languages?
    var basicSentence = ""
    var translatedSentence = ""
    @IBOutlet weak var textToTranslateTextField: UITextField!
    @IBOutlet weak var basicLanguageUIButton: UIButton!
    @IBOutlet weak var languageOftraductionUIButton: UIButton!
    
    
    // MARK: - Cycle of life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textToTranslateTextField.delegate = self
        textToTranslateTextField.returnKeyType = .done
        getLanguages()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Methodes
    
    @IBAction func translateText(_ sender: Any) {
        sentenceToTranslate()
    }
    
    @IBAction func displayOriginalSentence(_ sender: Any) {
        textToTranslateTextField.text = basicSentence
    }
    
    @IBAction func displayLanguages(_ sender: Any) {
        if languages != nil {
            let langugesTableViewC = storyboard?.instantiateViewController(withIdentifier: "LanguagesTableViewController") as! LanguagesTableViewController
            langugesTableViewC.languages = languages
            langugesTableViewC.delegate = self
            self.present(langugesTableViewC, animated:true, completion:nil)
        } else {
            let alertMessage = "The data is not loaded please check your wifi connection"
            showAlert(with : alertMessage)
        }
    }
    
    private func sentenceToTranslate(){
        guard let textToTranslate = textToTranslateTextField.text else {return}
        
        if textToTranslate != "" {
            if textToTranslate == basicSentence {
                textToTranslateTextField.text = translatedSentence
            }else if textToTranslate == translatedSentence {
                textToTranslateTextField.text = translatedSentence
            }else {
                translateService.stringToTranslate = textToTranslate
                basicSentence = textToTranslate
                translationSentence()
            }
        } else {
            textToTranslateTextField.placeholder = "please vhrite something ! "
            translatedSentence = ""
            basicSentence = ""
        }
    }
    
    private func translationSentence(){
        translateService.getTranslationData { [unowned self] result in
            switch result {
            case .success(let sentence):
                DispatchQueue.main.async {
                    self.translation = sentence
                    if let translation = self.translation{
                        textToTranslateTextField.text = translation.data.translations[0].translatedText
                        translatedSentence = translation.data.translations[0].translatedText
                    }
                }
            case .failure(let error):
                self.showAlert(with: error.description)
            }
        }
    }
    
    private func getLanguages(){
        translateService.getLanguagesData { [unowned self] result in
            switch result {
            case .success(let languages):
                DispatchQueue.main.async {
                    self.languages = languages
                }
            case .failure(let error):
                self.showAlert(with: error.description)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sentenceToTranslate()
         return true
    }
    
}

extension TranslateViewController {
    
    // MARK: - Methodes
    
    func languageRecovery(name: String, language: String) {
        if textToTranslateTextField.text != translatedSentence {
            translatedSentence = ""
            basicSentence = ""
            translateService.basicTarget = language
            languageOftraductionUIButton.setTitle(name.uppercased(), for: .normal)
            sentenceToTranslate()
        }else if basicSentence != "" {
            translateService.stringToTranslate = basicSentence
            textToTranslateTextField.text = basicSentence
            translatedSentence = ""
            basicSentence = ""
            translateService.basicTarget = language
            languageOftraductionUIButton.setTitle(name.uppercased(), for: .normal)
            sentenceToTranslate()
        } else {
            translateService.basicTarget = language
            languageOftraductionUIButton.setTitle(name.uppercased(), for: .normal)
        }
    }
}

