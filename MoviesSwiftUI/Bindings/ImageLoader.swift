//
//  ImageLoader.swift
//  MoviesSwiftUI
//
//  Created by DarkBringer on 15.10.2021.
//

import SwiftUI
import UIKit

//MARK: - we can store the images we get inside this and the system will delete these if the memory is low

private let _imageCache = NSCache<AnyObject, AnyObject>()

class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    @Published var isLoading = false
    
    var imageCache = _imageCache
    
    func loadImage(with url: URL) {
        let urlString = url.absoluteString
        
        //MARK: - if image returns we assign it to the cache
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        //MARK: - get the image in the background from the net
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            do {
                let data = try Data(contentsOf: url)
                
                //MARK: - if no error we get try to get the image from the data
                guard let image = UIImage(data: data) else {
                    return
                }
                
                //MARK: - cache the image with the key
                self.imageCache.setObject(image, forKey: urlString as AnyObject)
                DispatchQueue.main.async {
                    self.image = image
                }

            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
