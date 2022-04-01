//
//  DataLoader.swift
//  Proyecto
//
//  Created by Borja Martín on 9/3/22.
//

import Foundation

public class DataLoader {
    
    @Published var apiData: ApiData?
    
    
    func fetchFilms(completionHandler: @escaping (ApiData) -> ()) {
        let stringUrl = "https://api.themoviedb.org/3/movie/popular?api_key=9cb0dc93d804b79fa4d51dbf783ef895&language=es-ES&page=1"
        let url = URL(string: stringUrl)!
        let task = URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            let httpResponse = response as? HTTPURLResponse
            if error != nil {
                print("Error with fetching films: \(String(describing: error))")
                return
            }
            guard (200...299).contains(httpResponse!.statusCode)
            else {
                print(response ?? "response error")
                return
            }
            if let films = try? JSONDecoder().decode(ApiData.self, from: data!) { completionHandler(films)
            }
        })
        task.resume()
    }

    
}
