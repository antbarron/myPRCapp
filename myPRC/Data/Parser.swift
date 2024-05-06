//
//  Parser.swift
//  myPRC
//
//  Created by Anthony on 5/3/24.
//
import Foundation

struct Band {
    let name: String
    let description: String
}

func parseBandsFromXML() -> [Band] {
    var bands: [Band] = []
    
    // Load the XML file
    guard let path = Bundle.main.path(forResource: "bands", ofType: "xml") else {
        return bands
    }
    
    guard let data = FileManager.default.contents(atPath: path) else {
        return bands
    }
    
    // Parse the XML data
    let parser = XMLParser(data: data)
    let delegate = BandXMLParserDelegate()
    parser.delegate = delegate
    parser.parse()
    
    // Extract bands from the parser's delegate
    bands = delegate.bands
    
    return bands
}

class BandXMLParserDelegate: NSObject, XMLParserDelegate {
    var bands: [Band] = []
    var currentElement: String?
    var currentName: String?
    var currentDescription: String?
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if currentElement == "item" {
            currentName = ""
            currentDescription = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if currentElement == "item" {
            currentName? += string
            currentDescription? += string
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            if let name = currentName, let description = currentDescription {
                let band = Band(name: name, description: description)
                bands.append(band)
            }
        }
        currentElement = nil
    }
}
