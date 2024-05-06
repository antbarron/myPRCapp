//
//  MainActivity.swift
//  myPRC
//
//  Created by Anthony on 5/3/24.
//

import Foundation
import UIKit

class MainActivity: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // Method to handle clicks for all buttons
    @IBAction func clickCallback(_ sender: UIButton) {
        // Determine which button was clicked based on its tag
        if sender.tag == 1 {
            // Create an URL for services
            if let url = URL(string: "https://prcgp.com/contact") {
                UIApplication.shared.open(url)
            }
        } else if sender.tag == 2 {
            // Create an URL for events
            if let url = URL(string: "https://prcgp.com/services") {
                UIApplication.shared.open(url)
            }
        } else if sender.tag == 3 {
            // Create an URL for contact
            if let url = URL(string: "https://prcgp.com/events") {
                UIApplication.shared.open(url)
            }
        }
    }

    @IBAction func goToResourceActivity(_ sender: UIButton) {
        let resourceActivityVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResourceActivity")
        navigationController?.pushViewController(resourceActivityVC, animated: true)
    }
    
    @IBAction func sendTextMessage(_ sender: UIButton) {
        if let url = URL(string: "sms:4695632624") {
            UIApplication.shared.open(url)
        }
    }
}
