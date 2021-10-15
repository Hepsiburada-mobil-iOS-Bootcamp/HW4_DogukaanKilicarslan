//
//  MovieLongCardCarousel.swift
//  MoviesSwiftUI
//
//  Created by DarkBringer on 15.10.2021.
//

import SwiftUI

struct MovieLongCardCarousel: View {
    let title: String
    let movies: [Movie]
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(self.movies) { movie in
                        MovieLongCard(movie: movie)
                            .padding(.leading, movie.id == self.movies.first!.id ? 16 : 0)
                            .padding(.trailing, movie.id == self.movies.last!.id ? 16 : 0)

                    }
                }
            }
        }
    }
}

struct MovieLongCardCarousel_Previews: PreviewProvider {
    static var previews: some View {
        MovieLongCardCarousel(title: "Now Playing", movies: Movie.dummyMovies)
    }
}
