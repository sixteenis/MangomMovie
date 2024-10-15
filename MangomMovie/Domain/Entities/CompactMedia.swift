//
//  CompactMedia.swift
//  MangomMovie
//
//  Created by NERO on 10/11/24.
//

import Foundation

struct CompactMedia {
    let type: MediaType
    let id: Int
    let imagePath: String
    let genre: [String]
    let title: String
    init(type: MediaType, id: Int, imagePath: String, genre: [String], title: String) {
        self.type = type
        self.id = id
        self.imagePath = imagePath
        self.genre = genre
        self.title = title
    }
    init() {
        self.type = .movie
        self.id = 0
        self.imagePath = ""
        self.genre = [""]
        self.title = ""
        
    }
}
