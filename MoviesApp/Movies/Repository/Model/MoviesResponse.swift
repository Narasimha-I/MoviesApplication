//
//  MoviesResponse.swift
//  Movies
//
//  Created by MAC on 25/01/22.
//

import Foundation



// MARK: - FlickerSearchResonce
struct FlickerSearchResponce: Codable {
    let photos: Photos
    let stat: String
}

// MARK: - Photos
struct Photos: Codable {
    let page, pages, perpage, total: Int
    let photo: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
}

//// MARK: - MoviesResponse
//struct MoviesResponse: Codable {
//    let page: Int
//    let results: [Result]
//    let totalPages, totalResults: Int
//
//    enum CodingKeys: String, CodingKey {
//        case page, results
//        case totalPages = "total_pages"
//        case totalResults = "total_results"
//    }
//}
//
//// MARK: - Result
//struct Result: Codable {
//    let adult: Bool?
//    let backdropPath: String?
//    let genreIDS: [Int]?
//    let id: Int
//    let originalLanguage: String?
//    let originalTitle, overview: String?
//    let popularity: Double?
//    let posterPath, releaseDate, title: String?
//    let video: Bool?
//    let voteAverage: Double?
//    let voteCount: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case adult
//        case backdropPath = "backdrop_path"
//        case genreIDS = "genre_ids"
//        case id
//        case originalLanguage = "original_language"
//        case originalTitle = "original_title"
//        case overview, popularity
//        case posterPath = "poster_path"
//        case releaseDate = "release_date"
//        case title, video
//        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
//    }
//}
//
//
