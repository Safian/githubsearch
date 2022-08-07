//
//  ViewModelAssembly.swift
//  githubsearch
//
//  Created by Szabolcs Sáfián on 2022. 08. 06..
//

import Foundation

import Swinject

class ViewModelAssembly: Assembly {

    func assemble(container: Container) {

        container.register(SearchViewModel.self) { _ in
            SearchViewModel()
        }

        container.register(RepositoryDetailsViewModel.self) { _ in
            RepositoryDetailsViewModel()
        }
    }
}
