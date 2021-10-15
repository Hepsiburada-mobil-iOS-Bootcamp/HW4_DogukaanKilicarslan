//
//  Utilities.swift
//  MoviesSwiftUI
//
//  Created by DarkBringer on 15.10.2021.
//

import Foundation

class Utilities {
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    static let dateFormatter: DateFormatter = {
       let dateFor = DateFormatter()
        dateFor.dateFormat = "yyyy-mm-dd"
        return dateFor
    }()
}
