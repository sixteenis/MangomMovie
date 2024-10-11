//
//  SearchRepository.swift
//  MangomMovie
//
//  Created by NERO on 10/10/24.
//

import Foundation
import RxSwift

protocol SearchRepository {
    func fetchSearchMovieList(keyword: String, isPagination: Bool) -> Single<Result<[CompactMedia], Error>>
}
