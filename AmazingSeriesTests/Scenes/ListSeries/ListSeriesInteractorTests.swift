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
    
    func test_loadMoreData_shouldAppendCurrentSeriesList() {
        // Given
        let workerSpy =  GetSeriesWorkerSpy()
        let presenterSpy = ListSeriesPresenterSpy()
        let sut = makeSUT(presenter: presenterSpy, getSeriesWorker: workerSpy)
        let initialData: [ListSeries.Response] = [.mock, .mock, .mock]
        workerSpy.data = [.mock, .mock]
        sut.seriesList = initialData
        
        // When
        sut.loadMoreData()
        
        // Then
        XCTAssertTrue((presenterSpy.data.count == (initialData.count + workerSpy.data.count)), "presenter should have more data than interactor")
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
        searchSeriesWorker: SearchSeriesWorkerProtocol = SearchSeriesWorkerSpy(),
        dispatchQueue: DispatchQueueProtocol = DispatchQueueMock()
    ) -> ListSeriesInteractor {
        .init(presenter: presenter, getSeriesWorker: getSeriesWorker, searchSeriesWorker: searchSeriesWorker, dispatchQueue: dispatchQueue)
    }
}
