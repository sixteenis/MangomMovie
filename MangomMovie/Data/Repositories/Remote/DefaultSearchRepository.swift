//
//  DefaultSearchRepository.swift
//  MangomMovie
//
//  Created by 박성민 on 10/15/24.
//

import RxSwift

final class DefaultSearchRepository: SearchRepository {
    private let dataSource: MediaDataSource
    private let disposeBag = DisposeBag()
    
    init(dataSource: MediaDataSource = DefaultMediaDataSource()) {
        self.dataSource = dataSource
    }
    func fetchSearchMovieList(keyword: String, isPagination: Bool) -> RxSwift.Single<Result<[CompactMedia], any Error>> {
        return dataSource.searchMovie(query: keyword, isPaging: isPagination)
            .map { $0.map{$0.results.map{$0.toDomain()}}}
            .catch { .just(.failure($0))}
    }
}
