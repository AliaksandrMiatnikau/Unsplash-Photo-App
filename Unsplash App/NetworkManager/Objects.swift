//
//  Objects.swift
//  Unsplash App
//
//  Created by Aliaksandr Miatnikau on 21.07.22.
//

import Foundation

struct PhotoList {
    var photoId: String
    var authorName: String
    var image: String
}

struct DetailedInfo {
    
    var authorName: String
    var dateOfCreation: String
    var location: String
    var numberOfDownloads: Int
    var liked: Bool
    
    
}
