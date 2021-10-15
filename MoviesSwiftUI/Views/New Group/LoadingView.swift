//
//  LoadingView.swift
//  MoviesSwiftUI
//
//  Created by DarkBringer on 15.10.2021.
//

import SwiftUI

typealias VoidCompletionBlock = () -> ()

//MARK: - whille the view loads we show this view as an indicator
struct LoadingView: View {
    
    let isLoading: Bool
    let error: NSError?
    let retryAction: VoidCompletionBlock?
    
    var body: some View {
        Group{
            
            //MARK: - if loading is true we show indicator
            if isLoading {
                HStack {
                    Spacer()
                    ActivityIndicatorView()
                    Spacer()
                }

                //MARK: - if error is not nil, we show the error code
            } else if error != nil {
                HStack{
                    Spacer()
                    VStack(spacing: 4) {
                        Text(error!.localizedDescription)
                            .font(.headline)
                        
                        //MARK: - if the error is not nil AND retry action is not nil we show the retry button
                        if self.retryAction != nil {
                            Button(action: self.retryAction!, label: {
                                Text("Retry")
                            })
                            .foregroundColor(Color(UIColor.systemBlue))
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isLoading: true, error: nil, retryAction: nil)
    }
}
