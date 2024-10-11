//
//  HomeUseCase.swift
//  MangomMovie
//
//  Created by NERO on 10/10/24.
//

import Foundation
import RxSwift

protocol HomeUseCase {
    func addFavoriteItem(_ item: CompactMedia)
    func fetchTrendMovieList() -> Single<Result<[CompactMedia], Error>>
    func fetchTrendTVList() -> Single<Result<[CompactMedia], Error>>
}

//final class DefaultHomeUseCase: HomeUseCase {
//    private let trendRepository: TrendRepository
//    private let favoriteRepository: FavoriteRepository
//    
//    init(trendRepository: TrendRepository, favoriteRepository: FavoriteRepository) {
//        self.trendRepository = trendRepository
//        self.favoriteRepository = favoriteRepository
//    }
//    
//    func addFavoriteItem(_ item: CompactMedia) {
//        
//    }
//    
//    func fetchTrendMovieList() -> Single<Result<[CompactMedia], Error>> {
//        
//        return
//    }
//    
//    func fetchTrendTVList() -> Single<Result<[CompactMedia], Error>> {
//        
//        return
//    }
//}
