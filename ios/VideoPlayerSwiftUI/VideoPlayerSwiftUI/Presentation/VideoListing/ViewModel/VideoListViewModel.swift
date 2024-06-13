//
//  VideoListViewModel.swift
//  VideoPlayerSwiftUI
//
//  Created by Harish Garg on 12/06/24.
//

import Foundation

class VideoListViewModel: ObservableObject {
        
    // MARK: - Properties
    @Published var videosDetail: VideoListModel?
    private var videosList: [VideoListModel] = []

    
    
    // MARK: - API Functions
    /*
     API Call for video listing
     */
    func videoList() {
        let rest = RestManager<[VideoListModel]>()
        rest.makeRequest(request : WebAPI().videos(params : [:], type: .videosList)!) { (result) in
            
            switch result {
                
            case .success(let response):
                
                debugPrint(response)
                self.videosList = response
                self.sortVideo(type: .Date)
                
            case .failure(let error):
                debugPrint(error.description)
                
            }
            
        }
    }
    
    
    // MARK: - Functions
    /*
     Sort video listings by various options.
     However, it is recommended to use filters via the API only,
     as issues may arise with pagination.
     */
    func sortVideo(type: SortingType){
        
        switch type {
        case .Date:
            //Sorting the array with date in Ascending order.
            self.videosList.sort(by: { $0.publishedAt?.compare($1.publishedAt ?? "") == .orderedAscending })
        }
        
        
        //After sorting this function will load the first element from the list again.
        self.loadVideoDetail(index: 0)
        
    }
    
    /*
     This function renders the UI and video player with the updated video.
     The index value will be either previous or next to the current video's details.
     */
    func loadVideoDetail(index: Int){
        self.videosDetail = self.videosList[safe: index]
    }
}
