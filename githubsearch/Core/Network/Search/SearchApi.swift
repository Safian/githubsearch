//
//  SearchApi.swift
//  githubsearch
//
//  Created by Szabolcs Sáfián on 2022. 08. 06..
//

import Foundation

import Combine
import Foundation

/* Api documentation:
 * https://docs.github.com/en/rest/search#search-code
 */

let SEARCH_PAGE_SIZE = 30

public class SearchApi: BaseApi, SearchApiProtocol {

    public func search(with string: String, page: Int) -> AnyPublisher<SearchResponseData, Error> {

        var urlComponents = URLComponents(string: base)!
        urlComponents.path = "/search/repositories"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: string),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "per_page", value: "\(SEARCH_PAGE_SIZE)")
        ]
        let request = URLRequest(url: urlComponents.url!)
        return build(with: request).eraseToAnyPublisher()
    }
}

