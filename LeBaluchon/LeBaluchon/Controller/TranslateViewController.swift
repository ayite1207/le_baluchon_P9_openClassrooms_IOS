//
//  TranslateViewController.swift
//  LeBaluchon
//
//  Created by ayite  on 28/10/2020.
//

import UIKit

class TranslateViewController: UIViewController {
    var translation :  TranslateString?
    let translateService =  TranslateService()
    let stringToTranslate = "La voiture est noir"
    @IBOutlet weak var textToTranslateTextField: UITextField!
    @IBOutlet weak var translatedTextTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        sentenceToTranslate()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func translateText(_ sender: Any) {
//        stringToTranslate()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TranslateViewController {
    func sentenceToTranslate(){
        guard let textToTranslate = textToTranslateTextField.text else {return}
        print(textToTranslate)
        translateService.stringToTranslate = stringToTranslate
        translateService.getData { [unowned self] result in
            switch result {
            case .success(let sentence):
                DispatchQueue.main.async {
                    self.translation = sentence
                    if let translation = self.translation{
                        print(translation.data.translations[0])
                    }
                }
            case .failure(let error):
                self.showAlert(with: error.description)
            }
        }
    }
}
