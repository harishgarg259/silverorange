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
    @StateObject private var preferences: SettingsPreferences = .init()
    
    // MARK: - BODY
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            
            // Video Player
            if let url = viewModel.videosDetail?.fullURL, !url.isEmpty{
                MediaPlayer(url: URL(string: url)!, seekFactor: AppConstants.seekFactor, preferences: preferences)
                    .frame(height: 300)
            }
            
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
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
            .navigationTitle("title".localized)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                self.viewModel.videoList()
            }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name.taskAddedNotification)) { object in
                if let newTask = object.object as? VideoAction{
                    self.viewModel.loadVideoDetail(action: newTask)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: VideoListViewModel())
    }
}
