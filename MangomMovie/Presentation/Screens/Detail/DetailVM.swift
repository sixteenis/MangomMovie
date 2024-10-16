//
//  DetailVM.swift
//  MangomMovie
//
//  Created by 박성민 on 10/16/24.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailVM: BaseViewModel {
    private let disposeBag = DisposeBag()
    private let useCase = DefaultDetailUseCase()
    let compactMedia: CompactMedia
    init(compactMedia: CompactMedia) {
        self.compactMedia = compactMedia
    }
    struct Input {
        let viewDidLoad: Observable<Void> //뷰 뜰때
        let saveButtonTap: ControlEvent<Void>
    }
    struct Output {
        let detailMedia: Observable<DetailMedia> // 좋아요 한거
        let similarList: Observable<[CompactMedia]>
        let showAlert: Observable<AlertType>
    }
    func transform(input: Input) -> Output {
        let detailMedia = ReplayRelay<DetailMedia>.create(bufferSize: 1)
        let similarList = BehaviorRelay(value: [CompactMedia]())
        let alert = ReplayRelay<AlertType>.create(bufferSize: 1)
        
        input.viewDidLoad
            .flatMap { _ in
                self.useCase.fetchDetailItem(type: self.compactMedia.type, id: self.compactMedia.id)
            }
            .bind(with: self) { owner, response in
                switch response {
                case .success(let data):
                    detailMedia.accept(data)
                case .failure(let err):
                    print(err)
                }
            }.disposed(by: disposeBag)
        
        input.viewDidLoad
            .flatMap { _ in
                self.useCase.fetchSimilarList(type: self.compactMedia.type, id: self.compactMedia.id)
            }
            .bind(with: self) { owner, response in
                switch response {
                case .success(let data):
                    similarList.accept(data)
                case .failure(let err):
                    print(err)
                }
            }.disposed(by: disposeBag)
        input.saveButtonTap
            .bind(with: self) { owner, _ in
                let result = owner.useCase.addFavoriteItem(owner.compactMedia)
                if result {
                    alert.accept(.save)
                } else {
                    alert.accept(.alreadySave)
                }
                
            }.disposed(by: disposeBag)
        
        return Output(detailMedia: detailMedia.asObservable(), similarList: similarList.asObservable(), showAlert: alert.asObservable())
    }
}


