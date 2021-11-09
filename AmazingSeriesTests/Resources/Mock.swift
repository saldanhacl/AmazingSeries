//
//  Mock.swift
//  AmazingSeriesTests
//
//  Created by Lucas Honorato Saldanha on 09/11/21.
//

@testable import AmazingSeries

extension ListSeries.Response {
    static let mock = ListSeries.Response(id: 1, name: "Series", rating: .init(average: 8.0), genres: ["GenreA"], premiered: "2021-11-09", image: nil)
}

extension ListSeries.ViewModel {
    static let mock = ListSeries.ViewModel(id: 1, title: "Series", rating: "8.0", genres: "GenreA", posterURL: nil)
}
