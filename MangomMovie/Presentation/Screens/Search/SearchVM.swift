//
//  SearchVM.swift
//  MangomMovie
//
//  Created by 박성민 on 10/13/24.
//
import Foundation
import RxSwift
import RxCocoa
final class SearchVM: BaseViewModel {
    private let disposeBag = DisposeBag()
    private let useCase: SearchUseCase
    
    init(useCase: SearchUseCase) {
        self.useCase = useCase
    }
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let searchText: ControlProperty<String>
        
    }
    struct Output {
        let trendMovieList: BehaviorRelay<[CompactMedia]>
        let searchMovieList: BehaviorRelay<[CompactMedia]>
        let nowState: BehaviorRelay<CollectionType>
        
    }
    func transform(input: Input) -> Output {
        let nowState = BehaviorRelay(value: CollectionType.recommend)
        let trendMovieList = BehaviorRelay(value: [CompactMedia]())
        let searchMovieList = BehaviorRelay(value: [CompactMedia]())
        
        input.viewDidLoad
            .flatMap { self.useCase.fetchTrendMovieList()}
            .bind(with: self) { owner, item in
                switch item {
                case .success(let data):
                    nowState.accept(.recommend)
                    trendMovieList.accept(data)
                case .failure(let err):
                    print(err)
                }
            }.disposed(by: disposeBag)
        
        input.searchText
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .filter {
                if $0 == "" {
                    nowState.accept(.recommend)
                    return false
                } else {
                    nowState.accept(.search)
                    return true
                }
            }
            .flatMap { self.useCase.fetchSearchMovieList(keyword: $0, isPagination: false)}
            .bind(with: self) { owner, result in
                switch result {
                case .success(let data):
                    searchMovieList.accept(data)
                case .failure(let err):
                    print(err)
                }
            }.disposed(by: disposeBag)
        
            
        return Output(trendMovieList: trendMovieList, searchMovieList: searchMovieList, nowState: nowState)
    }
}
private extension SearchVM {
}
