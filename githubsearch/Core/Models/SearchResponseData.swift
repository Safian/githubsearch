//
//  SearchClientData.swift
//  githubsearch
//
//  Created by Szabolcs Sáfián on 2022. 08. 06..
//

import Foundation

public struct SearchResponseData: Codable {

    let totalCount: Int
    let incompleteResults: Bool
    let items: [RepositoryResponseData]
    
}
