//
//  FavoriteUseCase.swift
//  MangomMovie
//
//  Created by NERO on 10/10/24.
//

import Foundation
import RxSwift

protocol FavoriteUseCase {
    func fetchFavoriteList() -> [CompactMedia]
    func deleteFavoriteItem(id: Int)
}

final class DefaultFavoriteUseCase: FavoriteUseCase {
    private let favoriteRepository: FavoriteRepository
    
    init(favoriteRepository: FavoriteRepository = DefaultFavoriteRepository()) {
        self.favoriteRepository = favoriteRepository
    }
    
    func fetchFavoriteList() -> [CompactMedia] {
        return favoriteRepository.fetchFavoriteList()
    }
    
    func deleteFavoriteItem(id: Int) {
        favoriteRepository.deleteFavoriteItem(id: id)
    }
}
