//
//  MangaDexClient.swift
//  MangaReader
//
//  Created by Dimas Putra on 11/10/26.
//

import Foundation

struct MangaDexClient {
    func searchManga(title: String) async throws -> [Manga] {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.mangadex.org"
        components.path = "/manga"
        components.queryItems = [
            URLQueryItem(name: "limit", value: String(20)),
            URLQueryItem(name: "includes[]", value: "cover_art")
        ]
        if (!title.isEmpty){
            components.queryItems?.append(URLQueryItem(name: "title", value: title))
        }
        
        
        guard let mangaDexURL = components.url else {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession.shared.data(from: mangaDexURL)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(MangaListResponse.self, from: data)
        
        return decoded.data.map({$0.toManga()})
    }
}
