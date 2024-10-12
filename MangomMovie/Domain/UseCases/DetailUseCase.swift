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
    func fetchSimilarList(type: MediaType, id: Int) -> Single<Result<[CompactMedia], Error>>
    func addFavoriteItem(_ item: CompactMedia) -> Bool
}

final class DefaultDetailUseCase: DetailUseCase {
    private let detailRepository: DetailRepository
    private let similarRepository: SimilarRepository
    private let favoriteRepository: FavoriteRepository
    
    init(detailRepository: DetailRepository, similarRepository: SimilarRepository, favoriteRepository: FavoriteRepository) {
        self.detailRepository = detailRepository
        self.similarRepository = similarRepository
        self.favoriteRepository = favoriteRepository
    }
    
    func fetchDetailItem(type: MediaType, id: Int) -> Single<Result<DetailMedia, Error>> {
        return detailRepository.fetchDetailItem(type: type, id: id)
    }
    
    func fetchSimilarList(type: MediaType, id: Int) -> Single<Result<[CompactMedia], Error>> {
        return similarRepository.fetchSimilarList(type: type, id: id)
    }
    
    func addFavoriteItem(_ item: CompactMedia) -> Bool {
        return favoriteRepository.addFavoriteItem(item)
    }
}
