//
//  BaseApi.swift
//  githubsearch
//
//  Created by Szabolcs Sáfián on 2022. 08. 06..
//

import Foundation

import Foundation
import Combine

public class BaseApi {

    let base = "https://api.github.com"
    let session = URLSession.shared
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    func build<T: Codable>(with request: URLRequest) -> AnyPublisher<T, Error> {
        return session.dataTaskPublisher(for: request)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}

