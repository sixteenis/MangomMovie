//
//  DetailUseCase.swift
//  MangomMovie
//
//  Created by NERO on 10/10/24.
//

import Foundation
import RxSwift

protocol DetailUseCase {
    func fetchDetailItem(type: MediaType, id: Int) -> Single<Result<DetailMedia, Error>>
    func fetchDetailItem(type: MediaType, id: Int) -> Single<Result<DetailMedia, Error>>
    func fetchSimilarList(type: MediaType, id: Int) -> Single<Result<[CompactMedia], Error>>
    func addFavoriteItem(_ item: CompactMedia) -> Bool
    func addFavoriteItem(_ item: CompactMedia) -> Bool
}

//final class DefaultDetailUseCase: DetailUseCase {
//    private let detailRepository: DetailRepository
//    private let favoriteRepository: FavoriteRepository
//    
//    init(detailRepository: DetailRepository, favoriteRepository: FavoriteRepository) {
//        self.detailRepository = detailRepository
//        self.favoriteRepository = favoriteRepository
//    }
//    
//    func fetchDetailItem(type: MediaType, id: Int) -> Single<Result<DetailMedia, Error>> {
//        
//        return
//    }
//    
//    func fetchSimilarList(type: MediaType, id: Int) -> Single<Result<[CompactMedia], Error>> {
//        
//        return
//    }
//    
//    func addFavoriteItem(_ item: CompactMedia) {
//        
//    }
//}
