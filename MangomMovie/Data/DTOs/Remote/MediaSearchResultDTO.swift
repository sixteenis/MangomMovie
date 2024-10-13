//
//  MediaSearchResultDTO.swift
//  MangomMovie
//
//  Created by Jinyoung Yoo on 10/13/24.
//

import Foundation

struct MovieSearchResultDTO: Decodable {
    let results: [CompactMovieDTO]
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case totalPages = "total_pages"
    }
}
