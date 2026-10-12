//
//  MangaDexModels.swift
//  MangaReader
//
//  Created by Dimas Putra on 11/10/26.
//

import Foundation

struct MangaListResponse: Decodable {
    let data: [MangaData]
}

struct MangaData: Decodable {
    let id: String
    let attributes: MangaAttributes
    let relationships: [Relationship]
}

struct MangaAttributes: Decodable {
    let title: [String: String]
    let description: [String: String]
}

struct Relationship: Decodable {
    let type: String
    let attributes: RelationshipAttributes?
}

struct RelationshipAttributes: Decodable {
    let fileName: String?
}

extension MangaData {
    func toManga() -> Manga {
        let title =
            attributes.title["en"] ?? attributes.title.values.first
            ?? "untitled"

        let description = attributes.title["en"] ?? attributes.title.values.first

        let coverFileName = relationships.first(where: {
            $0.type == "cover_art"
        })?.attributes?.fileName

        var coverURL: URL? = nil
        if coverFileName != nil {
            coverURL = URL(
                string:
                    "https://uploads.mangadex.org/covers/\(id)/\(coverFileName)/.256.jpg"
            )
        }

        return Manga(
            id: id,
            title: title,
            description: description,
            coverURL: coverURL
        )
    }
}
