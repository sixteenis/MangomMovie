//
//  BaseViewModel.swift
//  MangomMovie
//
//  Created by 박성민 on 10/8/24.
//

import Foundation
import RxSwift
import RxCocoa

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
