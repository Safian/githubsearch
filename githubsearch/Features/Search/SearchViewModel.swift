//
//  SearchViewModel.swift
//  githubsearch
//
//  Created by Szabolcs Sáfián on 2022. 08. 06..
//

import Foundation
import Combine
import Swinject

class SearchViewModel: ObservableObject {

    // MARK: - Dependecies

    @Injected private var searchAPI: SearchApiProtocol

    // MARK: - Variables

    var subscriptions: Set<AnyCancellable> = []
    var isLastPage: Bool { return totalCount < cellDatas.count }
    private var totalCount: Int = 0
    private var incompleteResults: Bool = false

    // MARK: - Published

    @Published private (set) var cellDatas: [SearchCellData] = []
    @Published var searchText: String = String()
    @Published var error: String? = nil

    // MARK: - Initiliazer

    init() {
        $searchText
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            .removeDuplicates()
            .map({ (string) -> String? in
                self.cellDatas = []
                return string
            })
            .compactMap{ $0 }
            .sink { (_) in
            } receiveValue: { [weak self] text in
                self?.searchItems(searchText: text.valueForSearch())
            }.store(in: &subscriptions)
    }

    func loadNextPage() {
        searchItems(searchText: searchText)
    }

    // MARK: - Private functions

    private func searchItems(searchText: String) {
        guard !searchText.isEmpty else { return }
        let page = cellDatas.count > 0 ? cellDatas.count / SEARCH_PAGE_SIZE : 0
        searchAPI.search(with: searchText, page: page)
            .receive(on: DispatchQueue.global(qos: .background))
            .sink(receiveCompletion: { completion in
            switch completion {
            case let .failure(error): self.presentError(error)
            default: break
            }
        }, receiveValue: { [weak self] data in
            self?.createCellDatas(with: data)
        }).store(in: &subscriptions)
    }
    
    private func createCellDatas(with data: SearchResponseData) {
        totalCount = data.totalCount
        cellDatas.append(contentsOf: data.items.map({ item in
            SearchCellData(repositoryUrl: item.htmlUrl,
                           avatarImageUrlString: item.owner.avatarUrl,
                           ownerName: item.owner.login,
                           repositoryName: item.name,
                           descritions: item.description,
                           numberOfStars: item.score,
                           programingLanguage: item.language ?? "")
        }))
    }

    private func presentError(_ error: Error) {
        print("Error: \(error)")
        self.error = error.localizedDescription
    }
}
