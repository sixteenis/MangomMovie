////
////  FavoriteUseCase.swift
////  MangomMovie
////
////  Created by NERO on 10/10/24.
////
//
//import Foundation
//import RxSwift
//
//protocol FavoriteUseCase {
//    func fetchFavoriteList() -> Single<Result<[CompactMedia], Error>>
//    func deleteFavoriteItem(id: Int)
//}
//
//final class DefaultFavoriteUseCase: FavoriteUseCase {
//    private let favoriteRepository: FavoriteRepository
//    
//    init(favoriteRepository: FavoriteRepository) {
//        self.favoriteRepository = favoriteRepository
//    }
//    
//    func fetchFavoriteList() -> Single<Result<[CompactMedia], Error>> {
//        return favoriteRepository.fetchFavoriteList()
//    }
//    
//    func deleteFavoriteItem(id: Int) {
//        favoriteRepository.deleteFavoriteItem(id: id)
//    }
//}
