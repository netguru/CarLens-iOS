//
//  TextSwitcher.swift
//  CarRecognition
//


import UIKit

internal final class TextSwitcherView: View {
    
    private enum State {
        case firstLabelVisible
        case secondLabelVisible
    }

    private var currentText: String

    private var state: State = .firstLabelVisible

    private lazy var firstLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16, weight: .semibold)
        view.textColor = .white
        view.numberOfLines = 1
        view.textAlignment = .center
        view.text = currentText
        return view
    }()

    private lazy var secondLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16, weight: .semibold)
        view.textColor = .white
        view.numberOfLines = 1
        view.textAlignment = .center
        view.alpha = 0
        return view
    }()

    /// Initializes the view with given text's
    ///
    /// - Parameters:
    ///   - currentText: Initial visible text
    init(currentText: String) {
        self.currentText = currentText
        super.init()
    }

    /// - SeeAlso: UIView.layoutSubviews()
    override func layoutSubviews() {
        super.layoutSubviews()
        setupSubviews()
    }

    private func setupSubviews() {
        firstLabel.frame = CGRect(x: 0, y: frame.height / 2, width: frame.width, height: frame.height / 2)
        secondLabel.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: frame.height / 2)
    }
}

/// Text Switching
extension TextSwitcherView {
    
    /// Switches labels based on current state
    /// - Parameters:
    ///   - text: Text to be switched to
    func switchLabelsWithText(_ text: String) {
        guard text != currentText else { return }
        currentText = text
        switch state {
        case .firstLabelVisible: animateInSecondLabel()
        case .secondLabelVisible: animateInFirstLabel()
        }
    }

    private func animateInSecondLabel() {
        secondLabel.text = currentText
        UIView.animate(withDuration: 0.3, animations: {
            self.firstLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height / 2)
            self.firstLabel.alpha = 0
            self.secondLabel.frame = CGRect(x: 0, y: self.frame.height / 2, width: self.frame.width, height: self.frame.height / 2)
            self.secondLabel.alpha = 1
        }) { completed in
            self.state = .secondLabelVisible
            self.firstLabel.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: self.frame.height / 2)
            self.firstLabel.text = ""
        }
    }

    private func animateInFirstLabel() {
        firstLabel.text = currentText
        UIView.animate(withDuration: 0.3, animations: {
            self.firstLabel.frame = CGRect(x: 0, y: self.frame.height / 2, width: self.frame.width, height: self.frame.height / 2)
            self.firstLabel.alpha = 1
            self.secondLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height / 2)
            self.secondLabel.alpha = 0
        }) { completed in
            guard completed else { return }
            self.state = .firstLabelVisible
            self.secondLabel.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: self.frame.height / 2)
            self.secondLabel.text = ""
        }
    }
}

/// ViewSetupable
extension TextSwitcherView: ViewSetupable {

    /// See also - ViewSetupable
    func setupViewHierarchy() {
        [firstLabel, secondLabel].forEach(addSubview)
    }

    /// See also - ViewSetupable
    func setupConstraints() { }
}
