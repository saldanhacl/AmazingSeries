//
//  ViewCode.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import UIKit

protocol ViewCode {
    func buildHierarchy()
    func setupConstraints()
}

extension ViewCode {
    func setupView() {
        buildHierarchy()
        setupConstraints()
    }

    func buildHierarchy() {}
    func setupConstraints() {}
}

