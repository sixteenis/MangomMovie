//
//  TrendRepository.swift
//  MangomMovie
//
//  Created by NERO on 10/10/24.
//

import Foundation
import RxSwift

protocol TrendRepository {
    func fetchTrendMovieList() -> Single<Result<[CompactMedia], Error>>
    func fetchTrendTVList() -> Single<Result<[CompactMedia], Error>>
}
