//
//  Movie+Stub.swift
//  IMDb-Movies&Series
//
//  Created by DarkBringer on 14.10.2021.
//

import Foundation

//MARK: - SWIFTUI PREVIEW STUBS

extension Movie {
    
    static var dummyMovies: [Movie] {
        let response: MovieResponse? = try? Bundle.main.loadAndDecodeJSON(filename: "movie_list")
        return response!.results
    }
    
    static var dummyMovie: Movie {
        dummyMovies[0]
    }
    
}

extension Bundle {
    
    //MARK: - to decode the data from the dummy resources

    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let jsonDecoder = Utilities.jsonDecoder
        let decodedModel = try jsonDecoder.decode(D.self, from: data)
        return decodedModel
    }
}
