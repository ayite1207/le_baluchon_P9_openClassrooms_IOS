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
    var currentForConvert : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currencyToConvert.text = "1"
        displayCurrency()
    }
    
    @IBAction func convertCurrency(_ sender: Any) {
        guard let stringAmount = currencyToConvert.text else {return}
        guard let doubleAmount = Double(stringAmount) else {return}
        displayCurrencyConverted.text = String(currentForConvert * doubleAmount)

    }

}

// MARK: CALL API FIXER

extension ViewController {
    
    func displayCurrency(){
        fixerService.getData { [unowned self] result in
            switch result {
            case .success(let currency):
                DispatchQueue.main.async {
                    self.currencyInfo = currency
                    if let currency = self.currencyInfo{
                        print(currency.rates["USD"])
                    }
                }
            case .failure(let error):
                self.showAlert(with: error.description)
            }
        }
    }
    
}

extension UIViewController {
    func showAlert(with message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true)
    }
}
