//
//  Injected.swift
//  githubsearch
//
//  Created by Szabolcs Sáfián on 2022. 08. 06..
//

import Swinject

@propertyWrapper
struct Injected<T> {
    private let resolver = (DependencyProvider.shared.assembler.resolver as! Container).synchronize() // swiftlint:disable:this force_cast line_length

    init() {}

    lazy var wrappedValue: T = {
        return resolver.resolve(T.self)!
    }()
}
