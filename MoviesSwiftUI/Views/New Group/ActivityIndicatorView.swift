//
//  ActivityIndicatorView.swift
//  MoviesSwiftUI
//
//  Created by DarkBringer on 15.10.2021.
//

import SwiftUI


//MARK: - ACTIVITY INDICATOR ANIMATION 

struct ActivityIndicatorView: UIViewRepresentable {
    
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
}
