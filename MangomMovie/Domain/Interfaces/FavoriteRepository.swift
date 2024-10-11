//
//  FavoriteRepository.swift
//  MangomMovie
//
//  Created by NERO on 10/10/24.
//

import Foundation
import RxSwift

protocol FavoriteRepository {
    func fetchFavoriteList() -> Single<Result<[CompactMedia], Error>>
    func addFavoriteItem(_ item: CompactMedia) -> Bool
    func deleteFavoriteItem(id: Int)
}
