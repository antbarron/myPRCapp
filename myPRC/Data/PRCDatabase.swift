//
//  PRCDatabase.swift
//  myPRC
//
//  Created by Anthony on 5/3/24.
//
import Foundation

struct PRC {
    let id: Int
    let name: String
    let description: String
}

class PRCDatabase {
    private static var sBandDatabase: PRCDatabase?
    private var mBands: [PRC] = []
    
    static func getInstance() -> PRCDatabase {
        if sBandDatabase == nil {
            sBandDatabase = PRCDatabase()
        }
        return sBandDatabase!
    }
    
    private init() {
        let bands = bandsFromResource()
        let descriptions = descriptionsFromResource()
        
        for (index, bandName) in bands.enumerated() {
            let description = index < descriptions.count ? descriptions[index] : ""
            mBands.append(PRC(id: index + 1, name: bandName, description: description))
        }
    }
    
    func getBands() -> [PRC] {
        return mBands
    }
    
    func getBand(bandId: Int) -> PRC? {
        return mBands.first { $0.id == bandId }
    }
    
    // Helper function to retrieve bands from resource strings
    private func bandsFromResource() -> [String] {
        return bands
    }
    
    // Helper function to retrieve descriptions from resource strings
    private func descriptionsFromResource() -> [String] {
        return descriptions
    }
}

