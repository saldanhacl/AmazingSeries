//
//  DispatchQueue+Protocol.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 09/11/21.
//

import Foundation

extension DispatchQueue: DispatchQueueProtocol {
    func async(execute work: @escaping @convention(block) () -> Void) {
        async(group: nil, qos: .unspecified, flags: [], execute: work)
    }
}
