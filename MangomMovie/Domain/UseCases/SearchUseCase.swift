//
//  SearchUseCase.swift
//  MangomMovie
//
//  Created by NERO on 10/10/24.
//

import Foundation
import RxSwift

protocol SearchUseCase {
    func fetchSearchMovieList(keyword: String, isPagination: Bool) -> Single<Result<[CompactMedia], Error>>
    func fetchTrendMovieList() -> Single<Result<[CompactMedia], Error>>
}

final class DefaultSearchUseCase: SearchUseCase {
    private let searchRepository: SearchRepository
    private let trendRepository: TrendRepository
    
    init(searchRepository: SearchRepository, trendRepository: TrendRepository) {
        self.searchRepository = searchRepository
        self.trendRepository = trendRepository
    }
    
    func fetchSearchMovieList(keyword: String, isPagination: Bool) -> Single<Result<[CompactMedia], Error>> {
        return searchRepository.fetchSearchMovieList(keyword: keyword, isPagination: isPagination)
    }
    
    func fetchTrendMovieList() -> Single<Result<[CompactMedia], Error>> {
        return trendRepository.fetchTrendMovieList()
    }
}
