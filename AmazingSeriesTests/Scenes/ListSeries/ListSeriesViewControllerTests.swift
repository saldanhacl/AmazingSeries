//
//  ListSeriesViewControllerTests.swift
//  AmazingSeriesTests
//
//  Created by Lucas Honorato Saldanha on 09/11/21.
//

import XCTest
@testable import AmazingSeries

class ListSeriesViewControllerTests: XCTestCase {

    func test_viewDidLoad_shouldCallOnViewDidLoadFromInteractor() {
        // Given
        let interactorSpy = ListSeriesInteractorSpy()
        let sut = makeSUT(interactor: interactorSpy)
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssert(interactorSpy.onViewDidLoadCalled, "viewDidLoad() should call onViewDidLoad from Interactor")
    }
    
    func test_fetchMoredData_shouldCallLoadMoreDataFromInteractor() {
        // Given
        let interactorSpy = ListSeriesInteractorSpy()
        let sut = makeSUT(interactor: interactorSpy)
        
        // When
        sut.fetchMoredData()
        
        // Then
        XCTAssert(interactorSpy.loadMoreDataCalled, "fetchMoredData() should call loadMoreData from Interactor")
    }
    
    func test_didChangeSearchQuery_shouldCallSearchSeriesInteractor() {
        // Given
        let interactorSpy = ListSeriesInteractorSpy()
        let sut = makeSUT(interactor: interactorSpy)
        
        // When
        sut.didChangeSearchQuery("")
        
        // Then
        XCTAssert(interactorSpy.searchSeriesCalled, "didChangeSearchQuery() should call searchSeries from Interactor")
    }
    
    func test_didSelectSeries_shouldCallgoToSeriesDetailsFromRouter() {
        // Given
        let routerSpy = ListSeriesRouterSpy()
        let sut = makeSUT(router: routerSpy)
        
        // When
        sut.didSelectSeries(id: 0)
        
        // Then
        XCTAssert(routerSpy.goToSeriesDetailsCalled, "didSelectSeries() should call goToSeriesDetails from Router")
    }
    
    // MARK: Test Helpers
    
    private func makeSUT(
        interactor: ListSeriesBusinessLogic = ListSeriesInteractorSpy(),
        router: ListSeriesRoutingLogic = ListSeriesRouterDummy()
    ) -> ListSeriesViewController {
        .init(interactor: interactor, router: router)
    }
}
