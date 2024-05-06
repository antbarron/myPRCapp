//
//  PRC.swift
//  myPRC
//
//  Created by Anthony on 5/3/24.
//

import Foundation
class PRC {
    var id: Int
    var name: String
    var description: String
    
    init() {
        id = 0
        name = ""
        description = ""
    }
    
    init(id: Int, name: String, description: String) {
        self.id = id
        self.name = name
        self.description = description
    }
}
