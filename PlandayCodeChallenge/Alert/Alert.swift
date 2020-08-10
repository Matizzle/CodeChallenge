//
//  Alert.swift
//  PlandayCodeChallenge
//
//  Copyright © 2020 Mathias Lolk Andreasen. All rights reserved.

import Foundation
import UIKit

struct Alert {
    func presentAlert(vc: UIViewController, alertTitle: AlertTexts.title, alertMessage: AlertTexts.message) {
        let alertController = UIAlertController(title: alertTitle.rawValue, message: alertMessage.rawValue, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        vc.present(alertController, animated: true, completion: nil)
    }
}
