//
//  FormActivity.swift
//  myPRC
//
//  Created by Anthony on 5/3/24.
//

import Foundation
import UIKit
import MessageUI


class FormActivity: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var appointmentDayTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var appointmentTimeTextField: UITextField!
    @IBOutlet weak var resourceItemTextField: UITextField! // Added variable for resource item
    @IBOutlet weak var submitButton: UIButton!

    static let EXTRA_DESCRIPTION = "description" // Corrected extra key
    var resourceName: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Retrieve the selected resource item from the intent extra
        resourceItemTextField.text = resourceName

        // Set action for submit button
        submitButton.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
    }

    // Method to handle form submission
    @objc private func handleSubmit() {
        // Retrieve data from form fields
        guard let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let appointmentDay = appointmentDayTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let phoneNumber = phoneNumberTextField.text,
              let appointmentTime = appointmentTimeTextField.text else {
            // Display error message if any field is empty
            showToast(message: "Please fill out all fields")
            return
        }

        // Prepare email content with resource item included
        let subject = "Appointment Request"
        let message = "Name: \(name)\n" +
                      "Phone Number: \(phoneNumber)\n" +
                      "Best Day and Time: \(appointmentDay),\n \(appointmentTime)\n" +
                      "Appointment Type: \(resourceItemTextField.text ?? "")"

        // Create email intent
        if MFMailComposeViewController.canSendMail() {
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            mailComposer.setToRecipients(["info@prcgp.com"])
            mailComposer.setSubject(subject)
            mailComposer.setMessageBody(message, isHTML: false)
            present(mailComposer, animated: true, completion: nil)
        } else {
            showToast(message: "No email app found")
        }
    }
}

// MARK: - MFMailComposeViewControllerDelegate
extension FormActivity: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

// Helper function to show toast message
extension FormActivity {
    func showToast(message: String) {
        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - 150, y: view.frame.size.height-100, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
