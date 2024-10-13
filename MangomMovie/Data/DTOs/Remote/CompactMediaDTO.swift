//
//  CompactMediaDTO.swift
//  MangomMovie
//
//  Created by Jinyoung Yoo on 10/13/24.
//

import Foundation

struct CompactMovieDTO: Decodable {
    let id: Int
    let title: String
    let posterPath: String?
    let genreIDs: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
        case genreIDs = "genre_ids"
    }
}

struct CompactTVDTO: Decodable {
    let id: Int
    let name: String
    let posterPath: String?
    let genreIDs: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case genreIDs = "genre_ids"
    }
}
