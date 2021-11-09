//
//  String+ToDate.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 08/11/21.
//

import Foundation

extension String {
    func toDate (dateFormatter: DateFormatter) -> Date? {
        return dateFormatter.date(from: self)
    }
}
