//
//  DetailRepository.swift
//  MangomMovie
//
//  Created by NERO on 10/10/24.
//

import Foundation
import RxSwift

protocol DetailRepository {
    func fetchDetailItem(type: MediaType, id: Int) -> Single<Result<DetailMedia, Error>>
}
