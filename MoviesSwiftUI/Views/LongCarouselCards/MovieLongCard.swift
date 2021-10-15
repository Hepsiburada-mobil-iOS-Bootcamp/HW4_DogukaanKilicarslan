//
//  MovieLongCard.swift
//  MoviesSwiftUI
//
//  Created by DarkBringer on 15.10.2021.
//

import SwiftUI

struct MovieLongCard: View {
    
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        ZStack {

            //MARK: - if image is not nil we will assign it to the view
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .shadow(radius: 4)
            } else {
                
                //MARK: - if there is no image, we show a gray transparent rectangle
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .cornerRadius(8)
                    .shadow(radius: 4)
                Text(movie.title)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(width: 200, height: 300)
        
        //MARK: - Downloading the poster from network
        .onAppear {
            self.imageLoader.loadImage(with: self.movie.posterURL)
        }
    }
}

struct MovieLongCard_Previews: PreviewProvider {
    static var previews: some View {
        MovieLongCard(movie: Movie.dummyMovie)
    }
}
