//
//  Spies.swift
//  AmazingSeriesTests
//
//  Created by Lucas Honorato Saldanha on 09/11/21.
//

import Foundation
@testable import AmazingSeries

final class ListSeriesPresenterSpy: ListSeriesPresentationLogic {
    var presentSeriesDataCalled = false
    var data: [ListSeries.Response] = []
    
    func presentSeriesData(_ data: [ListSeries.Response]) {
        presentSeriesDataCalled = true
        self.data = data
    }
}

final class ListSeriesViewControllerSpy: ListSeriesDisplayLogic {
    var displaySeriesListCalled = false
    var data: [ListSeries.ViewModel] = []
    
    func displaySeriesList(_ data: [ListSeries.ViewModel]) {
        displaySeriesListCalled = true
        self.data = data
    }
}

final class ListSeriesRouterSpy: ListSeriesRoutingLogic {
    var goToSeriesDetailsCalled = false
    
    func goToSeriesDetails(id: Int) {
        goToSeriesDetailsCalled = true
    }

}

final class ListSeriesInteractorSpy: ListSeriesBusinessLogic {
    var onViewDidLoadCalled = false
    var loadMoreDataCalled = false
    var searchSeriesCalled = false
    
    var searchQuery: String = ""

    func onViewDidLoad() {
        onViewDidLoadCalled = true
    }
    
    func loadMoreData() {
        loadMoreDataCalled = true
    }
    
    func searchSeries(query: String) {
        searchSeriesCalled = true
        searchQuery = query
    }
}

final class GetSeriesWorkerSpy: GetSeriesWorkerProtocol {
    var listShowsCalled = false
    var data: [ListSeries.Response] = []

    func listShows(page: Int, handle: @escaping (Result<[ListSeries.Response], ListSeries.RequestError>) -> Void) {
        listShowsCalled = true
        handle(.success(data))
    }
}

final class SearchSeriesWorkerSpy: SearchSeriesWorkerProtocol {
    var searchCalled = false
    var data: [SearchSeries.Response] = []

    func search(by query: String, handle: @escaping (Result<[SearchSeries.Response], SearchSeries.RequestError>) -> Void) {
        searchCalled = true
        handle(.success(data))
    }
}

