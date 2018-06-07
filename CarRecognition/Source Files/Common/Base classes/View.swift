//
//  View.swift
//  CarRecognition
//


import UIKit

/// Base class for UIView sublclasses to remove boilerplate from custom views
internal class View: UIView {
    
    /// Indicating if keyboard should be closed on touch
    var closeKeyboardOnTouch = true
    
    /// - SeeAlso: NSCoding.init?(coder:)
    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Initialize an instance and calls required methods
    init() {
        super.init(frame: .zero)
        guard let setupableView = self as? ViewSetupable else { return }
        setupableView.setupView()
    }
    
    /// - SeeAlso: UIView.touchesBegan()
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if closeKeyboardOnTouch {
            endEditing(true)
        }
    }
}
