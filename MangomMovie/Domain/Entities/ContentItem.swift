//
//  ContentItem.swift
//  MangomMovie
//
//  Created by NERO on 10/9/24.
//

import Foundation

enum ContentType {
    case movie
    case tv
}

struct MainItem {
    let type: ContentType
    let id: Int
    let imagePath: String
    let genre: [String]
    let title: String
    let isFavorite: Bool
}

struct PosterItem {
    let type: ContentType
    let id: Int
    let imagePath: String
}

struct ListItem {
    let type: ContentType
    let id: Int
    let imagePath: String
    let title: String
}

struct DetailItem {
    let type: ContentType
    let id: Int
    let backdropImagePath: String
    let title: String
    let grade: String
    let synopsis: String
    let castList: [String]
    let creatorList: [String]
    let isFavorite: Bool
}
