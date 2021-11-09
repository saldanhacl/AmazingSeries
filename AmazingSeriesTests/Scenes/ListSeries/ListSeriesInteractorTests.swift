//
//  ListSeriesInteractorTests.swift
//  AmazingSeriesTests
//
//  Created by Lucas Honorato Saldanha on 09/11/21.
//

import XCTest
@testable import AmazingSeries

class ListSeriesInteractorTests: XCTestCase {

    func test_onViewDidLoad_shouldCallGetSeriesWorker() {
        // Given
        let workerSpy = GetSeriesWorkerSpy()
        let sut = makeSUT(getSeriesWorker: workerSpy)
        
        // When
        sut.onViewDidLoad()
        
        // Then
        XCTAssert(workerSpy.listShowsCalled, "onViewDidLoad() should call listShows from worker")
    }
    
    func test_loadMoreData_shouldCallGetSeriesWorker() {
        // Given
        let workerSpy = GetSeriesWorkerSpy()
        let sut = makeSUT(getSeriesWorker: workerSpy)
        
        // When
        sut.loadMoreData()
        
        // Then
        XCTAssert(workerSpy.listShowsCalled, "loadMoreData() should call listShows from worker")
    }
    
    func test_searchSeries_shouldCallSearchSeriesWorker() {
        // Given
        let workerSpy = SearchSeriesWorkerSpy()
        let sut = makeSUT(searchSeriesWorker: workerSpy)
        
        // When
        sut.searchSeries(query: "query")
        
        // Then
        XCTAssert(workerSpy.searchCalled, "searchSeries() should call search from worker")
    }
    
    // MARK: Test Helpers
    
    private func makeSUT(
        presenter: ListSeriesPresentationLogic = ListSeriesPresenterSpy(),
        getSeriesWorker: GetSeriesWorkerProtocol = GetSeriesWorkerSpy(),
        searchSeriesWorker: SearchSeriesWorkerProtocol = SearchSeriesWorkerSpy()
    ) -> ListSeriesInteractor {
        .init(presenter: presenter, getSeriesWorker: getSeriesWorker, searchSeriesWorker: searchSeriesWorker)
    }
}
