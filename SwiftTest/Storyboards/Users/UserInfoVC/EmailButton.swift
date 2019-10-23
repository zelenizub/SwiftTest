//
//  EmailButton.swift
//  SwiftTest
//
//  Created by Zeljko Ilic on 10/23/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

@objc
protocol EmailButtonDelegate: class {
    func openEmailComposer(with email: String)
}

@IBDesignable
class EmailButton: UIView {

    // MARK: - IBOutlet
    @IBOutlet weak var delegate: EmailButtonDelegate?

    // MARK: - Properties
    @IBInspectable
    var email: String = "" {
        didSet {
            textView.text = email
        }
    }

    private lazy var textView = {
        return UITextView(frame: frame)
    }()

    // MARK: - Init
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    // MARK: - Setup
    private func setupView() {
        addSubview(textView)
        textView.willMove(toSuperview: self)
        setupTextView()
        setupCostraints()
    }

    private func setupTextView() {
        textView.textContainerInset = UIEdgeInsets.zero
        textView.textContainer.lineFragmentPadding = 0.0
        textView.isEditable = false
        textView.isSelectable = true
        textView.dataDetectorTypes = [.link]
        textView.font = UIFont.systemFont(ofSize: 17.0)
        textView.delegate = self
    }

    private func setupCostraints() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [.top, .bottom, .leading, .trailing].map {
            NSLayoutConstraint(
                item: textView,
                attribute: $0,
                relatedBy: .equal,
                toItem: self,
                attribute: $0,
                multiplier: 1.0,
                constant: 0.0
            )
        }
        addConstraints(constraints)
    }
}

extension EmailButton: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        delegate?.openEmailComposer(with: email)
        return false
    }
}
