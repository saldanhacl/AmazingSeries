//
//  NSObject+ClasName.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation

protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }

     var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}
