//
//  DispatchQueueProtocol.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 09/11/21.
//

import Foundation

protocol DispatchQueueProtocol {
    func async(execute work: @escaping @convention(block) () -> Void)
}
