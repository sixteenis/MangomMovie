//
//  TrendMediaListDTO.swift
//  MangomMovie
//
//  Created by Jinyoung Yoo on 10/13/24.
//

import Foundation

struct TrendMovieListDTO: Decodable {
    let results: [CompactMovieDTO]
}

struct TrendTVListDTO: Decodable {
    let results: [CompactTVDTO]
}
