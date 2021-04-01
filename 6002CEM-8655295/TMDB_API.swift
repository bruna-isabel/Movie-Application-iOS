//
//  TMDB_API.swift
//  6002CEM-8655295
//
//  Created by Bruna Coimbra on 23/03/2021.
//

import Foundation

class MoviesAPI {
    
    private var dataTask: URLSessionDataTask?
    
    func fetchMovies(completion: @escaping (Result<MovieList, Error>) -> Void){
        
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=?"
        guard let url = URL(string: urlString) else { return } //avoid optionals
        
        //requests data from api
        dataTask = URLSession.shared.dataTask(with: url)  { (data, response, error) in
            //We get no response from API
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            //Catches Error if something goes wrong
            do {
                //Decodes our whole movie array. All the movies
                let movieDataDecoded = try JSONDecoder().decode(MovieList.self, from: data!)
                //Tells Swift that it's async operation.
                DispatchQueue.main.async {
                    print(movieDataDecoded)
                    completion(.success(movieDataDecoded))
                }
            } catch let error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        //Checks how response is doing
        print("Response status code: \(response.statusCode)")
            
        }
        dataTask?.resume()
    }
    
    
}


/*
    
        //decode json
        let movies = try! JSONDecoder().decode([Movie].self, from: data!)
        //We can interact with the app while running API call
        DispatchQueue.main.async {
            completion(movies) //return our array of movies
        }
}*/
 
