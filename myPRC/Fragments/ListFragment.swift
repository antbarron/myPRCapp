import UIKit

class ListFragment: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Create the buttons using the band names and ids from BandDatabase
        let bandList = PRCDatabase.getInstance().getBands()
        let topMargin = view.frame.height * 0.2 // 20% of parent view's height
        
        for i in 0..<bandList.count {
            let button = UIButton(type: .system)
            if let band = PRCDatabase.getInstance().getBand(bandId: i + 1) {
                button.setTitle(band.name, for: .normal) // Assuming name is the property in PRC
                button.tag = band.id
                button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
                view.addSubview(button)
                // Add constraints to the button
                button.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: view.topAnchor, constant: topMargin + CGFloat(50 * i + 20)),
                    button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                    button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
                ])
            }
        }
    }
    
    @objc func buttonClicked(_ sender: UIButton) {
        // Start DetailsActivity
        let detailsVC = DetailsActivity()
        detailsVC.bandId = sender.tag
        // Check if ListFragment is embedded within a navigation controller
        if let navigationController = self.navigationController {
            navigationController.pushViewController(detailsVC, animated: true)
        } else {
            // If ListFragment is not embedded within a navigation controller, create one
            let navController = UINavigationController(rootViewController: detailsVC)
            present(navController, animated: true, completion: nil)
        }
    }
}
