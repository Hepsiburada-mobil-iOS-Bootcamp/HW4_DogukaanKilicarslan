//
//  MovieService.swift
//  MoviesSwiftUI
//
//  Created by DarkBringer on 15.10.2021.
//

import Foundation

typealias MovieResponseCompletionBlock = (Result<MovieResponse, MovieError>) -> Void
typealias MovieCompletionBlock = (Result<Movie, MovieError>) -> Void

protocol MovieService {
    
    //MARK: - To fetch the movie list
    func fetchMovies(from endpoint: MovieListEndPoint, completion: @escaping MovieResponseCompletionBlock)
    //MARK: - To fetch the detail of one movie
    func fetchMovie(id: Int, completion: @escaping MovieCompletionBlock)
    //MARK: - To search movies with a query
    func searchMovie(query: String, completion: @escaping MovieResponseCompletionBlock)
}


//MARK: - MovieList endpoints given by the api

enum MovieListEndPoint: String {
    case nowPlaying = "now_playing"
    case upcoming, popular
    case topRated = "top_rated"
    
    var description: String {
        switch self {
            case .nowPlaying: return "Now Playing"
            case .upcoming: return "Upcoming"
            case .popular: return "Popular"
            case .topRated: return "Top Rated"
        }
    }
}

//MARK: - Carousel Lists Titles

enum MovieListTitle: String {
    case nowPlaying = "Now Playing"
    case upcoming = "Upcoming"
    case popular = "Popular"
    case topRated = "Top Rated"
}


//MARK: - Handling the errors like a *BOSS*

enum MovieError: Error, CustomNSError {
    
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    var localizedDescription: String {
        switch self {
            case .apiError: return "Failed to fetch data"
            case .invalidEndpoint: return "Invalid endpoint"
            case .invalidResponse: return "Invalid response"
            case .noData: return "No Data"
            case .serializationError: return "Failed to decode data"
        }
    }
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey : localizedDescription]
    }
}
