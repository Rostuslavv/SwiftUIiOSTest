//
//  JSONManager.swift
//  iOSMiddleTestTask
//
//  Created by Rostyslav Dydiak on 01.12.2023.
//

import Foundation

struct Cards: Codable {
    let vendors: [Vendor]
    
    static let allCards: [Cards] = Bundle.main.decode(file: "vendors.json")
}

struct Vendor: Codable {
    let id: Int
    let companyName, areaServed, shopType: String
    let favorited, follow: Bool
    let businessType: String
    let coverPhoto: CoverPhoto
    let categories: [Category]
    let tags: [Tag]
    
    enum CodingKeys: String, CodingKey {
        case id
        case companyName = "company_name"
        case areaServed = "area_served"
        case shopType = "shop_type"
        case favorited, follow
        case businessType = "business_type"
        case coverPhoto = "cover_photo"
        case categories, tags
    }
    
    static let allVendor: [Vendor] = Bundle.main.decode(file: "vendors.json")
}

struct Category: Codable {
    let id: Int
    let name: String
    let image: CoverPhoto
}

struct CoverPhoto: Codable {
    let id: Int
    let mediaURL: String
    let mediaType: MediaType
    
    enum CodingKeys: String, CodingKey {
        case id
        case mediaURL = "media_url"
        case mediaType = "media_type"
    }
}

enum MediaType: String, Codable {
    case image = "image"
}

struct Tag: Codable {
    let id: Int
    let name, purpose: String
}

extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not file \(file) in the project")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file) in the project")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode \(file) in the project")
        }
        
        return loadedData
    }
}
