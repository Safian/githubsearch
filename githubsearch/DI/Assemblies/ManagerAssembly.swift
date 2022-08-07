//
//  ManagerAssembly.swift
//  githubsearch
//
//  Created by Szabolcs Sáfián on 2022. 08. 06..
//

import Swinject

class ManagerAssembly: Assembly {

    func assemble(container: Container) {

        container.register(NavigationManager.self) { _ in
            NavigationManager()
        }.inObjectScope(.container)
    }
}
