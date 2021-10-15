//
//  MovieWideCard.swift
//  MoviesSwiftUI
//
//  Created by DarkBringer on 15.10.2021.
//

import SwiftUI

struct MovieWideCard: View {
    
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                
                //MARK: - if the image exist, we pass in the image
                if self.imageLoader.image != nil {
                    Image(uiImage: self.imageLoader.image!)
                        .resizable()
                }
            }
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(8)
            .shadow(radius: 4)
            Text(movie.title)
               
                
        }
        .lineLimit(1)
        //MARK: - downloading the image from network
        .onAppear {
            self.imageLoader.loadImage(with: self.movie.backdropURL)
        }
    }
}

struct MovieWideCard_Previews: PreviewProvider {
    static var previews: some View {
        MovieWideCard(movie: Movie.dummyMovie)
    }
}
