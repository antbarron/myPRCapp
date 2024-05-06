import UIKit

class DetailsFragment: UIViewController {
    
    // Define the description label
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0 // Allow multiple lines for description
        label.textAlignment = .center // Center align text
        return label
    }()
    
    var bandId: Int = 0 // Default value
    var descriptions: [String] = [] // Array to hold descriptions
    
    // Initialize the fragment with bandId and descriptions
    init(bandId: Int, descriptions: [String]) {
        self.bandId = bandId
        
        self.descriptions = descriptions
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white // Set background color to white

        setupUI()
        loadBandDetails()
    }
    
    func setupUI() {
        // Add descriptionLabel to the view hierarchy
        view.addSubview(descriptionLabel)
        
        // Configure constraints for descriptionLabel to center vertically
        NSLayoutConstraint.activate([
            descriptionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor), // Center vertically
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func loadBandDetails() {
        // Fetch band details from PRCDatabase using bandId
        guard let band = PRCDatabase.getInstance().getBand(bandId: bandId) else {
            descriptionLabel.text = "Band details not found"
            return
        }
        
        // Convert HTML string to attributed string
        if let attributedString = try? NSAttributedString(data: band.description.data(using: .utf8)!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            // Set attributed text to label
            descriptionLabel.attributedText = attributedString
        } else {
            // Error handling if conversion fails
            descriptionLabel.text = "Error rendering description"
        }
    }
}
