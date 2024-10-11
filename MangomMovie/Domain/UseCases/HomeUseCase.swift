//
//  HomeUseCase.swift
//  MangomMovie
//
//  Created by NERO on 10/10/24.
//

import Foundation
import RxSwift

protocol HomeUseCase {
    func addFavoriteItem(_ item: CompactMedia) -> Bool
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
<<<<<<< HEAD
<<<<<<< HEAD
//    func addFavoriteItem(_ item: CompactMedia) -> Bool {
=======
//    func addFavoriteItem(_ item: CompactMedia) {
>>>>>>> dac9e4c (UseCase Protocol 정의)
=======
//    func addFavoriteItem(_ item: CompactMedia) -> Bool {
>>>>>>> 723ea08 (Add Favorite 시 Bool값 반환하도록 수정 / fetchDetailItem 매개변수 수정)
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
