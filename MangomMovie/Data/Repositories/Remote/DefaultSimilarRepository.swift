//
//  DefaultSimilarRepository.swift
//  MangomMovie
//
//  Created by 박성민 on 10/15/24.
//

import RxSwift

final class DefaultSimilarRepository: SimilarRepository {
    private let dataSource: MediaDataSource
    private let disposeBag = DisposeBag()
    
    init(dataSource: MediaDataSource = DefaultMediaDataSource()) {
        self.dataSource = dataSource
    }
    func fetchSimilarList(type: MediaType, id: Int) -> RxSwift.Single<Result<[CompactMedia], any Error>> {
        return self.getMediaData(type, id: id)
    }
    
    
}
private extension DefaultSimilarRepository {
    func getMediaData(_ type: MediaType, id: Int) -> RxSwift.Single<Result<[CompactMedia], any Error>> {
        if type == .movie {
            return dataSource.fetchSimilarMovies(id)
                .map { $0.map{$0.results.map {$0.toDomain()}}}
                .catch { .just(.failure($0))}
        } else {
            return dataSource.fetchSimilarTVs(id)
                .map { $0.map{$0.results.map {$0.toDomain()}}}
                .catch { .just(.failure($0))}
        }
    }
}
