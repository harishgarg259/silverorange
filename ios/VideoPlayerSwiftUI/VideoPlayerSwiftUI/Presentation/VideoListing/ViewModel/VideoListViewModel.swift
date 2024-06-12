//
//  VideoListViewModel.swift
//  VideoPlayerSwiftUI
//
//  Created by Harish Garg on 12/06/24.
//

import Foundation

class VideoListViewModel: ObservableObject {
        
    var videosList: [VideoListModel] = []
    @Published var videosDetail: VideoListModel?

    func videoList() {
        let rest = RestManager<[VideoListModel]>()
        rest.makeRequest(request : WebAPI().videos(params : [:], type: .videosList)!) { (result) in
            switch result {
            case .success(let response):
                debugPrint(response)
                self.videosList = response
                self.loadVideoDetail(index: 0)
            case .failure(let error):
                debugPrint(error.description)
            }
        }
    }
    
    
    func loadVideoDetail(index: Int){
        self.videosDetail = self.videosList[index]
    }
}
