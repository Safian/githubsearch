//
//  RepositoryDetailsViewModel.swift
//  githubsearch
//
//  Created by Szabolcs Sáfián on 2022. 08. 07..
//

import Combine

class RepositoryDetailsViewModel: ObservableObject {

    // MARK: - Published

    @Published var urlString: String = String()

    // MARK: - Variables

    var subscriptions: Set<AnyCancellable> = []
}
