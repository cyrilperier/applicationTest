//
//  pictureData.swift
//  applicationTest
//
//  Created by cyril perier on 23/06/2023.
//

import Foundation

struct PixabayResponse: Codable {
    let hits: [PixabayImage]
}

struct PixabayImage: Codable {
    let id: Int
    let pageURL: String
    let type: String
    let tags: String
    let largeImageURL: String
}
