//
//  DependencyProvider.swift
//  githubsearch
//
//  Created by Szabolcs Sáfián on 2022. 08. 06..
//

import Swinject

class DependencyProvider {

    static let shared = DependencyProvider()

    private let container = Container()
    let assembler: Assembler

    private init() {
        assembler = Assembler(
            [
                NetworkAssembly(),
                ManagerAssembly(),
                ViewModelAssembly()
            ],
            container: container
        )
    }
}

