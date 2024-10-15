//
//  DefaultDetailRepository.swift
//  MangomMovie
//
//  Created by 박성민 on 10/15/24.
//

import RxSwift

//final class DefaultDetailRepository: DetailRepository {
//    private let dataSource: MediaDataSource
//    private let disposeBag = DisposeBag()
//    
//    init(dataSource: MediaDataSource = DefaultMediaDataSource()) {
//        self.dataSource = dataSource
//    }
//    
//    func fetchDetailItem(type: MediaType, id: Int) -> RxSwift.Single<Result<DetailMedia, any Error>> {
//        if type == .movie {
//            
//        } else {
//            
//        }
//    }
//    
//}

//private extension DefaultDetailRepository {
//    func getMovieDetail(_ id: Int) -> RxSwift.Single<Result<DetailMedia, any Error>> {
//        let a = dataSource.fetchMovieDetail(123)
//        return dataSource.fetchMovieDetail(id)
//            .map {$0}
//            .catch { .just(.failure($0))}
//    }
//}
