//
//  MovieModel.swift
//  IMDb-Movies&Series
//
//  Created by DarkBringer on 14.10.2021.
//

import Foundation

// MARK: - MovieResponse
struct MovieResponse: Decodable {
    
    let results: [Movie]
    
}

// MARK: - Result
struct Movie: Decodable, Identifiable {
    
    let backdropPath: String?
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let voteCount: Int
    let voteAverage: Double
    let runtime: Int?
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
}

//MARK: - Image


//public struct ImagePoster: Codable {
//    public let path: String
//    public let imageExtension: Extension
//    
//    enum CodingKeys: String, CodingKey {
//        case path
//        case imageExtension = "extension"
//    }
//}
//
//public enum Extension: String, Codable {
//    case gif = "gif"
//    case jpg = "jpg"
//    case unknown = "unknown"
//}
//
//extension Extension {
//    public init(from decoder: Decoder) throws {
//        self = try Extension(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
//    }
//}
