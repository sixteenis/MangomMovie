//
//  SimilarRepository.swift
//  MangomMovie
//
//  Created by NERO on 10/10/24.
//

import Foundation
import RxSwift

protocol SimilarRepository {
    func fetchSimilarList(type: MediaType, id: Int) -> Single<Result<[CompactMedia], Error>>
}
