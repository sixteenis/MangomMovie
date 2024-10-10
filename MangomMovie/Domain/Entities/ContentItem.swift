//
//  ContentItem.swift
//  MangomMovie
//
//  Created by NERO on 10/9/24.
//

import Foundation

struct MainItem {
    let id: Int
    let imagePath: String
    let genre: [String]
    let title: String
    let isFavorite: Bool
}

struct PosterItem {
    let id: Int
    let imagePath: String
}

struct ListItem {
    let id: Int
    let imagePath: String
    let title: String
}

struct DetailItem {
    let id: Int
    let backdropImagePath: String
    let title: String
    let grade: String
    let synopsis: String
    let castList: [String]
    let creatorList: [String]
    let isFavorite: Bool
}
