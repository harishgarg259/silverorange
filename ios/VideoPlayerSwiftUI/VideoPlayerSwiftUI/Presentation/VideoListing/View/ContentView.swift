//
//  ContentView.swift
//  VideoPlayerSwiftUI
//
//  Created by Michael Gauthier on 2021-01-06.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    // MARK: - Properties
    @StateObject var viewModel: VideoListViewModel
    
    // MARK: - BODY
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // Video Player
                if let url = viewModel.videosDetail?.fullURL, !url.isEmpty{
                    
                }
                
                // Video name
                Text(viewModel.videosDetail?.title ?? "Title")
                    .font(.title)
                
                // Author Details
                Text("Author: \(viewModel.videosDetail?.author?.name ?? "")")
                    .font(Font.system(size: 14))
                    .italic()
                    .fontWeight(.medium)
                    .drawingGroup()
                
                // Video description with details
                VStack(alignment: .leading, spacing: 10) {
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
