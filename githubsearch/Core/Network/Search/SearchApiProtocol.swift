//
//  SearchApiProtocol.swift
//  githubsearch
//
//  Created by Szabolcs Sáfián on 2022. 08. 06..
//

import Foundation
import Combine

let API_KEY = "46bd73f32d5f3a3df602df4ad94cbddb"

public protocol SearchApiProtocol {

    func search(with string: String, page: Int) -> AnyPublisher<SearchResponseData, Error>

}

