//
//  MovieView.swift
//  6002CEM-8655295
//
//  Created by Bruna Coimbra on 24/03/2021.
//

import Foundation

class MovieView {
    
    private var TMDB_API = MoviesAPI()
    private var movies = [Movie]()
    
    func fetchMoviesData(completion: @escaping () -> ()) {
        
        TMDB_API.fetchMovies { [weak self] (movie) in
            
            switch movie {
            case .success(let listOfMovies):
                self?.movies = listOfMovies.movies
                completion()
            case .failure(let error):
                print("Error: \(error)")
            }
            
        }
    }
    
    //How many movies to put in initial page
    func rowsInSection(section: Int) -> Int {
        if movies.count != 0 {
            return movies.count
        }
        return 0
    }
    
    func cellForRow (indexPath: IndexPath) -> Movie {
        return movies[indexPath.row]
    }
}
