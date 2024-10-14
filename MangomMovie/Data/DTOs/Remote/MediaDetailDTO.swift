//
//  MediaDetailDTO.swift
//  MangomMovie
//
//  Created by Jinyoung Yoo on 10/13/24.
//

import Foundation

struct MovieDetailDTO: Decodable {
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String?
    let rate: Float
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case rate = "vote_average"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
    }
}

struct TVDetailDTO: Decodable {
    let id: Int
    let name: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String?
    let rate: Float
    
    enum CodingKeys: String, CodingKey {
        case id, name, overview
        case rate = "vote_average"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
    }
}
