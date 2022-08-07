//
//  NetworkAssembly.swift
//  githubsearch
//
//  Created by Szabolcs Sáfián on 2022. 08. 06..
//

import Swinject

class NetworkAssembly: Assembly {

    func assemble(container: Container) {
        container.register(SearchApiProtocol.self) { _ in
            SearchApi()
        }.inObjectScope(.container)
    }
}
