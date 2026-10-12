//
//  Manga.swift
//  MangaReader
//
//  Created by Dimas Putra on 11/10/26.
//

import Foundation

struct Manga: Identifiable, Hashable {
    let id: String
    let title: String
    let description: String?
    let coverURL: URL?
}

struct Chapter: Identifiable, Hashable {
    let id: String
    let number: String?
    let title: String?
}
