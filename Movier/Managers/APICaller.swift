//
//  APICaller.swift
//  Movier
//
//  Created by Shivam Kumar on 15/08/24.
//

import Foundation

struct Constants{
    static let API_KEY = "173dffdacb24ac69358915dd3b8daaf6"
    static let baseURL = "https://api.themoviedb.org"
    static let Youtube_APIKey = "AIzaSyC7-SNbqG3YHOdzdvdPt60K2g4NlTqwwNU"
    static let youTubeBaseURL = "https://www.googleapis.com/youtube/v3/search?"
}

enum APIError: Error{
    case failedTogetData
}


final class APICaller {
    static let shared = APICaller()
    
    private init(){
        
    }
    
     func getTrendingMovies(completion: @escaping(Result<[Title], Error>) -> Void){
        
        guard let url = URL(string:"\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)")else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url:url)){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do{
                let results = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(results.results))
                
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
    
    func getTrendingTvs(completion: @escaping(Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)")else{return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(results.results))
            }
            catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping  (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=2") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url:url)){ data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    
    func getPopular(completion: @escaping (Result<[Title],Error>)-> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url:url)){ data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getTopRated(completion: @escaping (Result<[Title],Error>)-> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url:url)){ data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Title],Error>)-> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/now_playing?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url:url)){ data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func search(with query : String, completion : @escaping (Result<[Title],Error>)->Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url:url)){ data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getMovie(with query : String, completion : @escaping (Result<VideoElement,Error>)->Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.youTubeBaseURL)q=\(query)&key=\(Constants.Youtube_APIKey)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url:url)){ data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(YouTubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
                
                 
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
        
    }
    
    
    
    
}




