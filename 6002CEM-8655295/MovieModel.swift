//
//  Movie.swift
//  6002CEM-8655295
//
//  Created by Bruna Coimbra on 18/03/2021.
//

import Foundation

struct MovieList: Decodable {
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Decodable {
    
    let title: String?
    let release_year: String?
    let rating: Double?
    let synopsis: String?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case synopsis = "overview"
        case rating = "vote_average"
        case image = "poster_path"
        case release_year = "release_date"
    }
}

struct MovieGenre: Decodable{
    let name: String?
}



