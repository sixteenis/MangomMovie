//
//  MediaDataSource.swift
//  MangomMovie
//
//  Created by Jinyoung Yoo on 10/13/24.
//

import Moya
import RxSwift

protocol MediaDataSource {
    func fetchWeeklyTrendMovies() -> Single<Result<TrendMovieListDTO, Error>>
    func fetchWeeklyTrendTVs() -> Single<Result<TrendTVListDTO, Error>>
    func searchMovie(query: String, isPaging: Bool) -> Single<Result<MovieSearchResultDTO, Error>>
    func fetchMovieDetail(_ id: Int) -> Single<Result<MovieDetailDTO, Error>>
    func fetchTVDetail(_ id: Int) -> Single<Result<TVDetailDTO, Error>>
    func fetchSimilarMovies(_ id: Int) -> Single<Result<SimilarMovieListDTO, Error>>
    func fetchSimilarTVs(_ id: Int) -> Single<Result<SimilarTVListDTO, Error>>
    func fetchMovieCredits( _ id: Int) -> Single<Result<CastingListDTO, Error>>
    func fetchTVCredits(_ id: Int) -> Single<Result<CastingListDTO, Error>>
}

final class DefaultMediaDataSource: MediaDataSource {
//    static let sharde = DefaultMediaDataSource()
//    private init() {}
    private let provider = MoyaProvider<TMDBRequest>()
    private let disposeBag = DisposeBag()
    private var page = 1
    private var totalPages = 1
    
    func fetchWeeklyTrendMovies() -> Single<Result<TrendMovieListDTO, Error>> {
        return decapsulateResponse(.weeklyTrendMovies, type: TrendMovieListDTO.self)
    }
    
    func fetchWeeklyTrendTVs() -> Single<Result<TrendTVListDTO, Error>> {
        return decapsulateResponse(.weeklyTrendTVs, type: TrendTVListDTO.self)
    }
    
    func searchMovie(query: String, isPaging: Bool) -> Single<Result<MovieSearchResultDTO, Error>> {
        return Single.create { [weak self] observer in
            
            guard let self else { return Disposables.create() }
            
            if (isPaging == false) {
                page = 1
            }
            
            guard page <= totalPages else {
                observer(.success(.success(MovieSearchResultDTO(results: [], totalPages: 0))))
                return Disposables.create()
            }
            
            page = isPaging ? (page + 1) : 1
            
            provider.request(.searchMovie(query: query, page: page)) { result in
                switch result {
                case .success(let response):
                
                    do {
                        let data = try response.map(MovieSearchResultDTO.self)
                        self.totalPages = data.totalPages
                        return observer(.success(.success(data)))
                    } catch {
                        observer(.success(.failure(error)))
                    }
                    
                case .failure(let error):
                    observer(.success(.failure(error)))
                }
            }
            
            return Disposables.create()
        }
    }
    
    func fetchMovieDetail(_ id: Int) -> Single<Result<MovieDetailDTO, Error>> {
        return decapsulateResponse(.movieDetail(id), type: MovieDetailDTO.self)
    }
    
    func fetchTVDetail(_ id: Int) -> Single<Result<TVDetailDTO, Error>> {
        return decapsulateResponse(.tvDetail(id), type: TVDetailDTO.self)
    }
    
    func fetchSimilarMovies(_ id: Int) -> Single<Result<SimilarMovieListDTO, Error>> {
        return decapsulateResponse(.similarMovies(id), type: SimilarMovieListDTO.self)
    }
    
    func fetchSimilarTVs(_ id: Int) -> Single<Result<SimilarTVListDTO, Error>> {
        return decapsulateResponse(.similarTVs(id), type: SimilarTVListDTO.self)
    }
    
    func fetchMovieCredits(_ id: Int) -> Single<Result<CastingListDTO, Error>> {
        return decapsulateResponse(.movieCredits(id), type: CastingListDTO.self)
    }
    
    func fetchTVCredits(_ id: Int) -> Single<Result<CastingListDTO, Error>> {
        return decapsulateResponse(.tvCredits(id), type: CastingListDTO.self)
    }

    private func decapsulateResponse<T: Decodable>(_ request: TMDBRequest, type: T.Type) -> Single<Result<T, Error>> {
        return Single.create { [weak self] observer in
            
            guard let self else { return Disposables.create() }
            
            provider.request(request) { result in
                switch result {
                case .success(let response):
                
                    do {
                        let data = try response.map(type)
                        return observer(.success(.success(data)))
                    } catch {
                        observer(.success(.failure(error)))
                    }
                    
                case .failure(let error):
                    observer(.success(.failure(error)))
                }
            }
            
            return Disposables.create()
        }
    }
}
