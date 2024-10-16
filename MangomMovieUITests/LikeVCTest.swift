//
//  LikeVCTest.swift
//  MangomMovieUITests
//
//  Created by 박성민 on 10/16/24.
//

import XCTest

final class LikeVCTest: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        let searchTab = app.tabBars.buttons["likeTab"]
        XCTAssertTrue(searchTab.exists, "likeTap이 존재하지 않습니다.")
        searchTab.tap()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testLikeVCRendersUIComponents() throws {
        XCTAssertTrue(app.otherElements["LikeVC"].exists, "LikeVC가 존재하지 않습니다.")
        XCTAssertTrue(app.staticTexts["genreLabel"].exists, "장르 라벨이 존재하지 않습니다.")
        XCTAssertTrue(app.tables["likeTableView"].exists, "찜한 영화 리스트 테이블이 존재하지 않습니다.")
    }
    
    func testGenreLabelText() throws {
        let genreLabel = app.staticTexts["genreLabel"]
        XCTAssertTrue(genreLabel.exists, "장르 라벨이 존재하지 않습니다.")
        XCTAssertEqual(genreLabel.label, "영화 시리즈", "장르 라벨 텍스트가 올바르지 않습니다.")
    }
    
    func testLikeTableViewTap() throws {
        let likeTableView = app.tables["likeTableView"]
        XCTAssertTrue(likeTableView.exists, "찜한 영화 리스트 테이블이 존재하지 않습니다.")
        
        let firstCell = likeTableView.cells.firstMatch
        XCTAssertTrue(firstCell.exists, "첫 번째 셀이 존재하지 않습니다.")
        
        firstCell.tap()
        XCTAssertTrue(app.otherElements["DetailVC"].waitForExistence(timeout: 2), "상세 뷰가 표시되지 않았습니다.")
    }
    
    func testLikeVCSwipeToDelete() throws {
        let likeTableView = app.tables["likeTableView"] // 테이블 뷰에 대한 접근
        XCTAssertTrue(likeTableView.exists, "좋아요 테이블 뷰가 존재하지 않습니다.")
        
        let firstCell = likeTableView.cells.firstMatch
        XCTAssertTrue(firstCell.exists, "첫 번째 셀이 존재하지 않습니다.")
        
        firstCell.swipeLeft() // 셀을 왼쪽으로 스와이프
        let deleteButton = firstCell.buttons["삭제"] // 삭제 버튼 찾기
        XCTAssertTrue(deleteButton.exists, "삭제 버튼이 존재하지 않습니다.")
        
        deleteButton.tap() // 삭제 버튼 탭

        // 삭제 후 첫 번째 셀이 여전히 존재하지 않는지 확인
        XCTAssertFalse(firstCell.exists, "첫 번째 셀이 여전히 존재합니다. 삭제되지 않았습니다.")
    }
}
