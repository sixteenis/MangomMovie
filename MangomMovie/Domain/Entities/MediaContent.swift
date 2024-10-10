//
//  MediaContent.swift
//  MangomMovie
//
//  Created by NERO on 10/9/24.
//

import Foundation

enum MediaContent {
    struct Trend {
        let movieList: [PosterItem]
        let tvList: [PosterItem]
    }

    struct Recommend {
        let list: [ListItem]
    }

    struct SearchResult {
        let list: [PosterItem]
    }

    struct Favorite {
        let list: [ListItem]
    }

    struct Similar {
        let list: [PosterItem]
    }
}
