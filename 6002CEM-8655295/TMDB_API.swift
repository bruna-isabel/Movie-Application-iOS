//
//  TMDB_API.swift
//  6002CEM-8655295
//
//  Created by Bruna Coimbra on 23/03/2021.
//

import Foundation

class API {
    
    private var dataTask: URLSessionDataTask?

     
    func fetchMovies(completion: @escaping (Result<MovieList, Error>) -> Void){
        
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key="
        //our url string
        guard let url = URL(string: urlString) else { return } //avoid optionals
        
        
        print("Response Status code: HELLO")
        //requests data from api
        dataTask = URLSession.shared.dataTask(with: url)  { (data, response, error) in
            
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            
            
            do {
                //Parse data
                let jsonData = try JSONDecoder().decode(MovieList.self, from: data!)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
                
            } catch let error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
            
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
 
