//
//  MovieListView.swift
//  MoviesSwiftUI
//
//  Created by DarkBringer on 15.10.2021.
//

import SwiftUI

struct MovieListView: View {
    
    @ObservedObject private var nowPlayingState = MovieListState()
    @ObservedObject private var upcomingState = MovieListState()
    @ObservedObject private var topRatedState = MovieListState()
    @ObservedObject private var popularState = MovieListState()

    var body: some View {
        NavigationView {
            List {
                Group {
                    //MARK: - if nowPlaying list exists we show the list
                    if nowPlayingState.movies != nil {
                        MovieLongCardCarousel(title: MovieListTitle.nowPlaying.rawValue, movies: nowPlayingState.movies!)
                        
                        //MARK: - if its empty we show the LoadingView and call the list api to populate the list
                    } else {
                        LoadingView(isLoading: nowPlayingState.isLoading, error: nowPlayingState.error) {
                            self.nowPlayingState.loadMovies(with: .nowPlaying)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top:8, leading: 0, bottom: 16, trailing: 0))
                
                Group {
                    //MARK: - if Upcoming list exists we show the list
                    if upcomingState.movies != nil {
                        MovieWideCardCarousel(title: MovieListTitle.upcoming.rawValue, movies: upcomingState.movies!)
                        
                        //MARK: - if its empty we show the LoadingView and call the list api to populate the list
                    } else {
                        LoadingView(isLoading: upcomingState.isLoading, error: upcomingState.error) {
                            self.upcomingState.loadMovies(with: .upcoming)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top:8, leading: 0, bottom: 16, trailing: 0))
                
                Group {
                    //MARK: - if Upcoming list exists we show the list
                    if topRatedState.movies != nil {
                        MovieWideCardCarousel(title: MovieListTitle.topRated.rawValue, movies: topRatedState.movies!)
                        
                        //MARK: - if its empty we show the LoadingView and call the list api to populate the list
                    } else {
                        LoadingView(isLoading: topRatedState.isLoading, error: topRatedState.error) {
                            self.topRatedState.loadMovies(with: .topRated)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top:8, leading: 0, bottom: 16, trailing: 0))
                
                Group {
                    //MARK: - if Upcoming list exists we show the list
                    if popularState.movies != nil {
                        MovieWideCardCarousel(title: MovieListTitle.popular.rawValue, movies: popularState.movies!)
                        
                        //MARK: - if its empty we show the LoadingView and call the list api to populate the list
                    } else {
                        LoadingView(isLoading: popularState.isLoading, error: popularState.error) {
                            self.popularState.loadMovies(with: .popular)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top:8, leading: 0, bottom: 16, trailing: 0))
                
            }
            .navigationBarTitle("The Movie DataBase")
        }
        .onAppear {
            self.nowPlayingState.loadMovies(with: .nowPlaying)
            self.popularState.loadMovies(with: .popular)
            self.topRatedState.loadMovies(with: .topRated)
            self.upcomingState.loadMovies(with: .upcoming)
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
