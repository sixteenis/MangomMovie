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
extension MovieDetailDTO {
//    func toDomain() -> DetailMedia {
//        let result = DetailMedia(
//            type: .movie,
//            id: self.id,
//            posterImagePath: self.posterPath ?? "",
//            backdropImagePath: self.backdropPath ?? "",
//            title: self.title,
//            grade: self.rate.formatted(),
//            synopsis: <#T##String#>,
//            castList: <#T##[String]#>,
//            creatorList: <#T##[String]#>)
//    }
}
//struct DetailMedia {
//    let type: MediaType
//    let id: Int
//    let posterImagePath: String
//    let backdropImagePath: String
//    let title: String
//    let grade: String
//    let synopsis: String
//    let castList: [String]
//    let creatorList: [String]
//}

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
