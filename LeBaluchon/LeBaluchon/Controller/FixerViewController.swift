//
//  ViewController.swift
//  LeBaluchon
//
//  Created by ayite  on 10/10/2020.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    
    @IBOutlet weak var currencyToConvert: UITextField!
    @IBOutlet weak var displayCurrencyConverted: UITextField!
    private var currencyInfo : Currency?
    private let fixerService = FixerService()
    private var currentForConvert : Double = 0.0
    private let numericPatern = "[0-9]";
    
    // MARK: - Cycle life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyToConvert.text = "1"
        displayCurrency()
    }
    
    // MARK: - Methodes
    
    @IBAction func convertCurrency(_ sender: Any) {
        calculate()
    }
    
    func calculate(){
        if currencyToConvert.text == "" {
            print("lol")
            displayCurrencyConverted.text = "0.0"
        }else {
            if let numberToConvert = Double(currencyToConvert.text!) {
                let result = currentForConvert * numberToConvert
                displayCurrencyConverted.text = String(format: "%.2f", result)
            } else {
                currencyToConvert.text?.removeLast()
                let alertMessage = "Your inscription is not correct"
                showAlert(with : alertMessage)
            }
        }
    }
    
}

extension ViewController {
    
    func displayCurrency(){
        fixerService.getFixerData { [unowned self] result in
            switch result {
            case .success(let currency):
                DispatchQueue.main.async {
                    self.currencyInfo = currency
                    if let currency = self.currencyInfo{
                        currentForConvert = currency.rates["USD"] ?? 0.0
                        calculate()
                    }
                }
            case .failure(let error):
                self.showAlert(with: error.description)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}


