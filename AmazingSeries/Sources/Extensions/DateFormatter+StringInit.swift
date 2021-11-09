//
//  DateFormatter+StringInit.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 08/11/21.
//

import Foundation

extension DateFormatter {
    convenience init (format: String) {
        self.init()
        dateFormat = format
        locale = Locale.current
    }
}
