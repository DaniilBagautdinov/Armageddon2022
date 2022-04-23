//
//  NetworkService.swift
//  Armageddon2022
//
//  Created by Даниил Багаутдинов on 23.04.2022.
//

import Foundation

final class NetworkService {
    let configuration = URLSessionConfiguration.default
    let decoder = JSONDecoder()
    let key = "IQh2wd2JtJHXoUijtmbcuP1AphUOsmTkUgiE4b7O"
    
    func getAsteroids(completion: @escaping (Asteroids) -> Void) {
        let session = URLSession(configuration: self.configuration)
        let date = Date().description.replacingOccurrences(of: " ", with: "%20")
        print("https://api.nasa.gov/neo/rest/v1/feed?start_date=\(date)&api_key=\(key)")
        guard let url = URL(string: "https://api.nasa.gov/neo/rest/v1/feed?start_date=\(date)&api_key=\(key)") else { return }
        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.httpMethod = "GET"
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        session.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let strongSelf = self else { return }
            
            guard let data = data else { return }
            
            do {
                let asteroids = try strongSelf.decoder.decode(Asteroids.self, from: data)
                completion(asteroids)
            } catch {
                print(error)
            }
        }.resume()
    }
}
