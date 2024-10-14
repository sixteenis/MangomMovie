//
//  TMDBRequest.swift
//  MangomMovie
//
//  Created by Jinyoung Yoo on 10/13/24.
//
import Foundation
import Moya

enum TMDBRequest {
    case weeklyTrendMovies
    case weeklyTrendTVs
    case searchMovie(query: String, page: Int)
    case movieDetail(_ id: Int)
    case tvDetail(_ id: Int)
    case similarMovies(_ id: Int)
    case similarTVs(_ id: Int)
    case movieCredits(_ id: Int)
    case tvCredits(_ id: Int)
}

extension TMDBRequest: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var path: String {
        switch self {
        case .weeklyTrendMovies:
            return "/trending/movie/week"
        case .weeklyTrendTVs:
            return "/trending/tv/week"
        case .searchMovie:
            return "/search/movie"
        case .movieDetail(let id):
            return "/movie/\(id)"
        case .tvDetail(let id):
            return "/tv/\(id)"
        case .similarMovies(let id):
            return "/movie/\(id)/similar"
        case .similarTVs(let id):
            return "/tv/\(id)/similar"
        case .movieCredits(let id):
            return "/movie/\(id)/credits"
        case .tvCredits(let id):
            return "/tv/\(id)/credits"
        }
    }
    
    var method: Moya.Method {
        return .get
    }

    var task: Moya.Task {
        switch self {
        case .searchMovie(let query, let page):
            let parameters: [String: Any]  = [
                "query": query,
                "language": "ko-KR",
                "include_adult": true,
                "page": page
            ]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
            
        default:
            let parameters = ["language": "ko-KR" ]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        return ["Authorization": APIKey.tmdbKey]
    }

    var validationType: ValidationType {
        return .successCodes
    }
}
