//
//  TrendginVM.swift
//  MangomMovie
//
//  Created by 박성민 on 10/13/24.
//

import Foundation
import RxSwift
import RxCocoa

final class TrendginVM: BaseViewModel {
    private let disposeBag = DisposeBag()
    private let testURL = "https://image.tmdb.org/t/p/w780/lZGOK0I2DJSRlEPNOAFTSNxSjDD.jpg"
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
            .bind(with: self) { owner, _ in
                bigPost.accept(owner.getRandomItem())
                movieList.accept(owner.getMovieList())
                tvList.accept(owner.getTVList())
            }.disposed(by: disposeBag)
        
        input.saveButtonTap
            .bind(with: self) { owner, _ in
                alert.accept(.save)
            }.disposed(by: disposeBag)
        
        input.posterTap
            .bind(with: self) { owner, model in
                presentDetailView.accept(model)
            }.disposed(by: disposeBag)
        
        return Output(showAlert: alert.asObservable(), bigPost: bigPost.asObservable(), movieList: movieList.asObservable(), tvList: tvList.asObservable(), presentDetailView: presentDetailView.asObservable())
    }
    
}

private extension TrendginVM {
    func getMovieList() -> [CompactMedia] {

        return [CompactMedia(type: .movie, id: 0, imagePath: testURL, genre: ["어쩌구", "저쩌구"], title: "인사이드")]
    }
    func getTVList() -> [CompactMedia] {
        return [CompactMedia(type: .tv, id: 0, imagePath: testURL, genre: ["어쩌구", "저쩌구"], title: "인사이드")]
    }
    func getRandomItem() -> CompactMedia {
        let rType = Bool.random()
        if rType {
            return CompactMedia(type: .movie, id: 0, imagePath: testURL, genre: ["어쩌구", "저쩌구"], title: "인사이드")
        } else {
            return CompactMedia(type: .tv, id: 0, imagePath: testURL, genre: ["어쩌구", "저쩌구"], title: "인사이드")
        }
    }
}
