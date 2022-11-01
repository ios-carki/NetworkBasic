//
//  SearchBeer.swift
//  NetworkBasic
//
//  Created by Carki on 2022/11/01.
//

import Foundation

struct SearchBeer: Codable, Hashable {
    let name: String
    let imageURLs: URL
    let description: String
}
