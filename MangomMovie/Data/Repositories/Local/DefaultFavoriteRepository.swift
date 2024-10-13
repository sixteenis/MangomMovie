//
//  DefaultFavoriteRepository.swift
//  MangomMovie
//
//  Created by Jinyoung Yoo on 10/13/24.
//

import Foundation

final class DefaultFavoriteRepository: FavoriteRepository {
    
    private let dataSource: FavoriteMovieDataSource
    
    init(dataSource: FavoriteMovieDataSource = DefaultFavoriteMovieDataSource()) {
        self.dataSource = dataSource
    }
    
    func fetchFavoriteList() -> [CompactMedia] {
        return dataSource.fetchFavoriteMovieList().map {
            CompactMedia(
                type: .movie,
                id: $0.0.id,
                imagePath: $0.1,
                genre: [],
                title: $0.0.title
            )
        }
    }
    
    func addFavoriteItem(_ item: CompactMedia) -> Bool {
        // 여기서 이미지 데이터도 받아와야함
        return dataSource.createFavoriteMovie(item)
    }
    
    func deleteFavoriteItem(id: Int) {
        dataSource.deleteFavoriteMovie(movieID: id)
    }
    
    
}
