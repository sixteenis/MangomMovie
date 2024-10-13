//
//  SimilarMediaListDTO.swift
//  MangomMovie
//
//  Created by Jinyoung Yoo on 10/13/24.
//

import Foundation

struct SimilarMovieListDTO: Decodable {
    let results: [CompactMovieDTO]
}

struct SimilarTVListDTO: Decodable {
    let result: [CompactTVDTO]
}

