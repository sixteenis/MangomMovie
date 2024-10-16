//
//  TrendingVCTest.swift
//  MangomMovieUITests
//
//  Created by 박성민 on 10/16/24.
//

import XCTest

final class TrendingVCTest: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    func testTrendingVCRendersUIComponents() throws {
        XCTAssertTrue(app.scrollViews["TrendingScrollView"].exists, "ScrollView가 존재하지 않습니다.")
        XCTAssertTrue(app.buttons["playButton"].exists, "재생 버튼이 존재하지 않습니다.")
        XCTAssertTrue(app.buttons["listButton"].exists, "찜하기 버튼이 존재하지 않습니다.")
        XCTAssertTrue(app.collectionViews["nowMovieCollection"].exists, "영화 컬렉션이 표시되지 않습니다.")
        XCTAssertTrue(app.collectionViews["nowTVCollection"].exists, "TV 컬렉션이 표시되지 않습니다.")
    }
    
    // 재생 버튼을 눌렀을 때 알림이 표시되는지 테스트합니다.
    func testPlayButtonTap() throws {
        let listButton = app.buttons["listButton"]
        XCTAssertTrue(listButton.exists, "저장 버튼 비활성화.")
        
        listButton.tap()
        
        XCTAssertTrue(app.otherElements["CustomAlert"].waitForExistence(timeout: 2), "경고창이 나타나지 않았습니다.")
    }

    // 스크롤 뷰의 상하 스크롤을 테스트합니다.
    func testScrollViewContent() throws {
        let scrollView = app.scrollViews["TrendingScrollView"]
        XCTAssertTrue(scrollView.exists, "ScrollView가 존재하지 않습니다.")
        
        scrollView.swipeUp()
        scrollView.swipeDown()
    }

    // 영화 컬렉션 셀을 누르면 상세 뷰로 이동하는지 테스트합니다.
    func testMovieCellTap() throws {
        let firstMovieCell = app.collectionViews["nowMovieCollection"].cells.firstMatch
        XCTAssertTrue(firstMovieCell.exists, "첫 번째 영화 셀이 존재하지 않습니다.")
        
        firstMovieCell.tap()
        
        // 상세 뷰로 이동했는지 확인합니다 (뷰에 맞게 identifier를 설정해야 합니다).
        XCTAssertTrue(app.otherElements["DetailVC"].waitForExistence(timeout: 2), "상세 뷰가 표시되지 않았습니다.")
    }

}
