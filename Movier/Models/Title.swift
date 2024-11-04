//
//  Movie.swift
//  Movier
//
//  Created by Shivam Kumar on 15/08/24.
//

import Foundation

struct Response: Codable{
    let results: [Title]
}

struct Title: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
    let first_air_date: String?
    let original_language : String?
    let adult : Bool?
}

