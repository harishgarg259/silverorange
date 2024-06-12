//
//  VideoListModel.swift
//  VideoPlayerSwiftUI
//
//  Created by Harish Garg on 12/06/24.
//

import Foundation


struct VideoListModel : Codable, Identifiable {
    let id : String?
    let title : String?
    let hlsURL : String?
    let fullURL : String?
    let description : String?
    let publishedAt : String?
    let author : Author?
}

struct Author : Codable {
    let id : String?
    let name : String?
}
