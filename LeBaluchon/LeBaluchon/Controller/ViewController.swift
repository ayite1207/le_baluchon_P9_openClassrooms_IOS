//
//  ViewController.swift
//  LeBaluchon
//
//  Created by ayite  on 10/10/2020.
//

import UIKit

class ViewController: UIViewController {
    
    var currencyInfo : Currency?
    @IBOutlet weak var currencyToConvert: UITextField!
    @IBOutlet weak var displayCurrencyConverted: UITextField!
    let fixerService = FixerService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayCurrency()
        currencyToConvert.text = "1"
    }
    
    @IBAction func convertCurrency(_ sender: Any) {
        convert()
    }
    
    func convert(){
        guard let currencyToConvertString = currencyToConvert.text, let currencyToConvert = Double(currencyToConvertString) else { return }
        guard let multiplicator = currencyInfo!.rates["USD"] else { return}
        displayCurrencyConverted.text = String(currencyToConvert * multiplicator)
    }
}

// MARK: CALL API FIXER

extension ViewController {
    
    func displayCurrency(){
        fixerService.getCurrency { [unowned self] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                }
            case .success(let currency) :
                DispatchQueue.main.async {
                    self.currencyInfo = currency
                    if let currency = self.currencyInfo{
                        print("1 euros vaut :  \(currency.rates["USD"]!)")
                    }
                }
                
            }
        }
    }
    
}
