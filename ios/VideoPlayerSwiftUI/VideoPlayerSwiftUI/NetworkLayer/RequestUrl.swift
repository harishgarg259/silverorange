//
//  RequestUrl.swift
//  VideoPlayerSwiftUI
//
//  Created by Harish Garg on 12/06/24.
//

import Foundation

enum RequestUrl :String{
    
    /*Base URL*/
    static var BaseURL = "http://localhost:4000"

    /*COMPLETE URL*/
    var url : String{ return RequestUrl.BaseURL + self.rawValue }
    
    
    
    
    /*END POINTS*/
    /***********************************************/
    
    //Videos Related End Points
    case videos = "/videos"
    
}
