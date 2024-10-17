//
//  TrendginVM.swift
//  MangomMovie
//
//  Created by 박성민 on 10/13/24.
//

import Foundation
import RxSwift
import RxCocoa

final class TrendingVM: BaseViewModel {
    private let disposeBag = DisposeBag()
    private let useCase = DefaultHomeUseCase()
    
    struct Input {
        let viewDidLoad: Observable<Void> //뷰 뜰때
        let saveButtonTap: ControlEvent<Void> // 찜한 리스트 클릭 시
        let posterTap: Observable<ControlEvent<CompactMedia>.Element> // 포스터 클릭 시
    }
    struct Output {
        let showAlert: Observable<AlertType>
        
        let bigPost: Observable<CompactMedia> //맨위 큰 애
        let movieList: Observable<[CompactMedia]> //지금 뜨는 영화
        let tvList: Observable<[CompactMedia]> // 지금 뜨는 TV
        
        let presentDetailView: Observable<CompactMedia>
    }
    
    func transform(input: Input) -> Output {
        let bigPost = ReplayRelay<CompactMedia>.create(bufferSize: 1)
        let movieList = BehaviorRelay(value: [CompactMedia]())
        let tvList = BehaviorRelay(value: [CompactMedia]())
        
        let alert = ReplayRelay<AlertType>.create(bufferSize: 1)
        let presentDetailView = ReplayRelay<CompactMedia>.create(bufferSize: 1)
        input.viewDidLoad
            .flatMap { _ in
                self.useCase.fetchTrendMovieList()
            }
            .bind(with: self) { owner, response in
                switch response {
                case .success(let data):
                    movieList.accept(data)
                    if !data.isEmpty {
                        bigPost.accept(data.randomElement()!)
                    }
                case .failure(let err):
                    print(err)
                }
            }.disposed(by: disposeBag)
        input.viewDidLoad
            .flatMap { _ in
                self.useCase.fetchTrendTVList()
            }
            .bind(with: self) { owner, response in
                switch response {
                case .success(let data):
                    tvList.accept(data)
                case .failure(let err):
                    print(err)
                }
            }.disposed(by: disposeBag)
        
        input.saveButtonTap
            .withLatestFrom(bigPost.asObservable())
            .bind(with: self) { owner, data in
                let result = owner.useCase.addFavoriteItem(data)
                if result {
                    alert.accept(.save)
                } else {
                    alert.accept(.alreadySave)
                }
            }.disposed(by: disposeBag)
        
        input.posterTap
            .bind(with: self) { owner, model in
                presentDetailView.accept(model)
            }.disposed(by: disposeBag)
        
        return Output(showAlert: alert.asObservable(), bigPost: bigPost.asObservable(), movieList: movieList.asObservable(), tvList: tvList.asObservable(), presentDetailView: presentDetailView.asObservable())
    }
    
}

