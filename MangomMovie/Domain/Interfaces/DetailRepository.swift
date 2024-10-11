//
//  DetailRepository.swift
//  MangomMovie
//
//  Created by NERO on 10/10/24.
//

import Foundation
import RxSwift

protocol DetailRepository {
    func fetchDetailItem(source: CompactMedia) -> Single<Result<DetailMedia, Error>>
}
