//
//  UIViewController+Alert.swift
//  LeBaluchon
//
//  Created by ayite on 20/11/2020.
//

import UIKit

extension UIViewController {
    func showAlert(with message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true)
    }
}
