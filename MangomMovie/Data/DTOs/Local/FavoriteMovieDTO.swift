//
//  FavoriteMovieDTO.swift
//  MangomMovie
//
//  Created by Jinyoung Yoo on 10/13/24.
//

import RealmSwift

final class FavoriteMovieDTO: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String
    
    convenience init(id: Int, title: String) {
        self.init()
        self.id = id
        self.title = title
    }
}
