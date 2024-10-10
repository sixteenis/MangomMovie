//
//  CollectionType.swift
//  MangomMovie
//
//  Created by 박성민 on 10/10/24.
//

import Foundation

enum CollectionType {
    case recommend
    case search
    
    var genreLabelTilte: String {
        switch self {
        case .recommend:
            return "추천 시리즈 & 영화"
        case .search:
            return "영화 & 시리즈"
        }
    }
}
