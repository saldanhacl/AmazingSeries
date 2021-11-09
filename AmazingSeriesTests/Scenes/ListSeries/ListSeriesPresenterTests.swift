//
//  ListSeriesPresenterTests.swift
//  AmazingSeriesTests
//
//  Created by Lucas Honorato Saldanha on 09/11/21.
//

import XCTest
@testable import AmazingSeries

class ListSeriesPresenterTests: XCTestCase {

    func test_presentSeriesData_shouldCallDisplaySeriesListOnViewController() {
        // Given
        let viewControllerSpy = ListSeriesViewControllerSpy()
        let sut = makeSUT()
        sut.viewController = viewControllerSpy
        
        // When
        sut.presentSeriesData([])
        
        // Then
        XCTAssert(viewControllerSpy.displaySeriesListCalled, "presentSeriesData() should call displaySeriesList from ViewController")
    }
    
    func test_presentSeriesData_shouldCallDisplaySeriesListOnViewController_withCorrectAmountOfData() {
        // Given
        let viewControllerSpy = ListSeriesViewControllerSpy()
        let expectedData: [ListSeries.Response] = [.mock, .mock, .mock]
        let sut = makeSUT()
        sut.viewController = viewControllerSpy
        
        // When
        sut.presentSeriesData(expectedData)
        
        // Then
        XCTAssertEqual(viewControllerSpy.data.count, expectedData.count)
    }
    
    // MARK: Test Helpers
    
    private func makeSUT() -> ListSeriesPresenter {
        .init()
    }
}
