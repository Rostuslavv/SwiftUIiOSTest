//
//  NetworkingManager.swift
//  SwiftUIiOSTest
//
//  Created by Rostyslav Dydiak on 01.12.2023.
//

import Foundation

class LocalFilesProvider {
    let resource: String
    let resourceExtension: String
    
    init(resource name: String, resourceExtension ext: String) {
        self.resource = name
        self.resourceExtension = ext
    }
    
    func getData<T: Decodable>() throws -> T {
        guard let url = Bundle.main.url(forResource: resource, withExtension: resourceExtension) else {
            throw LocalFilesDecoderError.tempError
        }
        
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let loadedData = try decoder.decode(T.self, from: data)
        return loadedData
    }
}
