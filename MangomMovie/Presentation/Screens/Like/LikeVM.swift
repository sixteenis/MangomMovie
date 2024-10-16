//
//  LikeVM.swift
//  MangomMovie
//
//  Created by 박성민 on 10/13/24.
//

import Foundation
import RxSwift
import RxCocoa
final class LikeVM: BaseViewModel {
    private let disposeBag = DisposeBag()
    private let useCase = DefaultFavoriteUseCase()
    
    struct Input {
        let viewDidLoad: Observable<Void> //뷰 뜰때
        let removeItem: Observable<Int>
    }
    struct Output {
        let likeList: Observable<[CompactMedia]> // 좋아요 한거
    }
    func transform(input: Input) -> Output {
        let likeList = BehaviorRelay(value: [CompactMedia]())
        input.viewDidLoad
            .bind(with: self) { owner, _ in
                likeList.accept(owner.useCase.fetchFavoriteList())
            }.disposed(by: disposeBag)
        input.removeItem
            .bind(with: self) { owner, index in
                if likeList.value.count >= index {
                    owner.useCase.deleteFavoriteItem(id: likeList.value[index].id)
                    likeList.accept(owner.useCase.fetchFavoriteList())
                }
            }.disposed(by: disposeBag)
        
        return Output(likeList: likeList.asObservable())
    }
}


