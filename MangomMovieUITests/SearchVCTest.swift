//
//  SearchVCTest.swift
//  MangomMovieUITests
//
//  Created by 박성민 on 10/16/24.
//

import XCTest

final class SearchVCTest: XCTestCase {
    
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
            continueAfterFailure = false
            app.launch()

            // '검색' 탭 선택 (예: "검색"으로 라벨된 탭)
            let searchTab = app.tabBars.buttons["searchTab"]
            XCTAssertTrue(searchTab.exists, "검색 탭이 존재하지 않습니다.")
            searchTab.tap()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testSearchVCRendersUIComponents() throws {
        XCTAssertTrue(app.otherElements["SearchVC"].exists, "SearchVC가 존재하지 않습니다.")
        XCTAssertTrue(app.textFields["searchView"].exists, "검색창이 존재하지 않습니다.")
        XCTAssertTrue(app.staticTexts["genreLabel"].exists, "장르 라벨이 존재하지 않습니다.")
        XCTAssertTrue(app.collectionViews["recommendCollection"].exists, "추천 컬렉션이 존재하지 않습니다.")
    }

    func testSearchFieldInput() throws {
        let searchField = app.textFields["searchView"]
        XCTAssertTrue(searchField.exists, "검색창이 존재하지 않습니다.")
        
        searchField.tap()
        searchField.typeText("영화")
        
        XCTAssertEqual(searchField.value as? String, "영화", "검색 텍스트가 입력되지 않았습니다.")
    }

    func testRecommendCollectionTap() throws {
        let recommendCollection = app.collectionViews["recommendCollection"]
        XCTAssertTrue(recommendCollection.exists, "추천 컬렉션이 존재하지 않습니다.")
        
        let firstCell = recommendCollection.cells.firstMatch
        XCTAssertTrue(firstCell.exists, "첫 번째 셀이 존재하지 않습니다.")
        
        firstCell.tap()
        XCTAssertTrue(app.otherElements["DetailVC"].waitForExistence(timeout: 2), "상세 뷰가 표시되지 않았습니다.")
    }

    func testSearchCollectionTap() throws {
        let searchField = app.textFields["searchView"]
        XCTAssertTrue(searchField.exists, "검색창이 존재하지 않습니다.")
        
        searchField.tap()
        searchField.typeText("영화")
        let searchCollection = app.collectionViews["searchCollection"]
        XCTAssertTrue(searchCollection.exists, "검색 결과 컬렉션이 존재하지 않습니다.")
        
        let firstCell = searchCollection.cells.firstMatch
        XCTAssertTrue(firstCell.exists, "첫 번째 검색 결과 셀이 존재하지 않습니다.")
        
        firstCell.tap()
        XCTAssertTrue(app.otherElements["DetailVC"].waitForExistence(timeout: 2), "상세 뷰가 표시되지 않았습니다.")
    }

    func testGenreLabelText() throws {
        let genreLabel = app.staticTexts["genreLabel"]
        XCTAssertTrue(genreLabel.exists, "장르 라벨이 존재하지 않습니다.")
        XCTAssertEqual(genreLabel.label, "추천 시리즈 & 영화", "장르 라벨 텍스트가 올바르지 않습니다.")
    }
}
