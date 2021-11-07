//
//  DependencyInjection.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation

@propertyWrapper
struct Dependency<T> {
    private(set) var resolvedValue: T?
    
    public var wrappedValue: T {
        guard let resolvedValue = resolvedValue else {
            preconditionFailure("Attempted to resolve \(type(of: self)), but there's nothing registered for this type.")
        }
        
        return resolvedValue
    }
    
    public init() {
        if let value = DependencyContainer.resolve(forMetaType: T.self) {
            resolvedValue = value
        }
    }
}

final class DependencyContainer {
    private var dependencies = [String: AnyObject]()
    private static var shared = DependencyContainer()

    static func register<T>(_ dependency: T, forMetaType metaType: T.Type) {
        shared.register(dependency, metaType)
    }

    static func resolve<T>(forMetaType metaType: T.Type) -> T? {
        shared.resolve(metaType)
    }

    private func register<T>(_ dependency: T, _ metaType: T.Type) {
        let key = String(describing: metaType)
        dependencies[key] = dependency as AnyObject
    }

    private func resolve<T>(_ metaType: T.Type) -> T? {
        let key = String(describing: metaType)
        let dependency = dependencies[key] as? T
        return dependency
    }
}
