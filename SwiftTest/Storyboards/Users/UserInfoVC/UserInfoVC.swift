//
//  UserInfoVC.swift
//  SwiftTest
//
//  Created by Zeljko Ilic on 10/21/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import MessageUI

class UserInfoVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var emailButton: EmailButton!

    // MARK: - Properties
    private var user: User?

    // MARK: - Setup
    func setup(with user: User) {
        self.user = user
    }

    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        populateWithData()
    }

    // MARK: - Utils
    private func populateWithData() {
        guard let user = user else {
            debugPrint("🔴 Unexpected nil user!")
            return
        }
        picture.loadImage(from: user.bigPictureUrl)
        firstNameLabel.text = user.name.first
        lastNameLabel.text = user.name.last
        ageLabel.text = user.age
        emailButton.email = user.email
    }
}

// MARK: - EmailButtonDelegate
extension UserInfoVC: EmailButtonDelegate {
    func openEmailComposer(with email: String) {
        guard MFMailComposeViewController.canSendMail() else {
            let alert = UIAlertController(title: "Error", message: "Failed to open the email composer", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
                self.openEmailComposer(with: email)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
         let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients([email])
        present(composer, animated: true, completion: nil)
    }
}

// MARK: - MFMailComposeViewControllerDelegate
extension UserInfoVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
         controller.dismiss(animated: true, completion: nil)
    }
}
