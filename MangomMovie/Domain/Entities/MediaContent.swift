//
//  MediaContent.swift
//  MangomMovie
//
//  Created by NERO on 10/9/24.
//

import Foundation

enum MediaContent {
    struct Trend {
        let movieList: [CompactMedia]
        let tvList: [CompactMedia]
    }

    struct Recommend {
        let list: [CompactMedia]
    }

    struct SearchResult {
        let list: [CompactMedia]
    }

    struct Favorite {
        let list: [CompactMedia]
    }

    struct Similar {
        let list: [CompactMedia]
    }
}
