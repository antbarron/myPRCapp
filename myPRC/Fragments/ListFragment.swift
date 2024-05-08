import UIKit

class ListFragment: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bandList = PRCDatabase.getInstance().getBands()
        let topMargin = view.frame.height * 0.2
        
        for i in 0..<bandList.count {
            let button = UIButton(type: .system)
            if let band = PRCDatabase.getInstance().getBand(bandId: i + 1) {
                button.setTitle(band.name, for: .normal)
                button.tag = band.id
                button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
                // Set button appearance
                button.backgroundColor = .clear
                button.layer.cornerRadius = 8
                button.layer.borderWidth = 1
                button.layer.borderColor = UIColor.white.cgColor
                button.setTitleColor(.white, for: .normal)
                view.addSubview(button)
                
                button.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: view.topAnchor, constant: topMargin + CGFloat(50 * i + 20)),
                    button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                    button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    button.heightAnchor.constraint(equalToConstant: 40) // Example height, adjust as needed
                ])
            }
        }
    }
    
    @objc func buttonClicked(_ sender: UIButton) {
        let detailsVC = DetailsActivity()
        detailsVC.bandId = sender.tag
        if let navigationController = self.navigationController {
            let detailsVC = DetailsActivity()
            detailsVC.bandId = sender.tag
            navigationController.pushViewController(detailsVC, animated: true)
        } else {
            let detailsVC = DetailsActivity()
            detailsVC.bandId = sender.tag
            let navController = UINavigationController(rootViewController: detailsVC)
            present(navController, animated: true, completion: nil)
        }
    }
}
