//
//  DefaultDetailRepository.swift
//  MangomMovie
//
//  Created by 박성민 on 10/15/24.
//

import RxSwift

final class DefaultDetailRepository: DetailRepository {
    private let dataSource: MediaDataSource
    private let disposeBag = DisposeBag()
    
    init(dataSource: MediaDataSource = DefaultMediaDataSource()) {
        self.dataSource = dataSource
    }
    
    func fetchDetailItem(type: MediaType, id: Int) -> RxSwift.Single<Result<DetailMedia, any Error>> {
        self.getDetailItem(type: type, id: id)
    }
    
}

private extension DefaultDetailRepository {
    func getDetailItem(type: MediaType, id: Int) -> RxSwift.Single<Result<DetailMedia, any Error>>{
        if type ==  .movie {
            return dataSource.fetchMovieDetail(id)
                .map { $0.map{$0.toDomain()}}
                .catch { .just(.failure($0))}
        } else {
            return dataSource.fetchTVDetail(id)
                .map { $0.map{$0.toDomain()}}
                .catch { .just(.failure($0))}
        }
    }
    
}
