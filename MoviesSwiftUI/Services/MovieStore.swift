//
//  MovieStore.swift
//  MoviesSwiftUI
//
//  Created by DarkBringer on 15.10.2021.
//

import Foundation

class MovieStore: MovieService {
    
    

    //MARK: - We only need to init this property once and we always be able to reach it
    static let shared = MovieStore()
    private init() {}
    
    private let apiKey = "7973ec526981a0f622e44ebcbd44670a"
    private let baseApiUrl = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utilities.jsonDecoder
    
    
    func fetchMovies(from endpoint: MovieListEndPoint, completion: @escaping MovieResponseCompletionBlock) {
        guard let url = URL(string: "\(baseApiUrl)/movie/\(endpoint.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    func fetchMovie(id: Int, completion: @escaping MovieCompletionBlock) {
        guard let url = URL(string: "\(baseApiUrl)/movie/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, params: [
            "append_to_response" : "videos,credits"
        ], completion: completion)
    }
    
    func searchMovie(query: String, completion: @escaping MovieResponseCompletionBlock) {
        guard let url = URL(string: "\(baseApiUrl)/search/movie/") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        //MARK: - Using the query below to get search
        self.loadURLAndDecode(url: url, params: [
            "language" : "en-US",
            "include_adult" : "false",
            "region" : "TR",
            "query" : query
        ], completion: completion)
    }
    
    //MARK: - Method to load and decode the url data using a generic method
    
    private func loadURLAndDecode<D: Decodable>(url: URL, params: [String : String]? = nil, completion: @escaping (Result<D, MovieError>) -> Void) {
        
        //MARK: - Check for the url and return an error if url comes with an error

        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        //MARK: - Create an array to query and check the parameters if its empty

        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map{ URLQueryItem(name: $0.key, value: $0.value)})
        }
        urlComponents.queryItems = queryItems
        
        //MARK: - Encoding format will be escaped if we make or get a mistake from the api url

        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        urlSession.dataTask(with: finalURL) { [weak self] data, response, error in

            //MARK: - make sure no retain cycles

            guard let self = self else { return }
            
            //MARK: - check if the error is nil
            if error != nil {
                self.executeCompletionHandlerInMainThread(with: .failure(.apiError), completion: completion)
                return
            }
            
            //MARK: - to handle unknown response from the api call
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeCompletionHandlerInMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
                
            //MARK: - to handle no data response from the api call
            guard let data = data else {
                self.executeCompletionHandlerInMainThread(with: .failure(.noData), completion: completion)
                return
            }
            
            
            //MARK: - ACTUAL DECODING OF THE DATA AFTER ALL THE CHECKS ABOVE

            do {
                let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
                self.executeCompletionHandlerInMainThread(with: .success(decodedResponse), completion: completion)
            } catch {
                self.executeCompletionHandlerInMainThread(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }
    
    //MARK: - turning the main thread queue into a method to ease of use

    private func executeCompletionHandlerInMainThread<D: Decodable>(with result: Result<D, MovieError>, completion: @escaping (Result<D, MovieError>) -> Void) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
