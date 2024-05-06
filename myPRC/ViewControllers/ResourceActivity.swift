//
//  ResourceActivity.swift
//  myPRC
//
//  Created by Anthony on 5/3/24.
//

import SwiftUI
import UIKit

struct ResourceActivity: View {
    var body: some View {
        UIViewControllerWrapper()
            .edgesIgnoringSafeArea(.all)
            .background(Color.white) // Set background color if needed
    }
}

struct UIViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ResourceActivityViewController {
        let viewController = ResourceActivityViewController()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: ResourceActivityViewController, context: Context) {
        // Update the view controller if needed
    }
}

class ResourceActivityViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create and add ListFragment to the view hierarchy
        let listFragment = ListFragment()
        addChild(listFragment)
        view.addSubview(listFragment.view)
        listFragment.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            listFragment.view.topAnchor.constraint(equalTo: view.topAnchor),
            listFragment.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listFragment.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listFragment.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        listFragment.didMove(toParent: self)
    }
}
