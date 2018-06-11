//
//  AlertPresentable.swift
//  CarRecognition
//


import UIKit.UIAlertController

/// Protocol adding convenience methods for showing alerts inside view controller
internal protocol AlertPresentable { }

internal extension AlertPresentable where Self: UIViewController {
    
    /// Shows default Alert with single OK button
    ///
    /// - Parameters:
    ///   - message: Message to display on the alert
    ///   - title: Title to display on the alert, nil means no title to display
    ///   - onTap: Callback invoked after OK button was tapped
    func showAlert(withMessage message: String, title: String? = nil, onTap: ((UIAlertAction) -> (Void))? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: Localizable.Common.ok, style: .default, handler: onTap)
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion: nil)
    }
    
    /// Shows confirmation alert with destructive styled confirmation button
    ///
    /// - Parameters:
    ///   - title: Title of the alert
    ///   - message: Message to display on the alert
    ///   - confirmButtonText: Text of the confirmation button
    ///   - onConfirmTap: Callback called after tapping confirmation button
    func showDestructiveConfirmationAlert(withTitle title: String, message: String, confirmButtonText: String, onConfirmTap: @escaping (UIAlertAction) -> (Void)) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: confirmButtonText, style: .destructive, handler: onConfirmTap)
        alertController.addAction(UIAlertAction(title: Localizable.Common.cancel, style: .cancel))
        alertController.addAction(confirmAction)
        present(alertController, animated: true, completion: nil)
    }
}
