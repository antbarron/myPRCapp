//
//  DetailsActivity.swift
//  myPRC
//
//  Created by Anthony on 5/3/24.
//
import Foundation

import UIKit

class DetailsActivity: UIViewController {
    
    var bandId: Int = 0 // Default value, change it according to your requirements
    var bandDescriptions: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Obtain the bandId from the ListFragment or any other source
        // For simplicity, I'm assuming it's already set before this view is loaded
        
        // Retrieve band details from the PRCDatabase
        guard let band = PRCDatabase.getInstance().getBand(bandId: bandId) else {
            // Handle the case when band details are not available
            print("Band details not found")
            return
        }
        
        // Extract descriptions from the band details
        bandDescriptions = band.description.components(separatedBy: ",")
        
        // Instantiate the DetailsFragment with bandId and descriptions
        let detailsFragment = DetailsFragment(bandId: bandId, descriptions: bandDescriptions)
        
        // Add DetailsFragment as a child view controller
        addChild(detailsFragment)
        view.addSubview(detailsFragment.view)
        detailsFragment.didMove(toParent: self)
    }
}
