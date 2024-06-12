//
//  ContentView.swift
//  VideoPlayerSwiftUI
//
//  Created by Michael Gauthier on 2021-01-06.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @StateObject var viewModel: VideoListViewModel
    
    // MARK: - BODY
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Multiple images in grid view with pagination view
//                ImageGridView(images: [])
//                    .frame(height: 200) // Set your preferred height
                
                // Product name and price detail after discount
                Text(viewModel.videosDetail?.title ?? "Title")
                    .font(.title)
                
                // Product description with multiple headings and details
                VStack(alignment: .leading, spacing: 12) {
                    Text("Description:")
                        .font(.headline)
                    Text(viewModel.videosDetail?.description ?? "")
                        .font(.body)
                }
            }
            .padding()
        }
        .navigationTitle("Video Detail")
        .onAppear {
            self.viewModel.videoList()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: VideoListViewModel())
    }
}
