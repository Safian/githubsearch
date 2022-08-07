//
//  String+Extensions.swift
//  githubsearch
//
//  Created by Szabolcs Sáfián on 2022. 08. 07..
//

import Foundation

extension String {

    /// Removes unwanted special characters from the string for search calls
    ///
    /// Trimming string and remove unwanted characters - numeric characters and spaces remain in the string

    func valueForSearch() -> String {
        var set = CharacterSet.alphanumerics
        set.insert(" ")
        let unsafeChars = set.inverted
        return self.trimmingCharacters(in: .whitespaces).components(separatedBy: unsafeChars).joined(separator: "")
    }
}
