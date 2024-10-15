//
//  DefaultTrendRepository.swift
//  MangomMovie
//
//  Created by Jinyoung Yoo on 10/13/24.
//

import RxSwift

final class DefaultTrendRepository: TrendRepository {
    
    private let dataSource: MediaDataSource
    private let disposeBag = DisposeBag()
    
    init(dataSource: MediaDataSource = DefaultMediaDataSource()) {
        self.dataSource = dataSource
    }
    
    func fetchTrendMovieList() -> Single<Result<[CompactMedia], Error>> {
        return dataSource.fetchWeeklyTrendMovies()
            .map { $0.map{$0.results.map{$0.toDomain()}}}
            .catch { .just(.failure($0))}
            
    }
    
    func fetchTrendTVList() -> Single<Result<[CompactMedia], Error>> {
        return dataSource.fetchWeeklyTrendTVs()
            .map { $0.map{$0.results.map{$0.toDomain()}}}
            .catch { .just(.failure($0))}
    }

}
